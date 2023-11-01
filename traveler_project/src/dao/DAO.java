package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
	//static DataSource ds;

	public Connection getConnection() throws Exception {
		//if (ds==null) {
			//InitialContext ic=new InitialContext();
			//ds=(DataSource)ic.lookup("java:/comp/env/jdbc/book");
		//}
		Class.forName("org.h2.Driver");
		return DriverManager.getConnection("jdbc:h2:tcp://localhost/~/book", "sa", "");
		//return ds.getConnection();
	}
}
