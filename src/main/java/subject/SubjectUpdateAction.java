package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                          HttpServletResponse response) throws Exception {

        
        // 1. SESSION
        
        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("../Login.action");
            
        }
       
        // 2. PARAMETER      
        String cd = request.getParameter("cd");

        
        // 3. GET SUBJECT       
        SubjectDAO dao = new SubjectDAO();
        Subject subject = dao.get(cd, teacher.getSchool());
      
        // 4. SET ATTRIBUTE       
        request.setAttribute("subject", subject);
        
        // 5. FORWARD       
        request.getRequestDispatcher("subject_update.jsp")
               .forward(request, response);

        
    }
}