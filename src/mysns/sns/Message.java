package mysns.sns;

public class Message {
	private int mid;		//게시글 시퀀스 id(게시글에 부여한 번호)
	private String uid;		//게시글 작성자
	private String msgtitle;	//게시글 제목
	private String msg;		//게시글 내용
	private String date;	//게시글 작성일자
	private int favcount;	//좋아요 갯수
	private int replycount;	//댓글 갯수
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getFavcount() {
		return favcount;
	}
	public void setFavcount(int favcount) {
		this.favcount = favcount;
	}
	public int getReplycount() {
		return replycount;
	}
	public void setReplycount(int replycount) {
		this.replycount = replycount;
	}
	public String getMsgtitle() {
		return msgtitle;
	}
	public void setMsgtitle(String msgtitle) {
		this.msgtitle = msgtitle;
	}
	
	
}
