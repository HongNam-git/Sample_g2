package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.School;

public class ClassNumDAO extends DAO {
	
	//LAY DANH SACH CLASS THEO SCHOOL_CD CUA TEACHER
	public List<ClassNum> filter(School school) throws Exception {

	    List<ClassNum> list = new ArrayList<>();

	    Connection con = getConnection();

	    String sql = "select class_num from class_num where school_cd=? order by class_num";

	    PreparedStatement st = con.prepareStatement(sql);
	    st.setString(1, school.getCd());

	    ResultSet rs = st.executeQuery();

	    while (rs.next()) {
	        ClassNum c = new ClassNum();
	        c.setClassNum(rs.getString("class_num"));
	        c.setSchool(school);

	        list.add(c);
	    }

	    rs.close();
	    st.close();
	    con.close();

	    return list;
	}
}
