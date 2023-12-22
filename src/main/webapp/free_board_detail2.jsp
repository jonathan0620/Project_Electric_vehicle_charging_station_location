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

.btn_area button, .comment-modal button {
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

.comment_area button{
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

.comment_area button.update-comment, .comment_area button.delete-comment
	{
	width: 50px;
	margin-left: 5px;
	padding: 1px 1px;
	background-color: #3498db;
	color: #fff;
	border: none;
	cursor: pointer;
	border-radius: 20px;
}

.comment-modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	width: 25%;
	height: 30%;
	overflow: auto;
	background-color: #fff;
	padding-top: 50px;
	border: 2px solid rgba(13,110,253,.25);
}

.modal-content {
	background-color: #fefefe;
	padding: 10px;
	border: 1px solid #888;
	width: 80%;
	margin: auto;
}

.modal-close {
  color: #aaa;
  font-size: 28px;
  font-weight: bold;
}

.modal-close:hover, .modal-close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
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

				getComments(fNum);
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
				<button type="button" onclick="deletePost()"
					class="board_area button">삭제하기</button>
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
<!-- 댓글 수정 모달 -->
<div id="commentModal" class="comment-modal">
	<div class="modal-content">
		<span class="modal-close" onclick="closeModal()">&times;</span>
		<textarea id="editCommentContent" class="textarea"
			placeholder="댓글을 수정하세요"></textarea>
		<button type="button" onclick="updateComment()"
			class="board_area button">수정 완료</button>
	</div>
</div>
<script>
	// 게시글 수정하기
	function updatePost() {
		var postId = $("#postNo").text();
		var title = $("#title").val();
		var contents = $("#contents").val();
		var fNum = getParameterByName('f_num');

		$.ajax({
			url : "updateFreePost",
			method : "POST",
			data : {
				f_no : postId,
				f_title : title,
				f_content : contents,
				f_num : fNum
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

	//게시글 + 댓글 삭제하기
	function deletePost() {
		var postId = $("#postNo").text();
		var fNum = getParameterByName('f_num');

		$.ajax({
			url : "deleteFreePostWithComments",
			method : "POST",
			data : {
				f_no : postId,
				f_num : fNum
			},
			success : function(result) {
				if (result === "success") {
					alert("게시물이 성공적으로 삭제되었습니다.");
					location.href = 'free_board.jsp';
				} else {
					alert("게시물 삭제에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}

	// 댓글 추가
	function addComment() {
		var fNum = getParameterByName('f_num');
		var commentContent = $("#commentContent").val();

		$.ajax({
			url : "addComment",
			method : "POST",
			data : {
				fr_content : commentContent,
				fr_ori_bbs : fNum
			},
			success : function(result) {
				if (result === "success") {
					alert("댓글이 성공적으로 등록되었습니다.");
					getComments(fNum);
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
	
	// 댓글 불러오기
	function getComments(postId) {
		var fNum = getParameterByName('f_num');
		$
				.ajax({
					url : "getComments",
					data : {
						fr_ori_bbs : fNum
					},
					dataType : "json",
					success : function(comments) {
						console.log("댓글 정보 수신:", comments);

						if (comments && Array.isArray(comments)) {
							comments.reverse();
							comments
									.forEach(function(comment) {
										console.log(comment);
										var commentTime = new Date(
												comment.fr_time);
										var formattedCommentTime = commentTime ? commentTime
												.getFullYear()
												+ "-"
												+ (commentTime.getMonth() + 1)
												+ "-" + commentTime.getDate()
												: "Unknown Date";
										var commentHtml = '<p>'
												+ '작성자 : <span class="comment-info">'
												+ (comment.fr_writer || "Unknown Writer")
												+ '</span>'
												+ '작성 날짜 : <span class="comment-info">'
												+ formattedCommentTime
												+ '</span>'
												+ ' <button class="update-comment" onclick="openEditCommentModal('
												+ comment.fr_num
												+ ')">수정</button>'
												+ ' <button class="delete-comment" onclick="deleteComment('
												+ comment.fr_num
												+ ')">삭제</button>'
												+ '</p>'
												+ '<p class="comment-content">'
												+ (comment.fr_content || "No Content")
												+ '</p>' + '<br>';
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
	//전체 댓글 삭제
	function deleteComments(fNum) {
		$.ajax({
			url : "deleteComments",
			method : "POST",
			data : {
				f_num : fNum
			},
			success : function(result) {
				if (result === "success") {
					console.log("댓글이 성공적으로 삭제되었습니다.");
				} else {
					console.log("댓글 삭제에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("댓글 삭제 중 에러 발생:", status, error);
			}
		});
	}
	// 댓글 삭제
	function deleteComment(fNum, frNum) {
	    $.ajax({
	        url: "deleteComment",
	        method: "POST",
	        data: {
	            f_num: fNum,
	            fr_num: frNum
	        },
	        success: function (result) {
	            if (result === "success") {
	                console.log("댓글이 성공적으로 삭제되었습니다.");
	                var postId = getParameterByName('f_no');
	                getComments(postId);
	            } else {
	                console.log("댓글 삭제에 실패했습니다.");
	            }
	        },
	        error: function (xhr, status, error) {
	            console.error("댓글 삭제 중 에러 발생:", status, error);
	        }
	    });
	}

	// 댓글 수정 모달 열기
	function openEditCommentModal(commentId, currentContent) {
		$("#editCommentContent").val(currentContent);
		$("#commentModal").show();
		$("#commentModal").attr("data-comment-id", commentId);
	}

	// 댓글 수정 모달 닫기
	function closeModal() {
		$("#commentModal").hide();
		$("#commentModal").removeAttr("data-comment-id");
	}

	// 댓글 수정
	function updateComment() {
		var commentId = $("#commentModal").attr("data-comment-id");
		var editedContent = $("#editCommentContent").val();
		var fNum = getParameterByName('f_num');

		$.ajax({
			url : "updateComment",
			method : "POST",
			data : {
				fr_num : commentId,
				fr_content : editedContent,
				fr_ori_bbs : fNum
			},
			success : function(result) {
				if (result === "success") {
					alert("댓글이 성공적으로 수정되었습니다.");
					closeModal();
					getComments(fNum);
					location.reload();
				} else {
					alert("댓글 수정에 실패했습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Ajax 요청 중 에러 발생:", status, error);
			}
		});
	}
</script>
</html>