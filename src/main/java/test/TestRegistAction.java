package test;

import java.time.LocalDate;
import java.util.List;

import bean.School;
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

public class TestRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession(false);
        Teacher teacher = (session != null) ? (Teacher) session.getAttribute("teacher") : null;

        if (teacher == null) {
            res.sendRedirect("Login.action");
            return;
        }

        School school = teacher.getSchool();

        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");
        String subjectCd = req.getParameter("subject_cd");
        String noStr = req.getParameter("no");

        int currentYear = LocalDate.now().getYear();
        req.setAttribute("currentYear", currentYear);

        ClassNumDAO classDao = new ClassNumDAO();
        req.setAttribute("classList", classDao.filter(school));

        SubjectDAO subjectDao = new SubjectDAO();
        req.setAttribute("subjectList", subjectDao.filter(school));

        if (entYearStr == null && classNum == null && subjectCd == null && noStr == null) {
            req.getRequestDispatcher("test_regist.jsp").forward(req, res);
            return;
        }

        if (entYearStr == null || entYearStr.isEmpty() 
                || classNum == null || classNum.isEmpty()
                || subjectCd == null || subjectCd.isEmpty() 
                || noStr == null || noStr.isEmpty()) {
            
            req.setAttribute("error", "入学年度とクラスと科目と回数を選択してください");
            
            req.setAttribute("ent_year", (entYearStr != null && !entYearStr.isEmpty()) ? Integer.parseInt(entYearStr.trim()) : "");
            req.setAttribute("class_num", classNum);
            req.setAttribute("subject_cd", subjectCd);
            req.setAttribute("no", (noStr != null && !noStr.isEmpty()) ? Integer.parseInt(noStr.trim()) : "");

            req.getRequestDispatcher("test_regist.jsp").forward(req, res);
            return;
        }

        int entYear = Integer.parseInt(entYearStr.trim());
        int no = Integer.parseInt(noStr.trim());
        
        Subject subject = new Subject();
        subject.setCd(subjectCd.trim());

        req.setAttribute("ent_year", entYear);
        req.setAttribute("class_num", classNum);
        req.setAttribute("subject_cd", subjectCd);
        req.setAttribute("no", no);

        StudentDAO sDao = new StudentDAO();
        req.setAttribute("studentList", sDao.filter(school, entYear, classNum, true));
        

        TestDAO testDao = new TestDAO();
        List<Test> testList = testDao.filter(entYear, classNum, subject, no, school);
        req.setAttribute("testList", testList);

        req.getRequestDispatcher("test_regist.jsp").forward(req, res);
    }
}