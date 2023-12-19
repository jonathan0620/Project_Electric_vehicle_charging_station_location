<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" type="text/css" media="all"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/style.css">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="home.jsp">전기자동차 타요타요</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNav" aria-controls="navbarNav"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNav">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
			<li class="nav-item"><a class="nav-link" href="free_board.jsp">커뮤니티</a></li>
			<li class="nav-item"><a class="nav-link" href="#">즐겨찾기</a></li>

			<%
				if (session.getAttribute("id") == null) {
			%>
			<li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="index.jsp">회원가입</a>
			</li>



			<%
				} else {
			%>
			<li class="nav-item"><a class="nav-link"
				href="logout">로그아웃</a></li>
			<%
				}
			%>
		</ul>
	</div>
</nav>