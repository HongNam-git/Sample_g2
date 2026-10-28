package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.TestListStudent;

public class TestListStudentDAO extends DAO {

    // 共通SQL
    private String baseSql =

            "SELECT " +

            "sub.name AS subject_name, " +
            "t.subject_cd, " +
            "t.no, " +
            "t.point " +

            "FROM test t " +

            "INNER JOIN subject sub " +
            "ON t.subject_cd = sub.cd " +
            "AND t.school_cd = sub.school_cd " +

            "WHERE t.student_no = ? " +
            "AND t.school_cd = ? " +
            "AND t.point IS NOT NULL " +

            "ORDER BY t.subject_cd, t.no";



    // ResultSet → List変換
    private List<TestListStudent> postFilter(
            ResultSet rs
    ) throws Exception {

        List<TestListStudent> list =
                new ArrayList<>();


        while (rs.next()) {

            TestListStudent test =
                    new TestListStudent();


            // 科目名
            test.setSubjectName(
                    rs.getString("subject_name"));

            // 科目コード
            test.setSubjectCd(
                    rs.getString("subject_cd"));

            // 回数
            test.setNum(
                    rs.getInt("no"));

            // 点数
            test.setPoint(
                    rs.getInt("point"));


            list.add(test);
        }

        return list;
    }



    // 学生別成績一覧取得
    public List<TestListStudent> filter(
            Student student
    ) throws Exception {

        Connection con =
                getConnection();

        PreparedStatement st =
                con.prepareStatement(baseSql);


        st.setString(1,
                student.getNo());

        st.setString(2,
                student.getSchool().getCd());


        ResultSet rs =
                st.executeQuery();


        List<TestListStudent> list =
                postFilter(rs);


        rs.close();
        st.close();
        con.close();


        return list;
    }
}