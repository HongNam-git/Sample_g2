package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

public class StudentDAO extends DAO {

    // ========================
    // base SQL
    // ========================
    private final String baseSql = "SELECT * FROM student WHERE school_cd = ?";


    // ========================
    // 1. postFilter
    // ========================
    public List<Student> postFilter(ResultSet rs, School school) throws Exception {

        List<Student> list = new ArrayList<>();

        while (rs.next()) {
            Student s = new Student();

            s.setNo(rs.getString("no"));
            s.setName(rs.getString("name"));
            s.setEntYear(rs.getInt("ent_year"));
            s.setClassNum(rs.getString("class_num"));
            s.setAttend(rs.getBoolean("is_attend"));
            s.setSchool(school);

            list.add(s);
        }

        return list;
    }


    // ========================
    // 2. filter (full)
    // ========================
    public List<Student> filter(School school, int entYear, String classNum, boolean isAttend) throws Exception {

        String sql = baseSql + " AND ent_year = ? AND class_num = ?";
        if (isAttend) {
            sql += " AND is_attend = true";
        }
        sql += " ORDER BY no ASC";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, school.getCd());
        st.setInt(2, entYear);
        st.setString(3, classNum);

        ResultSet rs = st.executeQuery();

        List<Student> list = postFilter(rs, school);

        rs.close();
        st.close();
        con.close();

        return list;
    }


    // ========================
    // 3. filter (no class)
    // ========================
    public List<Student> filter(School school, int entYear, boolean isAttend) throws Exception {

        String sql = baseSql + " AND ent_year = ?";
        if (isAttend) {
            sql += " AND is_attend = true";
        }
        sql += " ORDER BY no ASC";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, school.getCd());
        st.setInt(2, entYear);

        ResultSet rs = st.executeQuery();

        List<Student> list = postFilter(rs, school);

        rs.close();
        st.close();
        con.close();

        return list;
    }


    // ========================
    // 4. filter (school only)
    // ========================
    public List<Student> filter(School school, boolean isAttend) throws Exception {

        String sql = baseSql;
        if (isAttend) {
            sql += " AND is_attend = true";
        }
        sql += " ORDER BY no ASC";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, school.getCd());

        ResultSet rs = st.executeQuery();

        List<Student> list = postFilter(rs, school);

        rs.close();
        st.close();
        con.close();

        return list;
    }


    // ========================
    // 5. save
    // ========================
    public boolean save(Student s) throws Exception {

        String sql = "INSERT INTO student (ent_year, no, name, class_num, is_attend, school_cd) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setInt(1, s.getEntYear());
        st.setString(2, s.getNo());
        st.setString(3, s.getName());
        st.setString(4, s.getClassNum());
        st.setBoolean(5, s.isAttend());
        st.setString(6, s.getSchool().getCd());

        int result = st.executeUpdate();

        st.close();
        con.close();

        return result > 0;
    }


    // ========================
    // 6. CHECK TRUNG
    // ========================
    public Student get(String no, School school) throws Exception {

    	String sql = "SELECT * FROM student WHERE school_cd = ? AND no = ?";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        // đúng thứ tự
        st.setString(1, school.getCd());
        st.setString(2, no);

        ResultSet rs = st.executeQuery();

        Student student = null;

        if (rs.next()) {
            student = new Student();
            student.setNo(rs.getString("no"));
            student.setName(rs.getString("name"));
            student.setEntYear(rs.getInt("ent_year"));
            student.setClassNum(rs.getString("class_num"));
            student.setAttend(rs.getBoolean("is_attend"));
            student.setSchool(school);
        }

        rs.close();
        st.close();
        con.close();

        return student;
    }
    
    
 // UPDATE STUDENT
    public boolean update(Student s) throws Exception {

        String sql = "UPDATE student "
                   + "SET ent_year = ?, "
                   + "name = ?, "
                   + "class_num = ?, "
                   + "is_attend = ? "
                   + "WHERE no = ? "
                   + "AND school_cd = ?";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        // ========================
        // set giá trị
        // ========================
        st.setInt(1, s.getEntYear());
        st.setString(2, s.getName());
        st.setString(3, s.getClassNum());
        st.setBoolean(4, s.isAttend());
        st.setString(5, s.getNo());
        st.setString(6, s.getSchool().getCd());

        // ========================
        // thực thi
        // ========================
        int result = st.executeUpdate();

        st.close();
        con.close();

        return result > 0;
    }
}