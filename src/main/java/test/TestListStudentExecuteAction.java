package test;

import java.time.LocalDate;
import java.util.List;

import bean.Student;
import bean.Teacher;
import bean.TestListStudent;
import dao.ClassNumDAO;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestListStudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class TestListStudentExecuteAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        // ログインユーザー取得
        Teacher teacher =
                (Teacher) request.getSession().getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("Login.action");
            return;
        }

        // プルダウン用データ取得
        int currentYear = LocalDate.now().getYear();
        request.setAttribute("currentYear", currentYear);

        ClassNumDAO classDao = new ClassNumDAO();
        SubjectDAO subjectDao = new SubjectDAO();

        request.setAttribute("classList", classDao.filter(teacher.getSchool()));
        request.setAttribute("subjectList", subjectDao.filter(teacher.getSchool()));

        // 学生番号取得
        String studentNo = request.getParameter("student_no");
        request.setAttribute("student_no", studentNo);

        // 入力チェック（未入力）
        if (studentNo == null || studentNo.isEmpty()) {

            request.setAttribute("error", "このフィールドに入力してください");

            request.getRequestDispatcher("test_list_student.jsp")
                    .forward(request, response);
            return;
        }

        // 学生情報取得
        StudentDAO studentDao = new StudentDAO();
        Student student = studentDao.get(studentNo, teacher.getSchool());

        if (student == null) {

            request.setAttribute("student_error", "学生が存在しません");

            request.getRequestDispatcher("test_list_student.jsp")
                    .forward(request, response);
            return;
        }

        // 成績データ取得
        TestListStudentDAO dao = new TestListStudentDAO();

        List<TestListStudent> testList =
                dao.filter(student);

        // JSPへデータ渡し
        request.setAttribute("student", student);
        request.setAttribute("testList", testList);

        // 成績なしの場合
        if (testList.isEmpty()) {
            request.setAttribute(
                    "student_error",
                    "成績情報が存在しませんでした"
            );
        }

        // 画面遷移
        request.getRequestDispatcher("test_list_student.jsp")
                .forward(request, response);
    }
}