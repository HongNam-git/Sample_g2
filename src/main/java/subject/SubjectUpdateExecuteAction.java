package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request,
                          HttpServletResponse response) throws Exception {

       
        // 1. SESSION + TEACHER
        
        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("Login.action");
           
        }

        
        // 2. FORM からPARAMETER
        
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

       
        // 3. VALIDATE
        boolean hasError = false;

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("nameError", "このフィールドを入力してください");
            hasError = true;
        }

        //error の場合 subject_update.jsp に戻る
        if (hasError) {

            Subject subject = new Subject();
            subject.setCd(cd);
            subject.setName(name);
            subject.setSchool(teacher.getSchool());

            request.setAttribute("subject", subject);

            request.getRequestDispatcher("subject_update.jsp")
                   .forward(request, response);

           
        }

        
        // 4. OBJECT を作成
        
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(teacher.getSchool());
        
        
        // 5. UPDATE DB
        SubjectDAO dao = new SubjectDAO();
        boolean success = dao.update(subject);

        
        // 6. update の SUCCESS / FAIL
        if (success) {
            request.getRequestDispatcher("subject_update_done.jsp")
                   .forward(request, response);
            
        } else {
            request.setAttribute("error", "更新に失敗しました");

            request.setAttribute("subject", subject);

            request.getRequestDispatcher("subject_update.jsp")
                   .forward(request, response);
            
        }
    }
}