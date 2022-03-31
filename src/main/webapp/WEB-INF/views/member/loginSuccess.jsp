<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style> 
 html { height: 100%; } 
 body { height: 100%; margin: 0; font-family: Arial, Helvetica, sans-serif; display: grid; justify-items: center; align-items: center; background-color: #3a3a3a; }
 #main-holder { width: 50%; height: 70%; display: grid; justify-items: center; align-items: center; background-color: white; border-radius: 7px; box-shadow: 0px 0px 5px 2px black; }  
 a { text-decoration:none }
 .btn{  <!-- 모든 버튼에대한 css설정 -->
      text-decoration: none;
      font-size:1rem;
      color:white;
      padding:10px 10px 10px 10px;
      margin:20px;
      display:inline-block;
      border-radius: 10px;
      transition:all 0.1s;
      text-shadow: 0px -2px rgba(0, 0, 0, 0.44);
      font-family: 'Lobster', cursive; <!-- google font -->
    }
    .btn:active{
      transform: translateY(3px);
    }
     .btn.black{
        background-color: #0d0d0e;
        border-bottom:5px solid #2e2f31;
    }
      .btn.black:active{
        border-bottom:2px solid #2e2f31;
    }
</style>
</head>
<body>
	<main id="main-holder"> 
	<h1>로그인 성공!</h1>
	<a class="btn black" href="${path}">메인으로 가기!</a>
</body>
</html>