package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectDeleteAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                          HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("Login.action");
            
        }

        String cd = request.getParameter("cd");

        SubjectDAO dao = new SubjectDAO();
        Subject subject = dao.get(cd, teacher.getSchool());
       

        request.setAttribute("subject", subject);

        request.getRequestDispatcher("subject_delete.jsp")
               .forward(request, response);

        
    }
}