<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.util.*, mysns.sns.*, mysns.member.*"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!-- 모든 게시글 가져오기,게시글 추가,삭제,댓글 추가,삭제 -->
<jsp:useBean id="msg" class="mysns.sns.Message"/>
<jsp:useBean id="msgDAO" class="mysns.sns.MessageDAO" />
<jsp:useBean id="reply" class="mysns.sns.Reply" />

<jsp:setProperty name="msg" property="*"/>
<jsp:setProperty name="reply" property="*" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sns 관련 처리</title>
</head>
<body>

<%
	//컨트롤러 요청 파라미터
	String action = request.getParameter("action");
	//특정 회원 id변수 값
	String suid = request.getParameter("suid");
	//다음 페이지 요청 카운트
	String cnt = request.getParameter("cnt");
	
	//특정 회원의 id 변수 값 (특정 회원의 관심글을 보기 위함)
	String fuid = request.getParameter("fuid");
	
	String smid = request.getParameter("mid");
	String rmid = request.getParameter("rmid");
	
	//댓글이 달린 게시글 위치 정보
	request.setAttribute("curmsg",request.getParameter("curmsg"));
	
	// 메시지 페이지 카운트
	int mcnt;
	
	String home;
	
	if((cnt != null) && (suid != null)) {
		// 각 action 처리후 메인으로 되돌아가기 위한 기본 url
		home = "sns_control.jsp?action=getall&cnt="+cnt+"&suid="+suid;
		mcnt = Integer.parseInt(request.getParameter("cnt"));
	}
	else {
		// 게시글 작성시에는 현재 상태와 상관 없이 전체 게시물의 첫페이지로 이동 하기 위한 url
		home = "sns_control.jsp?action=getall";
		// 첫페이지 요청인 경우, 기본 게시물 5개씩
		mcnt = 5;
	}
	
	//새 게시글 추가 요청인 경우
	if(action.equals("newmsg")){
		if(msgDAO.newMsg(msg)){
			response.sendRedirect(home);
		}
		else{
			throw new Exception("메시지 등록 오류");
		}
	}
	
	//게시글 삭제 요청인 경우
	if(action.equals("delmsg")){
		if(msgDAO.delMsg(msg.getMid()))	//게시글 아이디를 통해 특정 게시글 삭제
			response.sendRedirect(home);
		else
			throw new Exception("메시지 삭제 오류");
	}
	
	//게시글 수정 페이지 요청인 경우
	if(action.equals("edit")){
		Message mess = msgDAO.getMsg(msg.getMid());
		request.setAttribute("m",mess);
		pageContext.forward("edit_msg.jsp");
	}
	//게시글 수정 요청인 경우
	if(action.equals("editmsg")){
		if(msgDAO.editMsg(msg)){
			response.sendRedirect("sns_control.jsp?action=getall");
		}
		else
			throw new Exception("게시글 수정 오류");
	}
	
	//댓글 추가 요청인 경우
	if(action.equals("newreply")){
		if(msgDAO.newReply(reply))
			response.sendRedirect("sns_control.jsp?action=getall&#posting"+smid);
		else
			throw new Exception("댓글 등록 오류");
	}
	//댓글 삭제 요청인 경우
	if(action.equals("delreply")){
		if(msgDAO.delReply(reply.getRid(),Integer.parseInt(rmid)))
			response.sendRedirect("sns_control.jsp?action=getall&#posting"+rmid);
		else
			throw new Exception("댓글 삭제 오류");
	}
	//모든 게시글 가져오는 요청인 경우
	if(action.equals("getall")){
		ArrayList<MessageSet> datas = msgDAO.getAll(mcnt,suid);
		ArrayList<String> nusers = new MemberDAO().getNewMembers();
		
		request.setAttribute("datas",datas);
		
		//현재 페이지 카운트 정보 저장
		request.setAttribute("cnt",mcnt);
		
		//새로운 가입자 목록
		request.setAttribute("nusers",nusers);
		
		pageContext.forward("sns_main.jsp");
	}
	//좋아요 누르기
	if(action.equals("fav")){
		msgDAO.favorite(msg.getMid());
		response.sendRedirect("sns_control.jsp?action=getall&#posting"+smid);
	}
	//관심글 등록하도록 요청받은 경우
	if(action.equals("addfavmsg")){
		int imid = Integer.parseInt(smid);
		String uid = request.getParameter("puid");

		if(msgDAO.addFavMsg(imid,uid)){
			out.println("<script>alert('관심글에 등록했습니다.');history.go(-1);</script>");
		}
		else
			throw new Exception("관심글 등록 오류");
	}
	//사용자의 관심글을 가져오도록 요청받은 경우
	if(action.equals("getfavmsg")){
		if(fuid != null){
			ArrayList<String> nusers = new MemberDAO().getNewMembers();
			ArrayList<Integer> fmidlist = new ArrayList<Integer>();
			Message m = new Message();
			MessageSet datas = new MessageSet();
			
			fmidlist = msgDAO.getFavMsg(fuid);
			Integer[] arr = new Integer[fmidlist.size()];
			arr = fmidlist.toArray(arr);
			
			for(int i=0;i<fmidlist.size();i++){
				m = msgDAO.getMsg(arr[i]);
				datas.setMessage(m);
			}
			request.setAttribute("datas",datas);
			
			pageContext.forward("fav_msg.jsp");
		}
		else
			out.println("<script>alert('로그인을 먼저 해주세요!');history.go(-1);</script>");
	}
%>
</body>
</html>