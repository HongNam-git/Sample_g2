package subject;

import java.util.List;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                          HttpServletResponse response) throws Exception {

        
        // 1. SESSION
        
        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("../Login.action");
            
        }

        
        // 2. LAY DATA
        
        SubjectDAO dao = new SubjectDAO();
        List<Subject> list = dao.filter(teacher.getSchool());
        

        request.setAttribute("subjectList", list);
        //forward sang jsp
        request.getRequestDispatcher("subject_list.jsp")
               .forward(request, response);

       
    }
}


