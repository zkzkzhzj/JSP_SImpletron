<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="active"><a href="simpletronhelp.jsp">심플트론이란?</a></li>
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
							<h2>기계어 프로그래밍</h2>
							<hr>
							<h4>사람이 이해하기 쉬운 고급 언어가 아닌 기계어를 체험해 볼 수 있습니다</h4>
							<h4>앞의 두 자리가 연산 코드 부분이고 뒷 두 자리가 메모리의 위치입니다</h4>
							<h4>즉, 코드 한 줄당 4자리로 이루어져 있는 것이지요</h4>
							<h3>아래 표를 참고해주세요!</h3>
							<table class="table table-striped" border=1>
								<tr>
									<th><h4>연산 코드</h4></th>
									<th><h4>의미</h4></th>
								</tr>
								<tr>
									<th><h5>#define Read 10</h5></th>
									<th><h5>터미널의 단어를 특정한 메모리 위치로 읽기</h5></th>
								</tr>
								<tr>
									<th><h5>#define WRITE 11</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 터미널에 출력</h5></th>
								</tr>
								<tr>
									<th><h5>#define ADD 20</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기로 로드</h5></th>
								</tr>
								<tr>
									<th><h5>#define STORE 21</h5></th>
									<th><h5>누산기의 단어를 특정한 메모리 위치에 저장</h5></th>
								</tr>
								<tr>
									<th><h5>#define ADD 30</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 더하기</h5></th>
								</tr>
								<tr>
									<th><h5>#define SUBSTRACT 31</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 빼기</h5></th>
								</tr>
								<tr>
									<th><h5>#define DIVIDE 32</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 나누기</h5></th>
								</tr>
								<tr>
									<th><h5>#define MULTIPLY 33</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 곱하기</h5></th>
								</tr>
								<tr>
									<th><h5>#define BRANCH 40</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 빼기</h5></th>
								</tr>
								<tr>
									<th><h5>#define BRANCHNEG 41</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 빼기</h5></th>
								</tr>
								<tr>
									<th><h5>#define BRANCHZERO 42</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 빼기</h5></th>
								</tr>
								<tr>
									<th><h5>#define HALT 43</h5></th>
									<th><h5>특정한 메모리 위치의 단어를 누산기에 빼기</h5></th>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>



	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>

</body>
</html>

