package subject;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

       
        // 1. 入力値を取得        
        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        // 2. セッションからTeacher取得
        
        Teacher teacher = (Teacher) req.getSession().getAttribute("teacher");
        School school = teacher.getSchool();

        SubjectDAO dao = new SubjectDAO();

        boolean hasError = false;

        
        // 3. 入力チェック
        

        // 科目コード：3文字チェック
        if (cd == null || cd.length() != 3) {
            req.setAttribute("error_cd", "科目コードは3文字で入力してください");
            hasError = true;
        }

        // 科目コード：重複チェック
        if (cd != null && dao.get(cd, school) != null) {
            req.setAttribute("error_cd", "このコードは既に存在しています");
            hasError = true;
        }

        // 科目名：未入力チェック
        if (name == null || name.isEmpty()) {
            req.setAttribute("error_name", "科目名を入力してください");
            hasError = true;
        }

        
        // 4. エラーがある場合
        
        if (hasError) {

            // 入力値を保持
            req.setAttribute("cd", cd);
            req.setAttribute("name", name);

            // 入力画面へ戻る
            req.getRequestDispatcher("subject_create.jsp").forward(req, res);
            return;
        }

        
        // 5. DB登録
        
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(school);

        dao.insert(subject);

        
        // 6. 完了画面へ遷移
        
        req.setAttribute("cd", cd);
        req.setAttribute("name", name);

        req.getRequestDispatcher("subject_create_done.jsp").forward(req, res);
    }
}