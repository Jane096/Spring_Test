<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<title>board</title>
<style>
.board_title {
	font-weight : 700;
	font-size : 22pt;
	margin : 20pt;
	padding-top: 20px;	
}

.board_info_box {
	color : #6B6B6B;
	margin : 20pt;
}

.board_author {
	font-size : 10pt;
	margin-right : 10pt;
	padding-bottom: 30px;
}

.board_date {
	font-size : 10pt;
}

.board_content {
	color : #444343;
	font-size : 12pt;
	margin : 20pt;
	padding-bottom: 30px;
}

</style>

<%@ include file="../include/header.jsp" %>

<body>
	<article style="padding-bottom: 40px;">
		<div class="container" role="main">
			<h1 class="page-header">Board Read</h1>
			<div class="bg-white rounded shadow-sm">
				<div class="board_title" >
					<c:out value="${board.title}" />
				</div>
				<div class="board_info_box">
					<span class="board_author">No.
						<c:out value="${board.bno}" /></span>
					<span class="board_author">작성자: <c:out
							 value="${board.writer}" /></span>
					<span  class="board_author"><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.regdate}" /></span>
					<span class="board_date">Latest Update: <fmt:formatDate  pattern="yyyy-MM-dd"
							value="${board.updatedate}" /></span>
				</div>
				<div class="board_content"><c:out value="${board.content}" /></div>
			</div>
		<div style="margin-top: 20px">
				<button type="button" class="btn btn-sm btn-primary" id="btnUpdate" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">수정</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnDelete">삭제</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList"  onclick="location.href='/board/list'">목록</button>
			</div>
		</div>
	</article>
<%@ include file="../include/footer.jsp" %>   