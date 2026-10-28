package dao;

import java.sql.Connection;     //dai dien cho 1 ket noi DB

import javax.naming.InitialContext;  //dung de lay tai nguyen tu JNDI
import javax.sql.DataSource;        //dai dien cho nguon ket noi DB

public class DAO {
	
	//bien static de luu datasource dung chung cho toan bo DAO va cac subclass
    static DataSource ds;
    
    
    // method lay Connection tu dataSourse
    public Connection getConnection() throws Exception {
    	
    	//neu dataSource chua duc khoi tao (lan dau tien goi)
        if (ds == null) {
        	//tao doi tuong de truy cap JND
            InitialContext ic = new InitialContext();
            
            //lay datasource da duoc cau hinh trong context.xml
            ds = (DataSource) ic.lookup("java:/comp/env/jdbc/exam");
        }
        
        //tra ve mot connection tu datasoure
        return ds.getConnection();
    }
}



//lam 1 viec duy nhat: lay connection
//bien dataSource ds, method getCOnnection

// KHONG viet SQL, KHONG xu ly product; no chi cung cap ket noi DB