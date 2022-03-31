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
 .hey{
       border: 5px solid blak;
       border-radius: 5px;
       height: 80%;
       width: 50%;
       font-size: 12pt;
       text-align: left;
       color:black
       }
.tex{
       margin-top: 40px;
       border: 3px solid black;
       border-radius: 5px;
       height: 90%;
       width: 60%;
       font-size: 12pt;
       text-align: left;
       color:black
       
       }
	
		
</style>
<script type='text/javascript' src='http://code.jquery.com/jquery-3.3.1.js'></script>
</head>
<body>
	<main id="main-holder"> 
	<textarea id="msgArea" class="tex"></textarea>
	<br>
	메세지 : <input type="text" id="chatMsg" class="hey"><br>
	아이디 : <input type="text" id="target" class="hey"><br>
	<button id="sendBtn">전송</button>
	<script>
		var ws;
		var memberId = "${sessionScope.member.memberId}";
		
		function connect() {
			ws = new WebSocket('ws://localhost:8090${path}/chat.do');
			ws.onopen = function() {
                console.log("웹소켓 연결 생성");
                
				var msg = {
                    type: "register",
                    memberId: memberId
                }
                
                ws.send(JSON.stringify(msg));
			};
			
			ws.onerror = function(event){
				console.log(event);
			}
			ws.onmessage = function(e) {
				var msg = e.data;
                var chat = $("#msgArea").val() + "\n" + msg;
                $("#msgArea").val(chat);
                const top = $('#msgArea').prop('scrollHeight');
                $('#msgArea').scrollTop(top);
			};
			
			ws.onclose = function() {
				console.log(ws);
				console.log("연결종료");
			};
		}
		connect();
        
        $(function() {
            $("#sendBtn").click(function() {
                var chat = $("#chatMsg").val();
                var msg = $("#msgArea").val();
                $("#msgArea").val(msg);
                $("#chatMsg").val("");
                
                const top = $('#msgArea').prop('scrollHeight');
                $('#msgArea').scrollTop(top);
                
                
                var sendMsg = {
                	id : memberId,
                    type: "chat",
                    target: $("#target").val(),
                    msg: chat
                }
                
                ws.send(JSON.stringify(sendMsg));
            });
        });
	</script>
</body>
</html>