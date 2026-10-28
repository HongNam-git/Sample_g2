package auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LogoutAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession(false);

        // nếu có session thì xóa
        if (session != null) {
            session.invalidate();
        }

        // luôn chuyển về logout.jsp
        request.getRequestDispatcher("logout.jsp").forward(request, response);

        
    }
}