package test;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDAO;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession(false);
        Teacher teacher = (session != null) ? (Teacher) session.getAttribute("teacher") : null;

        if (teacher == null) {
            res.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        int entYear = Integer.parseInt(req.getParameter("ent_year").trim());
        String classNum = req.getParameter("class_num").trim();
        String subjectCd = req.getParameter("subject_cd").trim();
        int no = Integer.parseInt(req.getParameter("no").trim());

        String[] studentNos = req.getParameterValues("student_no");
        String[] points = req.getParameterValues("point");

        Subject subject = new Subject();
        subject.setCd(subjectCd);

        StudentDAO sDao = new StudentDAO();
        TestDAO dao = new TestDAO();

        Map<Integer, String> errors = new HashMap<>();
        boolean formatErrorOccurred = false;

        if (points != null) {
            for (int i = 0; i < points.length; i++) {
                String pointStr = points[i];
                if (pointStr == null || pointStr.trim().isEmpty()) {
                    continue;
                }
                try {
                    int point = Integer.parseInt(pointStr.trim());
                    if (point < 0 || point > 100) {
                        errors.put(i, "0〜100の範囲で入力してください");
                        formatErrorOccurred = true;
                    }
                } catch (NumberFormatException e) {
                    errors.put(i, "0〜100の範囲で入力してください");
                    formatErrorOccurred = true;
                }
            }
        }

        if (formatErrorOccurred) {
            req.setAttribute("errors", errors);
            req.setAttribute("inputPoints", points);

            int currentYear = LocalDate.now().getYear();
            req.setAttribute("currentYear", currentYear);
            req.setAttribute("classList", new ClassNumDAO().filter(school));
            req.setAttribute("subjectList", new SubjectDAO().filter(school));

            req.setAttribute("ent_year", entYear);
            req.setAttribute("class_num", classNum);
            req.setAttribute("subject_cd", subjectCd);
            req.setAttribute("no", no);

            java.util.ArrayList<Student> studentList = new java.util.ArrayList<>();
            if (studentNos != null) {
                for (int i = 0; i < studentNos.length; i++) {
                    Student st = new Student();
                    st.setNo(studentNos[i]);
                    st.setEntYear(entYear);
                    st.setClassNum(classNum);
                    
                    Student existStudent = sDao.get(studentNos[i], school); 
                    if (existStudent != null) {
                        st.setName(existStudent.getName());
                    } else {
                        st.setName("学生 " + studentNos[i]);
                    }
                    studentList.add(st);
                }
            }
            req.setAttribute("studentList", studentList); 

            List<Test> testList = dao.filter(entYear, classNum, subject, no, school);
            req.setAttribute("testList", testList);

            req.getRequestDispatcher("test_regist.jsp").forward(req, res);
            return;
        }

        if (studentNos != null && points != null) {
            for (int i = 0; i < studentNos.length; i++) {
                String pointStr = points[i];
                if (pointStr == null || pointStr.trim().isEmpty()) {
                    continue;
                }

                int point = Integer.parseInt(pointStr.trim());
                Test test = new Test();
                Student student = new Student();
                student.setNo(studentNos[i]);

                test.setStudent(student);
                test.setSubject(subject);
                test.setSchool(school);
                test.setClassNum(classNum);
                test.setNo(no);
                test.setPoint(point);

                dao.save(test);
            }
        }

        req.getRequestDispatcher("test_regist_done.jsp").forward(req, res);
    }
}