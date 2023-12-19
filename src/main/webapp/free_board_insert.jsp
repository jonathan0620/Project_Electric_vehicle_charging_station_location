<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판</title>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<!-- Google Maps API 스타일을 파란색으로 채우기 -->

<style>
.outer {
	width: 800px;
	margin: auto;
}

.wrap {
	width: 780px;
	margin: 100px auto;
}

.board_title {
	border-bottom: 1px solid;
}

.board_content {
	padding: 0px 20px;
}

.board_content .content {
	margin-bottom: 30px;
}

.input_area {
	border: solid 1px #dadada;
	padding: 10px 10px 14px 10px;
	background: white;
}

.input_area select {
	width: 180px;
	height: 30px;
	border: 0px;
}

.input_area input {
	width: 717px;
	height: 30px;
	border: 0px;
	margin-bottom: 10px;
	margin-top: 10px;
}

.input_area input:focus, .input_area select:focus {
	outline: none;
}

.textarea {
	resize: none;
	border: solid 1px #dadada;
}

.textarea:focus {
	outline: none;
}

.title_span {
	background-color: #3498db;
	margin-top: 10px;
}

.board_area button {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #3498db;
	margin: 5px;
	cursor: pointer;
}

.btn_area {
	text-align: center;
	border-top: 1px solid #282A35;
	padding: 30px;
}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- <script type="text/javascript"> -->
</head>
<body>
	<!-- 상단바 -->
	<div id="top">
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<div class="outer">
		<div class="wrap">
			<div class="board_area">
				<div class="board_title">
					<h3>자유 게시글 작성</h3>
				</div>
				<div class="board_content">
					<form method="post" action="free_board_insert"
						onsubmit="return validateForm()">
						<input type="hidden" name="f_writer" value="root">
						<div class="content">
							<br>
							<h5>
								<span class="title_span">&nbsp;</span> 작성자
							</h5>
							<h5>
								<span class="title_span">&nbsp;</span> 제목
							</h5>
							<span class="input_area"> <input type="text"
								name="f_title" required></span> <br>
							<h5>
								<span class="title_span">&nbsp;</span> 내용
							</h5>
							<textarea class="textarea" rows="20" cols="100" name="f_content"
								required></textarea>
						</div>
						<div class="btn_area">
							<button type="button" onclick="location.href='free_board.jsp'">목록으로</button>
							<button type="submit" onclick="showSuccessAlert()">작성하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	function validateForm() {
		var title = document.getElementsByName("f_title")[0].value.trim();
		var content = document.getElementsByName("f_content")[0].value.trim();

		if (title === "" || content === "") {
			alert("제목과 내용을 모두 입력해주세요.");
			return false; // 작성이 실패하였습니다.
		}

		alert("게시글이 성공적으로 작성되었습니다.");
		location.href = 'free_board.jsp';
		return true; // 작성이 성공했습니다.
	}
	const board_ul = document.querySelector('.board_list');
	board_ul.addEventListener('mouseover', function() {
		if (event.target.classList.contains("board_ul")) {
			event.target.classList.add('onmouseover');
		} else if (event.target.parentNode.classList.contains('board_ul')) {
			event.target.parentNode.classList.add('onmouseover');
		}
	})

	board_ul.addEventListener('mouseout', function() {
		if (event.target.classList.contains("board_ul")) {
			event.target.classList.remove('onmouseover');
		} else if (event.target.parentNode.classList.contains('board_ul')) {
			event.target.parentNode.classList.remove('onmouseover');
		}
	})

	function detailView(bid) {
		location.href = '${contextPath}/board/detailView?bid=' + bid;
	}
</script>
</html>
