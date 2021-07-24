package mysns.sns;

import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MessageDAO {
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
	String sql;
	//게시글 가져오기(전체, 사용자별) 
	public ArrayList<MessageSet> getAll(int cnt, String suid){
		ArrayList<MessageSet> datas = new ArrayList<MessageSet>();//게시글들의 정보를 담은 ArrayList
		connect();
		try {
			//전체 게시글 가져오기
			if((suid == null)||(suid.equals(""))) {
				sql = "select * from s_message order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnt);
			}
			//특정 사용자 별 게시글 가져오기
			else {
				sql = "select * from s_message where uid=? order by date desc limit 0,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, suid);
				pstmt.setInt(2, cnt);
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MessageSet ms = new MessageSet();
				Message m = new Message();
				ArrayList<Reply> rlist = new ArrayList<Reply>();//댓글에 대한 정보를 담은 ArrayList
				
				m.setMid(rs.getInt("mid"));
				m.setMsg(rs.getString("msg"));
				m.setMsgtitle(rs.getString("msgtitle"));
				m.setDate(rs.getDate("date")+"/"+rs.getTime("date"));
				m.setFavcount(rs.getInt("favcount"));
				m.setReplycount(rs.getInt("replycount"));
				m.setUid(rs.getString("uid"));
				
				String rsql = "select * from s_reply where mid=? order by date desc";
				pstmt = conn.prepareStatement(rsql,
						ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				pstmt.setInt(1, rs.getInt("mid"));
				ResultSet rrs = pstmt.executeQuery();
				while(rrs.next()) {
					Reply r = new Reply();
					r.setRid(rrs.getInt("rid"));
					r.setMid(rrs.getInt("mid"));
					r.setUid(rrs.getString("uid"));
					r.setRmsg(rrs.getString("rmsg"));
					r.setSecret(rrs.getBoolean("secret"));
					r.setDate(rrs.getDate("date")+"/"+rrs.getTime("date"));
					rlist.add(r);
				}
				rrs.last();
				m.setReplycount(rrs.getRow());
				
				ms.setMessage(m);
				ms.setRlist(rlist);
				datas.add(ms);
				rrs.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return datas;
	}
	
	//신규 게시글 추가 메서드
	public boolean newMsg(Message msg) {
		connect();
		sql = "insert into s_message(uid, msg, msgtitle, date) values(?,?,?,now())";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, msg.getUid());
			pstmt.setString(2, msg.getMsg());
			pstmt.setString(3, msg.getMsgtitle());
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
	//게시글 삭제 메서드
	public boolean delMsg(int mid) {
		connect();
		sql = "delete from s_message where mid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
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
	//mid로 특정 게시글 가져오는 메서드
	public Message getMsg(int mid) {
		connect();
		String sql = "select * from s_message where mid=?";
		Message m = new Message();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			m.setMid(rs.getInt("mid"));
			m.setUid(rs.getString("uid"));
			m.setMsg(rs.getString("msg"));
			m.setMsgtitle(rs.getString("msgtitle"));
			m.setFavcount(rs.getInt("favcount"));
			m.setReplycount(rs.getInt("replycount"));
			m.setDate(rs.getDate("date")+"/"+rs.getTime("date"));
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return m;
	}
	//게시글 수정 메서드
	public boolean editMsg(Message m) {
		connect();
		String sql = "update s_message set msg=?, msgtitle=?, date=now() where mid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getMsg());
			pstmt.setString(2, m.getMsgtitle());
			pstmt.setInt(3, m.getMid());
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
	
	//댓글 등록
	public boolean newReply(Reply reply) {
		connect();
		String sql = "insert into s_reply(mid,uid,rmsg,secret,date) values(?,?,?,?,now())";
		String sql2 = "update s_message set replycount=replycount+1 where mid=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reply.getMid());
			pstmt.setString(2, reply.getUid());
			pstmt.setString(3, reply.getRmsg());
			pstmt.setBoolean(4, reply.isSecret());
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, reply.getMid());
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
	//댓글 삭제
	public boolean delReply(int rid, int mid) {
		connect();
		String sql = "delete from s_reply where rid = ?";
		String sql2 = "update s_message set replycount=replycount-1 where mid=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rid);;
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1,mid);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	//좋아요 누르기
	public void favorite(int mid) {
		connect();
		sql = "update s_message set favcount=favcount+1 where mid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  mid);
			pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
	}
	//관심글 등록하기
	public boolean addFavMsg(int mid, String uid) {
		connect();
		sql = "insert into s_favorite(mid,uid) values(?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.setString(2, uid);
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
	//관심글 출력하기
	public ArrayList<Integer> getFavMsg(String fuid){
		connect();
		
		ArrayList<Integer> fmidlist = new ArrayList<Integer>(); 
		sql = "select * from s_favorite where uid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fuid);

			ResultSet fs = pstmt.executeQuery();
			while(fs.next()) {
				fmidlist.add(fs.getInt("mid"));
			}
			fs.close();					
		}catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return fmidlist;

	}
}
