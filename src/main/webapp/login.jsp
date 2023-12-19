<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>
body {
	background-color: #3498D8;
	margin: 0;
}

.container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-group input {
	border-radius: 20px;
}
</style>
<title>Login</title>
</head>
<body>
	<div class="container mt-5">
		<h2 class="text-center mb-4">로그인</h2>

		<form action="select" method="post">
			<div class="form-group">
				<label for="username"></label> <input type="text"
					class="form-control" id="username" name="m_id" placeholder="아이디"
					required>
			</div>
			<div class="form-group">
				<label for="password"></label> <input type="password"
					class="form-control" id="password" name="m_pw" placeholder="비밀번호"
					required>
			</div>

			<div class="form-group">
				<button type="submit" class="btn btn-block"
					style="background-color: #3498D8; border-radius: 20px;">로그인</button>
			</div>
			<hr style="border-color: black;">
			<div class="text-center">
				<a class="small" href="#">아이디 찾기</a> <span class="mx-2">|</span> <a
					class="small" href="#">비밀번호 찾기</a> <span class="mx-2">|</span>
				<a class="small" href="index.jsp">회원가입</a>
			</div>
		</form>
	</div>
</body>
</html>
