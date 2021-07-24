<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.util.*, mysns.member.*"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!-- 사용자 신규 추가, 로그인, 로그아웃 요청 처리 -->
<jsp:useBean id="memDAO" class="mysns.member.MemberDAO"/>
<jsp:useBean id="member" class="mysns.member.Member"/>
<jsp:setProperty name="member" property="*" />
<%
	//컨트롤러 요청 파라미터
	String action = request.getParameter("action");
	//신규 사용자 등록 요청인 경우
	if(action.equals("insert")){
		if(memDAO.insertDB(member)){
			out.println("<script>alert('새로운 가입자를 환영합니다! 로그인 해주세요:)');opener.window.location.reload();window.close();</script>");
		}
		else
			out.println("<script>alert('같은 아이디가 존재 합니다!!');history.go(-1);</script>");
	}
	//사용자 정보 페이지 요청인 경우
	if(action.equals("userinfo")){
		if(member.getUid() != null){
			Member user = memDAO.getUserInfo(member.getUid());
			request.setAttribute("u",user);
			pageContext.forward("myinfo.jsp");
			}
		else
			out.println("<script>alert('로그인을 먼저 해주세요!');history.go(-1);</script>");
	}

	//특정 사용자 정보 삭제 요청인 경우 (제가 추가할 기능이에요0.<)
	if(action.equals("deluser")){
		if(memDAO.deleteUser(member.getUid())){
			//세션에 저장된 값 초기화
			session.removeAttribute("uid");
			response.sendRedirect("sns_control.jsp?action=getall");
		}
		else
			throw new Exception("정보 삭제 오류");
	}
	//특정 사용자 정보 수정 요청인 경우(제가 추가할 기능이에요0.<)
	if(action.equals("edituser")){
		if(memDAO.editUser(member)){
			response.sendRedirect("sns_control.jsp?action=getall");
		}
		else
			throw new Exception("정보 수정 오류");
	}
	//로그인 요청인 경우(사용자 정보 가져옴)
	if(action.equals("login")){
		if(memDAO.login(member.getUid(),member.getUser_pw())){
			//로그인 성공시 세션에 "uid" 저장
			session.setAttribute("uid", member.getUid());
			response.sendRedirect("sns_control.jsp?action=getall");
		}
		else{
			out.println("<script>alert('로그인 오류!');history.go(-1);</script>");
		}
	}
	//로그아웃 요청인 경우
	if(action.equals("logout")){
		//세션에 저장된 값 초기화
		session.removeAttribute("uid");
		response.sendRedirect("sns_control.jsp?action=getall");
	}
	
	//아이디와 일치하는 사용자 검색하기
	if(action.equals("search")){
		String key = request.getParameter("key");
		if(memDAO.searchID(key)){
			//해당하는 id를 DB에서 찾은 경우
			response.sendRedirect("sns_control.jsp?action=getall&suid="+key);
		}
		else{
			//해당하는 id를 DB에서 찾지 못한 경우
			out.println("<script>alert('입력한 id와 일치하는 사용자가 없습니다.');history.go(-1);</script>");
		}
		
	}
		
	
%>
