package student;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ==========================================
        // 1. SESSION CHECK (Đã sửa lỗi NullPointerException)
        // ==========================================
        HttpSession session = request.getSession();
        
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect("../auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // ==========================================
        // 2. GET STUDENT NO
        // ==========================================
        String no = request.getParameter("no");

        if (no == null || no.trim().isEmpty()) {
            request.setAttribute("error", "学生番号が不正です");
            request.getRequestDispatcher("student_list.jsp")
                   .forward(request, response);
            return;
        }

        // ==========================================
        // 3. LOAD STUDENT FROM DB
        // ==========================================
        StudentDAO studentDao = new StudentDAO();
        Student student = studentDao.get(no, teacher.getSchool());

        if (student == null) {
            request.setAttribute("error", "学生が存在しません");
            request.getRequestDispatcher("student_list.jsp")
                   .forward(request, response);
            return;
        }

        // ==========================================
        // 4. LOAD CLASS LIST (Đưa danh sách lớp vào Select-box)
        // ==========================================
        ClassNumDAO classDao = new ClassNumDAO();
        request.setAttribute("classList", classDao.filter(teacher.getSchool()));

        // ==========================================
        // 5. SET DATA TO REQUEST
        // ==========================================
        request.setAttribute("student", student);

        // ==========================================
        // 6. FORWARD TO JSP
        // ==========================================
        request.getRequestDispatcher("student_update.jsp")
               .forward(request, response);
    }
}