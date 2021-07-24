package mysns.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	//MySQL 연결 정보
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/mysnsdb?charaterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
	//DB 연결 메서드
	void connect() {
		try {
			Class.forName(jdbc_driver);
			
			conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn!=null) {
			try {
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//신규 사용자 등록 메서드
	public boolean insertDB(Member member) {
		connect();
		
		String sql = "insert into s_member(name,uid,email,user_pw,date) values(?,?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getUid());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getUser_pw());
			pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	//uid로 특정 사용자 정보 가져오는 메서드
	public Member getUserInfo(String uid) {
		connect();
		String sql = "select * from s_member where uid=?";
		Member user = new Member();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			user.setUid(rs.getString("uid"));
			user.setName(rs.getString("name"));
			user.setUser_pw(rs.getString("user_pw"));
			user.setEmail(rs.getString("email"));
			user.setDate(rs.getDate("date")+"/"+rs.getTime("date"));
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return user;
	}
	//특정 사용자 정보 삭제 메서드-탈퇴
	public boolean deleteUser(String uid) {
		connect();
		String sql ="delete from s_member where uid=?";
		String sql2 = "delete from s_message where uid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	//특정 사용자 정보 수정 메서드
	public boolean editUser(Member user) {
		connect();
		String sql = "update s_member set name=?, email=? where uid=?";
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getUid());
			pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	//로그인 메서드(사용자 정보 가져옴)
	public boolean login(String uid, String user_pw) {
		connect();
		String sql = "select uid, user_pw from s_member where uid =?";
		boolean result = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			if(rs.getString("user_pw").contentEquals(user_pw))
				result = true;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return result;
	}
	//신규 회원 목록
	public ArrayList<String> getNewMembers(){
		ArrayList<String> nmembers = new ArrayList<String>();
		connect();
		//회원 목록은 7개 까지만 가져옴
		String sql = "select * from s_member order by date desc limit 0,7";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				nmembers.add(rs.getString("uid"));
				
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return nmembers;
	}
	//사용자 ID 조회 검색
	public boolean searchID(String key) {
		connect();
		String sql = "select uid from s_member";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getString("uid").equals(key))
					return true;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return false;
	}
	
}
