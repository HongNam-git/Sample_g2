package student;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ==========================================
        // 1. SESSION CHECK (Đã sửa lỗi NullPointerException)
        // ==========================================
        HttpSession session = request.getSession();
        
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect("../auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // ==========================================
        // 2. GET FORM DATA (Khớp chuẩn thuộc tính 'name' trong bảng quy định)
        // ==========================================
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String classNum = request.getParameter("class_num"); // Đổi từ classNum -> class_num theo quy định
        String isAttendParam = request.getParameter("is_attend"); // Đổi từ attend -> is_attend theo quy định

        // Vì Checkbox nếu bỏ tích sẽ gửi về null, nên cần kiểm tra bằng logic boolean:
        boolean isAttend = (isAttendParam != null);

        // ==========================================
        // 3. VALIDATION (Kiểm tra lỗi bỏ trống dữ liệu)
        // ==========================================
        boolean hasError = false;

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("nameError", "氏名を入力してください");
            hasError = true;
        }

        if (classNum == null || classNum.trim().isEmpty()) {
            request.setAttribute("classError", "クラスを選択してください");
            hasError = true;
        }

        StudentDAO dao = new StudentDAO();

        // Nếu phát hiện lỗi trống thông tin -> quay ngược lại Form sửa và giữ nguyên dữ liệu vừa nhập
        if (hasError) {
            Student dummyStudent = new Student();
            dummyStudent.setNo(no);
            dummyStudent.setName(name);
            dummyStudent.setClassNum(classNum);
            dummyStudent.setAttend(isAttend);
            
            // Lấy lại Năm nhập học cũ từ DB để hiển thị (Vì trường này Readonly không cho sửa)
            Student original = dao.get(no, teacher.getSchool());
            if (original != null) {
                dummyStudent.setEntYear(original.getEntYear());
            }

            request.setAttribute("student", dummyStudent);

            // Load lại danh sách lớp cho ô chọn thả xuống
            ClassNumDAO classDao = new ClassNumDAO();
            request.setAttribute("classList", classDao.filter(teacher.getSchool()));

            request.getRequestDispatcher("student_update.jsp")
                   .forward(request, response);
            return;
        }

        // ==========================================
        // 4. LẤY ĐỐI TƯỢNG HỌC SINH HIỆN TẠI TỪ DATABASE
        // ==========================================
        Student student = dao.get(no, teacher.getSchool());

        if (student == null) {
            request.setAttribute("error", "学生が存在しません");
            request.getRequestDispatcher("student_update.jsp")
                   .forward(request, response);
            return;
        }

        // ==========================================
        // 5. CHỈ UPDATE 3 FIELDS ĐƯỢC PHÉP SỬA
        // ==========================================
        student.setName(name);
        student.setClassNum(classNum);
        student.setAttend(isAttend); // Cập nhật trạng thái Đi học/Nghỉ học

        // ==========================================
        // 6. UPDATE DATABASE
        // ==========================================
        boolean success = dao.update(student);

        // ==========================================
        // 7. CHUYỂN HƯỚNG MÀN HÌNH SAU KHI XỬ LÝ
        // ==========================================
        if (success) {
            // Thành công -> Sang màn hình hoàn thành (student_update_done.jsp)
            request.getRequestDispatcher("student_update_done.jsp")
                   .forward(request, response);
        } else {
            // Thất bại -> Quay lại form báo lỗi
            request.setAttribute("error", "更新に失敗しました");
            
            ClassNumDAO classDao = new ClassNumDAO();
            request.setAttribute("classList", classDao.filter(teacher.getSchool()));
            request.setAttribute("student", student);
            
            request.getRequestDispatcher("student_update.jsp")
                   .forward(request, response);
        }
    }
}