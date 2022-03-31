<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인</h1>
	<c:if test="${empty sessionScope.member }">
		<form action="${path}/login.do" method="post">
			아이디 : <input type="text" name="memberId"><br>
			비밀번호 : <input type="password" name="memberPw"><br>
			<input type="submit" value="로그인">
		</form>
	</c:if>
	<c:if test="${not empty sessionScope.member }">
		<h3>${sessionScope.member.memberId }님 환영합니다.</h3>
		<a href="${path}/logout.do">로그 아웃</a><br>
		<hr>
		<a href="${path}/goCard.do">카드 등록</a><br>
		<hr>
		<a href="${path}/goChat.do">1:1 채팅</a><br>
	</c:if>
</body>
</html>