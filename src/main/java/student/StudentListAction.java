package student;

import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // セッション取得
        HttpSession session = request.getSession(false);

        // セッション切れ対策
        if (session == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // ログイン教師取得
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // teacher が無い場合
        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // 共通データ
        ClassNumDAO classDao = new ClassNumDAO();
        List<ClassNum> classList = classDao.filter(teacher.getSchool());
        request.setAttribute("classList", classList);

        int currentYear = java.time.LocalDate.now().getYear();
        List<Integer> entYearSet = new ArrayList<>();

        for (int i = currentYear - 10; i <= currentYear; i++) {
            entYearSet.add(i);
        }

        request.setAttribute("ent_year", entYearSet);

        // DAO
        StudentDAO studentDao = new StudentDAO();

        // パラメータ取得
        String f1 = request.getParameter("f1"); // 入学年度
        String f2 = request.getParameter("f2"); // クラス
        String f3 = request.getParameter("f3"); // 在学中

        // 値変換
        int entYear =
                (f1 == null || f1.isEmpty())
                ? 0
                : Integer.parseInt(f1);

        String classNum =
                (f2 == null || f2.isEmpty())
                ? null
                : f2;

        boolean isAttend = (f3 != null);

        List<Student> studentList;

        // クラス単独選択禁止
        if (entYear == 0
                && classNum != null
                && !classNum.isEmpty()) {

            request.setAttribute(
                    "error",
                    "クラスだけ選択することはできません。入学年度を選択してください。"
            );

            studentList =
                    studentDao.filter(
                            teacher.getSchool(),
                            isAttend
                    );

        } else {

            // 入学年度 + クラス
            if (entYear != 0 && classNum != null) {

                studentList =
                        studentDao.filter(
                                teacher.getSchool(),
                                entYear,
                                classNum,
                                isAttend
                        );

            // 入学年度のみ
            } else if (entYear != 0) {

                studentList =
                        studentDao.filter(
                                teacher.getSchool(),
                                entYear,
                                isAttend
                        );

            // 全件
            } else {

                studentList =
                        studentDao.filter(
                                teacher.getSchool(),
                                isAttend
                        );
            }
        }

        // JSPへ渡す
        request.setAttribute("list", studentList);
        request.setAttribute("total", studentList.size());

        request.setAttribute("f1", f1);
        request.setAttribute("f2", f2);
        request.setAttribute("f3", isAttend);

        // 画面遷移
        request.getRequestDispatcher("student_list.jsp")
               .forward(request, response);
    }
}