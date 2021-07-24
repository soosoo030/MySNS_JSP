package mysns.sns;

public class Reply {
	private int mid;	//원본 글 id
	private int rid;	//댓글 시퀀스 id(댓글 단 사람의 id?)
	private String uid;	//댓글 작성자
	private String rmsg;//댓글 내용
	private String date;//댓글 작성 일자
	private boolean secret;//비밀 댓글 체크 여부
	
	
	public boolean isSecret() {
		return secret;
	}
	public void setSecret(boolean secret) {
		this.secret = secret;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getRmsg() {
		return rmsg;
	}
	public void setRmsg(String rmsg) {
		this.rmsg = rmsg;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
}
