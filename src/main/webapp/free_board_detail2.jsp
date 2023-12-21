<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판 상세보기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<style>
.outer {
	width: 800px;
	margin: auto;
}

.wrap {
	width: 780px;
	margin: 100px auto;
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
	width: 745px;
	height: 30px;
	border: 0px;
	margin-bottom: 30px;
	margin-top: 10px;
}

.input_area input:focus, .input_area select:focus {
	outline: none;
}

.textarea {
	resize: none;
	border: solid 1px #dadada;
	width: 100%;
	padding: 10px;
	margin-bottom: 30px;
}

.textarea:focus {
	outline: none;
}

.title_span {
	background-color: #3498db;
	margin-top: 10px;
	padding: 5px;
	color: white;
}

.btn_area button {
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
	padding: 20px;
}

.comment_area button {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #3498db;
	margin: 5px;
	cursor: pointer;
	margin-bottom: 20px;
}

.comment-info {
	margin-right: 30px;
}

.comment-content {
	background-color: #ddd;
	padding: 10px;
	border-radius: 5px;
}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		function getParameterByName(name, url) {
			if (!url)
				url = window.location.href;
			name = name.replace(/[\[\]]/g, "\\$&");
			var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"), results = regex
					.exec(url);
			if (!results)
				return null;
			if (!results[2])
				return '';
			return decodeURIComponent(results[2].replace(/\+/g, " "));
		}

		var postId = getParameterByName('f_no');
		var fNum = getParameterByName('f_num');

		$.ajax({
			url : "getFreeDetails",
			data : {
				f_no : postId,
				f_num : fNum
			},
			dataType : "json",
			success : function(result) {
				console.log("게시물 상세 정보 수신:", result);

				var postTime = new Date(result.f_time);
				var formattedPostTime = postTime.getFullYear() + "-"
						+ (postTime.getMonth() + 1) + "-" + postTime.getDate();

				$("#postNo").text(result.f_no);
				$("#postView").text(result.f_view);
				$("#postWriter").text(result.f_writer);
				$("#postTime").text(formattedPostTime);
				$("#title").val(result.f_title);
				$("#contents").val(result.f_content);

				getComments(postId);
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	});
</script>
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
					<h2>게시글 상세 화면</h2>
				</div>
				<div class="board_list"></div>
			</div>
			<table class="board_detail">
				<colgroup>
					<col width="15%" />
					<col width="45%" />
					<col width="15%" />
					<col width="45%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">글 번호</th>
						<td id="postNo"></td>
						<th scope="row">조회수</th>
						<td id="postView"></td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td id="postWriter"></td>
						<th scope="row">작성일</th>
						<td id="postTime"></td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3"><input type="text" id="title" name="title"
							class="input_area editable" /></td>
					</tr>
					<tr>
						<td colspan="4" class="view_text"><textarea title="내용"
								id="contents" name="contents" class="textarea editable"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_area">
				<button type="button" onclick="location.href='free_board.jsp'"
					class="board_area button">목록으로</button>
				<button type="button" onclick="updatePost()"
					class="board_area button">수정하기</button>
			</div>

			<div class="comment_area">
				<h3>댓글</h3>
				<div id="commentList"></div>
				<textarea id="commentContent" class="textarea"
					placeholder="댓글을 입력하세요"></textarea>
				<button type="button" onclick="addComment()"
					class="board_area button">댓글 등록</button>
			</div>
		</div>
	</div>
</body>

<script>
	function updatePost() {
		var postId = $("#postNo").text();
		var title = $("#title").val();
		var contents = $("#contents").val();

		$.ajax({
			url : "updateFreePost",
			method : "POST",
			data : {
				f_no : postId,
				f_title : title,
				f_content : contents
			},
			success : function(result) {
				if (result === "success") {
					alert("게시물이 성공적으로 수정되었습니다.");
					location.href = 'free_board.jsp';
				} else {
					alert("게시물 수정에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}

	$(document).on('click', '.editable', function() {
		$(this).removeAttr('readonly');
		$(this).css('border', '1px solid #3498db');
	});

	$(document).on('blur', '.editable', function() {
		$(this).attr('readonly', true);
		$(this).css('border', 'none');
	});

	function addComment() {
		var postId = $("#postNo").text();

		var commentContent = $("#commentContent").val();

		$.ajax({
			url : "addComment",
			method : "POST",
			data : {
				fr_content : commentContent,
				fr_ori_bbs : postId
			},
			success : function(result) {
				if (result === "success") {
					alert("댓글이 성공적으로 등록되었습니다.");
					getComments(postId);
					location.reload();
				} else {
					alert("댓글 등록에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}

	/* function addComment() {
		var postId = $("#postNo").text();
		var commentContent = $("#commentContent").val();
		var fNum = getParameterByName("f_num");

		$.ajax({
			url : "addComment",
			method : "POST",
			data : {
				fr_content : commentContent,
				fr_ori_bbs: fNum
			},
			success : function(result) {
				if (result === "success") {
					alert("댓글이 성공적으로 등록되었습니다.");
					getComments(postId);
					location.reload();
				} else {
					alert("댓글 등록에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}  */
	
	function getComments(postId) {
		$.ajax({
			url : "getComments",
			data : {
				fr_ori_bbs : postId
				/* fr_ori_bbs : fNum */
			},
			dataType : "json",
			success : function(comments) {
				console.log("댓글 정보 수신:", comments);

				if (comments && Array.isArray(comments)) {
					comments.reverse();
					comments.forEach(function(comment) {
						console.log(comment);
						var commentTime = new Date(comment.fr_time);
						var formattedCommentTime = commentTime ? commentTime
								.getFullYear()
								+ "-"
								+ (commentTime.getMonth() + 1)
								+ "-"
								+ commentTime.getDate() : "Unknown Date";
						var commentHtml = '<p>'
								+ '작성자 : <span class="comment-info">'
								+ (comment.fr_writer || "Unknown Writer")
								+ '</span>'
								+ '작성 날짜 : <span class="comment-info">'
								+ formattedCommentTime + '</span><br />'
								+ '</p>' + '<p class="comment-content">'
								+ (comment.fr_content || "No Content")
								+ '</p><br>';
						$(".comment_area").append(commentHtml);
					});
				} else {
					console.log("댓글 목록이 비어있습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("댓글 정보를 가져오는 중 에러 발생:", status, error);
				console.log(JSON.stringify(comments));
			}
		});
	}
</script>
</html>