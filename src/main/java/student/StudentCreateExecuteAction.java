package student;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        // =========================
        // 1. LẤY SESSION + TEACHER
        // =========================
        HttpSession session = request.getSession(false);
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        if (teacher == null) {
            response.sendRedirect("Login.action");
            
        }

        // =========================
        // 2. LAY DU LIEU DUOC GUI TU FORM
        // =========================
        String entYearStr = request.getParameter("entYear");
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String classNum = request.getParameter("classNum");

        // =========================
        // 3. KIEM TRA XEM NGUOI DUNG NHAP DUNG CHUA
        // =========================
        boolean hasError = false;

        // 入学年度
        if (entYearStr == null || entYearStr.trim().isEmpty()) {
            request.setAttribute("entYearError", "入学年度を選択してください");
            hasError = true;
        }

        // 学生番号
        if (no == null || no.trim().isEmpty()) {
            request.setAttribute("noError", "このフィールドを入力してください");
            hasError = true;
        }

        // 氏名
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("nameError", "このフィールドを入力してください");
            hasError = true;
        }

        // クラス
        if (classNum == null || classNum.trim().isEmpty()) {
            request.setAttribute("classError", "このフィールドを入力してください");
            hasError = true;
        }

        // NEU CO LOI QUAY LAI FORM
        if (hasError) {

            // giữ lại dữ liệu
            request.setAttribute("entYear", entYearStr);
            request.setAttribute("no", no);
            request.setAttribute("name", name);
            request.setAttribute("classNum", classNum);

            // LAY DNAH SACH CLASS TU dB
            ClassNumDAO classDao = new ClassNumDAO();
            request.setAttribute("classList", classDao.filter(teacher.getSchool()));
            request.getRequestDispatcher("student_create.jsp")
                   .forward(request, response);
           
        }

        // =========================
        // 4. CHECK TRÙNG 学生番号
        // =========================
        StudentDAO dao = new StudentDAO();

        if (dao.get(no,teacher.getSchool()) != null) {
        	

        	request.setAttribute("noError", "学生番号が重複しています");

            // giu lai du lieu ma nguoi dung nhap truoc do
            request.setAttribute("entYear", entYearStr);
            request.setAttribute("no", no);
            request.setAttribute("name", name);
            request.setAttribute("classNum", classNum);

            // load load classList
            ClassNumDAO classDao = new ClassNumDAO();
            request.setAttribute("classList", classDao.filter(teacher.getSchool()));

            request.getRequestDispatcher("student_create.jsp")
                   .forward(request, response);
            
        }

        // =========================
        // 5. ÉP KIEU
        // =========================
        int entYear = Integer.parseInt(entYearStr);

        // =========================
        // 6. TAO OBJECT
        // =========================
        Student s = new Student();
        s.setEntYear(entYear);
        s.setNo(no);
        s.setName(name);
        s.setClassNum(classNum);
        s.setAttend(true);
        s.setSchool(teacher.getSchool());

        // =========================
        // 7. LUU DB
        // =========================
        boolean success = dao.save(s);

        if (success) {
            // thành công → sang done
            request.getRequestDispatcher("student_create_done.jsp")
                   .forward(request, response);
            
        } else {
            // thất bại → quay lại form action

            request.getRequestDispatcher("StudentCreate.action")
                   .forward(request, response);
            
        }
    }
}