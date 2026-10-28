package test;

import java.time.LocalDate;

import bean.School;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        // セッション取得
        HttpSession session = req.getSession(false);

        Teacher teacher =
                (session != null)
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

        // クラス一覧
        ClassNumDAO classDao = new ClassNumDAO();
        req.setAttribute("classList", classDao.filter(school));

        // 科目一覧
        SubjectDAO subjectDao = new SubjectDAO();
        req.setAttribute("subjectList", subjectDao.filter(school));

        // =========================
        // 初期メッセージ（2つ表示）
        // =========================

        req.setAttribute(
                "subject_error",
                "入学年度とクラスと科目を選択してください"
        );

        req.setAttribute(
                "guide_message",
                "科目情報を選択または学生情報を入力して検索ボタンをクリックしてください"
        );

        // 画面表示
        req.getRequestDispatcher("test_list.jsp")
           .forward(req, res);
    }
}