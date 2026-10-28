package student;
import java.util.List;

import bean.ClassNum;
import bean.Teacher;
import dao.ClassNumDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentCreateAction extends Action {
	
	@Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // 1. lay session
        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // check login
        if (teacher == null) {
            response.sendRedirect("Login.action");
        }

        // 2. lay danh sach class tu db
        ClassNumDAO classDao = new ClassNumDAO();
        List<ClassNum> classList = classDao.filter(teacher.getSchool());
        request.setAttribute("classList", classList);

        // 3. forward sang form create
        request.getRequestDispatcher("student_create.jsp")
               .forward(request, response);

        
    }

}
