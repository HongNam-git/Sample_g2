package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDAO extends DAO {

    private List<Test> postFilter(ResultSet rs) throws Exception {
        List<Test> list = new ArrayList<>();
        while (rs.next()) {
            Test t = new Test();

            Student s = new Student();
            s.setNo(rs.getString("student_no"));
            s.setName(rs.getString("name"));
            s.setEntYear(rs.getInt("ent_year"));

            Subject sub = new Subject();
            sub.setCd(rs.getString("subject_cd"));

            School sc = new School();
            sc.setCd(rs.getString("school_cd"));

            t.setStudent(s);
            t.setSubject(sub);
            t.setSchool(sc);

            t.setClassNum(rs.getString("class_num"));
            t.setNo(rs.getInt("no"));
            
            int point = rs.getInt("point");
            if (rs.wasNull()) {
                t.setPoint(-1);
            } else {
                t.setPoint(point);
            }

            list.add(t);
        }
        return list;
    }

    public List<Test> filter(int entYear, String classNum, Subject subject, int no, School school) throws Exception {
        Connection con = getConnection();

        String sql =
            "SELECT " +
            "s.no AS student_no, s.name, s.ent_year, " +
            "t.subject_cd, t.school_cd, t.class_num, t.no, t.point " +
            "FROM test t " +
            "RIGHT OUTER JOIN student s ON t.student_no = s.no " +
            "AND t.subject_cd = ? " +
            "AND t.no = ? " +
            "WHERE s.school_cd = ? " +
            "AND s.ent_year = ? " +
            "AND s.class_num = ? " +
            "AND s.is_attend = true " +
            "ORDER BY s.no ASC";

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, subject.getCd());
        st.setInt(2, no);
        st.setString(3, school.getCd());
        st.setInt(4, entYear);
        st.setString(5, classNum);

        ResultSet rs = st.executeQuery();
        List<Test> list = postFilter(rs);

        rs.close();
        st.close();
        con.close();

        return list;
    }

    public Test get(Student student, Subject subject, School school, int no) throws Exception {
        Connection con = getConnection();

        String sql =
            "SELECT " +
            "t.student_no, t.subject_cd, t.school_cd, t.class_num, t.no, t.point, " +
            "s.ent_year, s.name " +
            "FROM test t " +
            "JOIN student s ON t.student_no = s.no " +
            "WHERE t.student_no = ? " +
            "AND t.subject_cd = ? " +
            "AND t.school_cd = ? " +
            "AND t.no = ?";

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, student.getNo());
        st.setString(2, subject.getCd());
        st.setString(3, school.getCd());
        st.setInt(4, no);

        ResultSet rs = st.executeQuery();
        List<Test> list = postFilter(rs);

        rs.close();
        st.close();
        con.close();

        return list.isEmpty() ? null : list.get(0);
    }

    public boolean save(Test test) throws Exception {
        Connection con = getConnection();

        String checkSql =
            "SELECT COUNT(*) FROM test " +
            "WHERE student_no = ? AND subject_cd = ? AND school_cd = ? AND no = ?";

        PreparedStatement checkSt = con.prepareStatement(checkSql);

        checkSt.setString(1, test.getStudent().getNo());
        checkSt.setString(2, test.getSubject().getCd());
        checkSt.setString(3, test.getSchool().getCd());
        checkSt.setInt(4, test.getNo());

        ResultSet rs = checkSt.executeQuery();
        rs.next();
        int count = rs.getInt(1);

        rs.close();
        checkSt.close();

        if (count == 0) {
            String insertSql =
                "INSERT INTO test (student_no, subject_cd, school_cd, class_num, no, point) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement st = con.prepareStatement(insertSql);
            st.setString(1, test.getStudent().getNo());
            st.setString(2, test.getSubject().getCd());
            st.setString(3, test.getSchool().getCd());
            st.setString(4, test.getClassNum());
            st.setInt(5, test.getNo());
            st.setInt(6, test.getPoint());

            st.executeUpdate();
            st.close();
        } else {
            String updateSql =
                "UPDATE test SET point = ? " +
                "WHERE student_no = ? AND subject_cd = ? AND school_cd = ? AND no = ?";

            PreparedStatement st = con.prepareStatement(updateSql);
            st.setInt(1, test.getPoint());
            st.setString(2, test.getStudent().getNo());
            st.setString(3, test.getSubject().getCd());
            st.setString(4, test.getSchool().getCd());
            st.setInt(5, test.getNo());

            st.executeUpdate();
            st.close();
        }

        con.close();
        return true;
    }
}