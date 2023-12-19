<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

.mb-3 input {
	border-radius: 20px; 
}
</style>
<title>회원가입</title>
</head>
<body>
	<div class="container mt-5">

		<h2 class="text-center mb-4">회원가입</h2>

		<form action="insert" method="post">

			<div class="insert mb-3">
				<label for="username" class="form-label">아이디</label><input type="text"
					class="form-control" id="username" name="m_id" placeholder="소문자, 숫자 6~15자 이내"
					required>
			</div>

			<div class="form-row mb-3">
				<div class="col">
					<label for="password" class="form-label">비밀번호</label> <input
						type="password" class="form-control" id="password" name="m_pw"
						placeholder="대소문자, 숫자, 특수문자(~'!@#$%\^&*()-+=) 8~20자 이내" required>
				</div>
				<div class="col">
					<label for="confirmPassword" class="form-label">비밀번호 확인</label> <input
						type="password" class="form-control" id="confirmPassword"
						name="confirmPassword" required>
				</div>
			</div>

			<div class="mb-3">
				<label for="name" class="form-label">이름</label><input type="text"
					class="form-control" id="name" name="m_name" 
					required>
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">이메일</label><input type="email"
					class="form-control" id="email" name="m_email" placeholder="sample@email.com"
					required>
			</div>

			<div class="mb-3">
				<label for="tel" class="form-label">전화번호</label><input type="tel"
					class="form-control" id="tel" name="m_tel" placeholder="010-0000-0000"
					required>
			</div>

			<div class="form-group row mb-3">
				<div class="col-sm-12">
					<button type="submit" class="btn btn-block"
						style="background-color: #3498D8; border-radius: 20px; ">가입하기</button>
				</div>
			</div>
			<hr style="border-color: black;">
			<div class="text-center">
				<a class="small" href="login.jsp">이미 계정이 있나요? 로그인!</a>
			</div>
		</form>
	</div>

</body>
</html>
