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

ul, li {
	margin: 0;
	padding: 0;
}

.board_title {
	border-bottom: 1px solid #3498db;
}

.board_list {
	margin: 20px 30px;
	min-height: 300px;
}

.board_list>ul {
	border-bottom: 1px solid #f3f5f7;
	height: 50px;
	line-height: 50px;
	display: flex;
	justify-content: space-around;
	list-style: none;
}

.board_list>ul.last {
	border: 0;
}

.board_list>ul>li {
	text-align: center;
}

.board_header {
	background: #3498db;
	color: white;
	font-weight: bold;
}

.onmouseover {
	background: #f3f5f7;
	cursor: pointer;
}

.board_paging {
	height: 50px;
	line-height: 50px;
	display: flex;
	justify-content: center;
	list-style: none;
	width: 480px;
	margin: auto;
}

.board_paging a {
	text-decoration: none;
	color: #282A35;
	width: 40px;
	display: block;
	text-align: center;
}

.board_paging a.current_page {
	border-bottom: 2px solid #3498db;
	font-weight: bold;
}

.search_area {
	text-align: center;
	padding: 30px;
}

.search_area select {
	width: 150px;
	height: 30px;
	border: 0px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-right: 5px;
	border-radius: 5px;
}

.input_area {
	border: solid 1px #dadada;
	padding: 10px 10px 14px 10px;
	margin-right: 20px;
	background: white;
}

.input_area input {
	width: 250px;
	height: 30px;
	border: 0px;
}

.input_area input:focus, .search_area select:focus {
	outline: none;
}

.search_area .btn_search {
	width: 100px;
	height: 35px;
	border: 0px;
	color: white;
	background: #3498db;
	margin: 5px;
}

.search_area input {
	width: 170px;
	height: 35px;
	border: 1px solid #3498db;
	border-radius: 5px; /* 보더 모서리 둥글게 만들기 */
	margin: 5px;
	cursor: pointer;
}

.pagination {
	height: 40px;
	line-height: 50px;
	display: flex;
	justify-content: center;
	list-style: none;
	width: 480px;
	margin: auto;
}

.pagination a {
	text-decoration: none;
	color: #3498db;
	width: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	cursor: pointer;
	margin: 0 5px;
	width: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	border: 1px solid #ccc;
}

.pagination a.current_page {
	border-bottom: 2px solid #3498db;
	font-weight: bold;
}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {

		var currentPage = 1; // 초기 페이지
		var pageSize = 10; // 페이지당 표시할 게시물 수
		var numPages; // 전체 페이지 수
		var table;

		//게시글 리스트 불러오기
		function loadFreeList(page) {
			$.ajax({
				url : "free_list",
				data : {
					page : page,
					pageSize : pageSize
				},
				dataType : "json",
				success : function(result) {
					console.log("Received data:", result);
					numPages = result.numPages;
					console.log("Number of pages:", numPages);
					console.log("Data for page " + page + ":", result.posts);
					displayData(result.posts);
					renderPaginationButtons();
				},
				error : function(xhr, status, error) {
					console.error("Ajax 요청 중 에러 발생:", status, error);
				}
			});
		}

		//검색 + 페이징 기능
		function getSearchList(page) {
			$.ajax({
				type : 'GET',
				url : "getSearchList",
				data : {
					page : page,
					pageSize : pageSize,
					type : $("form[name=search-form] select[name=type]").val(),
					keyword : $("form[name=search-form] input[name=keyword]")
							.val()
				},
				dataType : "json",
				success : function(result) {
					console.log("Received search data:", result);
					numPages = result.numPages;
					console.log("Number of pages:", numPages);
					console.log("Data for page " + page + ":", result.posts);
					displayData(result.posts);
					renderPaginationButtons();
				},
				error : function(xhr, status, error) {
					console.error("Ajax 요청 중 에러 발생:", status, error);
				}
			});
		}

		function displayData(posts) {
			$(".board_list").empty();
			var table = $("<table>").addClass("table");
			var thead = $("<thead>").addClass("board_header").appendTo(table);
			var tbody = $("<tbody>").appendTo(table);

			var headerRow = $("<tr>").appendTo(thead);
			$("<th>").text("글번호").appendTo(headerRow);
			$("<th>").text("제목").appendTo(headerRow);
			$("<th>").text("내용").appendTo(headerRow);
			$("<th>").text("작성자").appendTo(headerRow);
			$("<th>").text("좋아요수").appendTo(headerRow);
			$("<th>").text("작성일").appendTo(headerRow);
			$("<th>").text("조회수").appendTo(headerRow);

			$.each(posts, function(index, post) {
				var row = $("<tr>").appendTo(tbody);
				$("<td>").text(post.f_no).appendTo(row);
				$("<td>").html(
						"<a href='free_board_detail2.jsp?f_no=" + post.f_no
								+ "&f_num=" + post.f_num
								+ "' class='post-link' data-post-id='"
								+ post.f_no + "'>" + post.f_title + "</a>")
						.appendTo(row);
				$("<td>").text(post.f_content).appendTo(row);
				$("<td>").text(post.f_writer).appendTo(row);
				$("<td>").text(post.f_like).appendTo(row);
				var formattedDate = new Date(post.f_time).toISOString().split(
						'T')[0];
				$("<td>").text(formattedDate).appendTo(row);
				$("<td>").text(post.f_view).appendTo(row);
			});

			$(".board_list").html(table);
		}

		function renderPaginationButtons() {
			$(".pagination").empty();
			if (numPages > 1) {
				for (var i = 1; i <= numPages; i++) {
					$("<a>").attr("href", "#").data("page", i).text(i)
							.appendTo(".pagination");
				}
			}
			$(".pagination a[data-page='" + currentPage + "']").addClass(
					"current");
		}

		$(document).on("click", ".pagination a", function(e) {
			e.preventDefault();
			currentPage = $(this).data("page");
			console.log("Requested page:", currentPage);
			if ($("form[name=search-form]").length > 0) {
				getSearchList(currentPage);
			} else {
				loadFreeList(currentPage);
			}
		});

		$(document).on("submit", "form[name='search-form']", function(e) {
			e.preventDefault();
			getSearchList(1);
		});

		loadFreeList(currentPage);
	});
</script>
</head>
<body>
	<!-- 상단바 -->
	<!--	<a href="free_list">controller 호출</a>
					<a href="test">controller 호출</a> -->
	<div id="top">
		<jsp:include page="header.jsp"></jsp:include>
	</div>

	<div class="outer">
		<div class="wrap">
			<div class="board_area">
				<div class="board_title">
					<h3>자유게시판</h3>
				</div>
				<div class="board_list"></div>
			</div>
			<!-- 페이징 부분 -->
			<div class="pagination">
				<c:if test="${numPages > 1}">
					<c:forEach begin="1" end="${numPages}" var="pageNum">
						<a href="#" data-page="${pageNum}">${pageNum}</a>
					</c:forEach>
				</c:if>
			</div>
			<div class="search_area">
				<form name="search-form" autocomplete="off">
					<select name="type">
						<option selected value="">카테고리 선택</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="writer">작성자</option>
					</select> <input type="text" name="keyword" value=""></input> <input
						type="submit" class="btn_search" value="검색하기"></input> <input
						type="button"
						onclick="window.location.href='free_board_insert.jsp'"
						class="btn_search" value="작성하기"></input>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

</body>
</html>