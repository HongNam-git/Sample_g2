package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                          HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("Login.action");
            
        }

        String cd = request.getParameter("cd");

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setSchool(teacher.getSchool());
        

        SubjectDAO dao = new SubjectDAO();
        boolean success = dao.delete(subject);
        

        if (success) {
            request.getRequestDispatcher("subject_delete_done.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error", "削除に失敗しました");
            request.getRequestDispatcher("subject_list.jsp")
                   .forward(request, response);
        }

        
    }
}