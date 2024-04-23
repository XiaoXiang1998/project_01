<%@page import="java.sql.Time"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>評論資料</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" id="templatecss" type="text/css"
	href="/commentcss/style.css">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
}

.item {
	position: relative;
	background-color: #fff;
	border-radius: 8px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.avatar {
	width: 50px;
	height: 50px;
	background-color: #ccc;
	border-radius: 50%;
	display: inline-block;
	margin-right: 20px;
}

.info {
	display: inline-block;
	vertical-align: top;
	width: calc(100% - 70px); /* 50px avatar + 20px margin */
}

.name {
	color: #FB7299;
	font-size: 16px;
	font-weight: bold;
	margin: 0 0 10px 0;
}

.stars img {
	width: 20px;
	height: 20px;
	margin-right: 5px;
}

.time {
	color: #999;
	font-size: 14px;
	margin-bottom: 10px;
}

.product-photo {
	margin-bottom: 10px;
	width: 80px;
	height: 80px;
}

.no-image {
	display: none;
}

.text {
	color: #333;
	font-size: 14px;
	line-height: 1.5;
}

/* New CSS for separating user comments */
.comment-container {
	margin-top: 20px;
}

.comment {
	background-color: #f9f9f9;
	border-radius: 8px;
	padding: 10px;
	margin-bottom: 10px;
}

.bit-com .bit {
	display: inline-block;
	width: 32px;
	height: 24px;
	background: url(commentPicture/star8.jpg) no-repeat;
	background-size: 24px 24px;
	text-align: center;
}

.bit-com .bit.on {
	background: url(commentPicture/output.png) no-repeat;
	background-size: 24px 24px;
}
</style>
</head>
<body>
	<%@ include file="indexcomment.jsp"%>

	<c:forEach items="${allMembers}" var="member">
    <div class="container">
        <c:forEach items="${member.posts}" var="post">
            <c:if test="${post.member.seller != 1}">
                <div class="item">
                    <i class="avatar"></i>
                    <div class="info">
                        <p class="name">${member.name}</p>
                        <div class="comment-container">
                            <!-- Buyer's comment -->
                            <div class="comment">
                                <!-- Display buyer's rating stars if available -->
                                <c:if test="${not empty post.buyerrate}">
                                    <c:forEach begin="1" end="${post.buyerrate}">
                                        <img src="commentPicture/output.png" alt="star" width="20" height="20">
                                    </c:forEach>
                                </c:if>
                                <!-- Display comment time if available -->
                                <c:if test="${not empty post.commenttime}">
                                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                                    <p class="time">${formattedCommentTime}</p>
                                </c:if>
                                <!-- Display product photo if available -->
                                <c:if test="${not empty post.productphoto}">
                                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                                </c:if>
                                <p class="text">${post.commentcontent}</p>
                            </div>

                            <!-- Only visible to sellers: Reply link -->
                            <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                                <p>
                                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                                </p>
                                <!-- Hidden reply form -->
                                <div id="replyFormContainer${post.commentid}" style="display: none;">
										 <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}" enctype="multipart/form-data">
                                    <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                                        <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                                        <input type="hidden" name="memberId" value="${member.sid}">
                                        <input type="hidden" name="commentId" value="${post.commentid}">
                                        <label><span>回覆內容:</span> <textarea id="replyContent" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                                        <span class="replyContent">輸入的字數:0/100</span><br />
                                        <!-- Rating stars -->
                                        <div class="bit-com">
                                            评分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                                        </div>
                                        <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                                        <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                                    </form>
                                </div>
                            </c:if>

                            <!-- Seller's replies -->
                            <c:forEach items="${allMembers}" var="seller">
                                <c:forEach items="${seller.posts}" var="reply">
                                    <!-- Check if the reply is for this post -->
                                    <c:if test="${reply.repliedcommentid == post.commentid}">
                                        <!-- Display seller's reply within buyer's comment -->
                                        <div class="seller-reply">
                                            <!-- Display reply content -->
                                            <p class="text">賣家回覆:${reply.replayconetnt}</p>
                                            <!-- Display reply time if available -->
                                            <c:if test="${not empty reply.replaytime}">
                                                <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                                                <p class="time">回覆時間: ${formattedReplayTime}</p>
                                            </c:if>
                                            <!-- Display seller's rating stars if available -->
                                            <c:if test="${not empty reply.sellerrate}">
                                                <div class="bit-com">
                                                    <c:forEach begin="1" end="${reply.sellerrate}">
                                                        <img src="commentPicture/output.png" alt="star" width="20" height="20">
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</c:forEach>


	<script>
	$(function() {
	    $('.replyLink').click(function(event) {
	        event.preventDefault();
	        var targetId = $(this).data('target');
	        var commentId = $(this).data('commentid');
	        var containerOffset = $(this).closest('.container').offset();
	        $('#' + targetId).css({
	            'top' : containerOffset.top + 'px',
	            'left' : containerOffset.left + 'px'
	        }).show();
			
	    
	        $(this).hide();
	        
	        rating = 0;
	        
	        $('#replyForm' + commentId).data('commentid', commentId);
	    });

	    var rating = 0;

	    $('body').on('click', '.bit-com .bit', function() {
	        $(this).siblings().removeClass('on');
	        $(this).prevAll().addBack().addClass('on');
	        var index = $(this).index() + 1;
	        rating = index;
	    });    

	    $('body').on('submit', '.bootstrap-frm', function() {
	        var commentId = $(this).data('commentid');
	        $('#replyRate' + commentId).val(rating);

	        if (rating < 1) {
	            alert('請選擇服務1~5顆星之間的評分值');
	            return false;
	        }
	        
	        $('#replyFormContainer' + commentId).hide();

	        $('.replyLink[data-commentid="' + commentId + '"]').hide();
	        return true;
	    });

	    $('body').on('input', '.bootstrap-frm textarea', function() {
	        var text = $(this).val();
	        var charCount = text.length;
	        $(this).siblings('.replyContent').text(charCount + ' / 100');
	        if (charCount > 100) {
	            $(this).val(text.slice(0, 100));
	            $(this).siblings('.replyContent').text('100 / 100');
	        }
	    });
	});
	
	function closeReplyForm(commentId) {
	    $('#replyFormContainer' + commentId).hide();
	    $('.replyLink[data-commentid="' + commentId + '"]').show();
	}
	</script>
</body>
</html>