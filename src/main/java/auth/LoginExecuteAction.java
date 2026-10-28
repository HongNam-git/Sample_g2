package auth;

import bean.Teacher;
import dao.TeacherDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class LoginExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req,
                        HttpServletResponse res)
                        throws Exception {

        try {

            // 1. 情報を取り出す
            String id = req.getParameter("id");
            String password =
                req.getParameter("password");

            // 2.  DAO呼び出す
            TeacherDAO dao = new TeacherDAO();

            Teacher teacher =
                dao.findByIdAndPassword(id, password);

            // 3. login成功
            if (teacher != null) {

                req.getSession()
                   .setAttribute("teacher", teacher);

                res.sendRedirect("menu.jsp");

            } else {

                // login失敗
                req.setAttribute(
                    "error",
                    "ログイン失敗しました。IDまたはパスワードが正しくありません"
                );

                req.getRequestDispatcher("login.jsp")
                   .forward(req, res);
            }

        } catch (Exception e) {
        	e.printStackTrace();
        	req.getSession().removeAttribute("teacher");

            // DB接続エラーなど
            req.setAttribute(
                "error",
                "エラーが発生しました"
            );

            req.getRequestDispatcher("error.jsp")
               .forward(req, res);

        }

    }
}