<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>Simpletron</title>
<style>
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<!-- 네비게이션  -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>

	<!-- 심플트론 -->

	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2"
							style="background-color: #eeeeee; text-align: center;"><a
							href='simpletronhelp.jsp'>심플트론이란?</a></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<div id='code'>
								<div>입력 값</div>
								<textarea wrap='off'></textarea>
							</div>
						</td>

						<td>
							<div id='output'>
								<div>결과 값</div>
								<textarea wrap='off' readonly>
<%out.println("*** Welcome to Simpletron! ***");
out.println("*** Please enter your program one istruction ***");
out.println("*** (or data word) at a time. I will type the ***");
out.println("*** location num and a question mark (?) ***");
out.println("*** You then type the word for that location. ***");
out.println("*** Type the sectinel -99999 to stop entering ***");
out.println("*** your program ****");%>
								</textarea>
							</div>
						</td>
					</tr>
				</tbody>
			</table>

			<button id='btn-load' class="btn btn-primary pull-center">메모리에
				올리기</button>
			<button id='btn-exec' class="btn btn-primary pull-center">실행하기
			</button>
			<button id='btn-debug' class="btn btn-primary pull-center">한
				줄씩 실행하기</button>
			<button id='btn-clear' class="btn btn-primary pull-center">결과창
				비우기</button>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center;">
				<thead>
					<tr>
						<th style="text-align: center;">
							<div id='dump'>
								<div>메모리 확인</div>
								<textarea readonly></textarea>
							</div>
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>


	<script src='js/opcodes.js'></script>
	<script src='js/index.js'></script>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>

</body>
</html>

<!--  
	<div id='links'>
		<p>도움말</p>
		<a href='simpletronhelp.jsp'>심플트론이란?</a> <br />
	</div>

	<div id='code'>
		<div>입력 값</div>
		<textarea wrap='off'></textarea>
	</div>

	<div id='output'>
		<div>결과 값</div>
		<textarea wrap='off' readonly></textarea>
	</div>

	<br>
	<button id='btn-load'>메모리에 올리기</button>
	<button id='btn-exec'>실행하기</button>
	<button id='btn-debug'>한 줄씩 실행하기</button>
	<button id='btn-clear'>결과창 비우기</button>

	<div id='dump'>
		<div>메모리 확인</div>
		<textarea readonly></textarea>
	</div>

	<script src='js/opcodes.js'></script>
	<script src='js/index.js'></script>
 -->
