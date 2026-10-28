package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.School;
import bean.Teacher;

public class TeacherDAO extends DAO {

    public Teacher findByIdAndPassword(String id, String password) throws Exception {

        Teacher teacher = null;

        Connection con = getConnection();

        String sql = "SELECT * FROM teacher WHERE id = ? AND password = ?";

        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, id);
        st.setString(2, password);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            teacher = new Teacher();

            teacher.setId(rs.getString("id"));
            teacher.setPassword(rs.getString("password"));
            teacher.setName(rs.getString("name"));

            // 🔥 FIX HERE (quan trọng nhất)
            School school = new School();
            school.setCd(rs.getString("school_cd"));

            teacher.setSchool(school);
        }

        rs.close();
        st.close();
        con.close();

        return teacher;
    }
}