package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;

public class SubjectDAO extends DAO {

    
    // 1. GET (1 subject)
    
    public Subject get(String cd, School school) throws Exception {

        String sql = "SELECT * FROM subject WHERE school_cd = ? AND cd = ?";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, school.getCd());
        st.setString(2, cd);
        
        ResultSet rs = st.executeQuery();

        Subject subject = null;

        if (rs.next()) {
            subject = new Subject();
            subject.setCd(rs.getString("cd"));
            subject.setName(rs.getString("name"));
            subject.setSchool(school);
        }

        rs.close();
        st.close();
        con.close();

        return subject;
    }

    
    // 2. FILTER (一覧)
    
    public List<Subject> filter(School school) throws Exception {

        List<Subject> list = new ArrayList<>();

        String sql = "SELECT * FROM subject WHERE school_cd = ? ORDER BY cd";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, school.getCd());

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            Subject s = new Subject();
            s.setCd(rs.getString("cd"));
            s.setName(rs.getString("name"));
            s.setSchool(school);

            list.add(s);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    
    // 3. INSERT
   
    public boolean insert(Subject subject) throws Exception {

        String sql = "INSERT INTO subject (school_cd, cd, name) VALUES (?, ?, ?)";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, subject.getSchool().getCd());
        st.setString(2, subject.getCd());
        st.setString(3, subject.getName());

        int result = st.executeUpdate();

        st.close();
        con.close();

        return result > 0;
    }

    
    // 4. UPDATE
    
    public boolean update(Subject subject) throws Exception {

        String sql = "UPDATE subject SET name = ? WHERE school_cd = ? AND cd = ?";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, subject.getName());
        st.setString(2, subject.getSchool().getCd());
        st.setString(3, subject.getCd());

        int result = st.executeUpdate();

        st.close();
        con.close();

        return result > 0;
    }

    
    // 5. DELETE
    
    public boolean delete(Subject subject) throws Exception {

        String sql = "DELETE FROM subject WHERE school_cd = ? AND cd = ?";

        Connection con = getConnection();
        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, subject.getSchool().getCd());
        st.setString(2, subject.getCd());

        int result = st.executeUpdate();

        st.close();
        con.close();

        return result > 0;
    }
}