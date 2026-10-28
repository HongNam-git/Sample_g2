package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import bean.School;
import bean.Subject;
import bean.TestListSubject;

public class TestListSubjectDAO extends DAO {

    private String baseSql =
            "SELECT s.ent_year, s.class_num, " +
            "s.no AS student_no, s.name AS student_name, " +
            "t.no AS test_no, t.point " +
            "FROM student s " +
            "LEFT JOIN test t " +
            "ON s.no = t.student_no " +
            "AND t.subject_cd = ? " +
            "AND t.school_cd = ? " +
            "WHERE s.ent_year = ? " +
            "AND s.class_num = ? " +
            "AND s.school_cd = ? " +
            "ORDER BY s.no, t.no";

    private List<TestListSubject> postFilter(ResultSet rs) throws Exception {

        Map<String, TestListSubject> map = new LinkedHashMap<>();

        while (rs.next()) {
        	

            String studentNo = rs.getString("student_no");

            TestListSubject test = map.get(studentNo);

            if (test == null) {
                test = new TestListSubject();
                test.setEntYear(rs.getInt("ent_year"));
                test.setClassNum(rs.getString("class_num"));
                test.setStudentNo(studentNo);
                test.setStudentName(rs.getString("student_name"));
                map.put(studentNo, test);
            }

            
            Integer testNo = rs.getObject("test_no", Integer.class);
            Integer point = rs.getObject("point", Integer.class);

            if (testNo != null && point != null) {
                test.putPoint(testNo, point);
            }
        }

        return new ArrayList<>(map.values());
    }

    public List<TestListSubject> filter(
            int entYear,
            String classNum,
            Subject subject,
            School school
    ) throws Exception {

        try (
            Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(baseSql)
        ) {

            st.setString(1, subject.getCd());
            st.setString(2, school.getCd());
            st.setInt(3, entYear);
            st.setString(4, classNum);
            st.setString(5, school.getCd());

            try (ResultSet rs = st.executeQuery()) {
                return postFilter(rs);
            }
        }
    }
}