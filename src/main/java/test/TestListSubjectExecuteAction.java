package test;

import java.time.LocalDate;
import java.util.List;

import bean.School;
import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.ClassNumDAO;
import dao.SubjectDAO;
import dao.TestListSubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListSubjectExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        // セッション取得
        HttpSession session = req.getSession(false);

        Teacher teacher = (session != null)
                ? (Teacher) session.getAttribute("teacher")
                : null;

        // ログインチェック
        if (teacher == null) {
            res.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        // 現在年度
        int currentYear = LocalDate.now().getYear();
        req.setAttribute("currentYear", currentYear);

        // プルダウン用
        ClassNumDAO classDao = new ClassNumDAO();
        SubjectDAO subjectDao = new SubjectDAO();

        req.setAttribute("classList", classDao.filter(school));
        req.setAttribute("subjectList", subjectDao.filter(school));

        // パラメータ取得
        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");
        String subjectCd = req.getParameter("subject_cd");

        // 入力値保持
        req.setAttribute("ent_year", entYearStr);
        req.setAttribute("class_num", classNum);
        req.setAttribute("subject_cd", subjectCd);

        // 入力チェック
        if (entYearStr == null || entYearStr.isEmpty()
                || classNum == null || classNum.isEmpty()
                || subjectCd == null || subjectCd.isEmpty()) {

            req.setAttribute(
                    "subject_error",
                    "入学年度とクラスと科目を選択してください");

            req.getRequestDispatcher("test_list.jsp")
                    .forward(req, res);

            return;
        }

        // 型変換
        int entYear = Integer.parseInt(entYearStr);

        // 科目Bean
        Subject subject = new Subject();
        subject.setCd(subjectCd);

        // 成績一覧取得
        TestListSubjectDAO dao = new TestListSubjectDAO();

        List<TestListSubject> testList =
                dao.filter(entYear, classNum, subject, school);

        // 検索結果なし
        if (testList.isEmpty()) {

            req.setAttribute(
                    "error",
                    "学生情報が存在しませんでした");

            req.getRequestDispatcher("test_list.jsp")
                    .forward(req, res);

            return;
        }

        // JSPへ渡す
        req.setAttribute("testList", testList);

        // 画面表示
        req.getRequestDispatcher("test_list_subject.jsp")
                .forward(req, res);
    }
}