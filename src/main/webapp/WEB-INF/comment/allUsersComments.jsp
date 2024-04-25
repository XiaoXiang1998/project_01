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

.seller-reply {
    background-color: #f0f0f0; /* 将背景颜色调暗 */
    border-radius: 8px;
    padding: 10px;
    margin-bottom: 10px;
    color: #333; /* 设置文本颜色为黑色 */
}

/* 預設按鈕樣式 */
.tab button {
  border: none;
  outline: none;
  cursor: pointer;
  padding: 10px 15px;
  transition: background-color 0.3s;
  margin: 0 5px; /* 調整按鈕之間的間距 */
  position: relative; /* 將span元素定位相對於按鈕 */
}

/* 按鈕上的數字樣式 */
.tab button .badge {
  position: absolute; /* 使用絕對位置 */
  top: -10px; /* 調整數字在按鈕上的位置 */
  right: -10px; /* 調整數字在按鈕上的位置 */
  background-color: #ff0000; /* 設置背景顏色 */
  color: #ffffff; /* 設置文字顏色 */
  border-radius: 50%; /* 圓形邊框 */
  padding: 5px; /* 調整內邊距 */
  font-size: 12px; /* 調整字體大小 */
  display: inline-block; /* 使span元素顯示為行內塊 */
  opacity: 1; /* 初始時顯示 */
  transition: opacity 0.3s; /* 添加過渡效果 */
}

/* 鼠標懸停時的效果 */
.tab button:hover {
  background-color: rgba(0, 0, 0, 0.1);
}

/* 激活/選中按鈕的樣式 */
.tab button.active {
  background-color: rgba(0, 0, 0, 0.2);
  color: #fff; /* 設置文字顏色 */
}

/* 框框樣式 */
.tab button {
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 5px;
  background-color: transparent;
}

/* 將按鈕置中 */
.tab {
  text-align: center;
}
</style>
</head>
<body>
	<%@ include file="indexcomment.jsp"%>
	
<div class="tab">
  <button class="tablinks" onclick="openTab(event, 'all')">
    全部<span class="badge">${totalPosts}</span>
  </button>
  <button class="tablinks" onclick="openTab(event, 'fiveStars')">
    五星<span class="badge">${fiveStarsCount}</span>
  </button>
  <button class="tablinks" onclick="openTab(event, 'fourStars')">
    四星<span class="badge">${fourStarsCount}</span>
  </button>
  <button class="tablinks" onclick="openTab(event, 'threeStars')">
    三星<span class="badge">${threeStarsCount}</span>
  </button>
  <button class="tablinks" onclick="openTab(event, 'twoStars')">
    二星<span class="badge">${twoStarsCount}</span>
  </button>
  <button class="tablinks" onclick="openTab(event, 'oneStar')">
    一星<span class="badge">${oneStarCount}</span>
  </button>
    <button class="tablinks" onclick="openTab(event, 'commentsButton')">附上評論<span class="badge">${commentedPostsCount}</span>
    </button>
    <button class="tablinks" onclick="openTab(event, 'media')">附上照片/影片<span class="badge">${postsWithImagesCount}</span></button>
</div>
	
	
	<div id="all" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
        <c:if test="${post.member.seller != 1}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>

	
	<!-- 五星評價 -->
<div id="fiveStars" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
        <c:if test="${post.member.seller != 1 and post.buyerrate == 5}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>

<!-- 四星評價 -->
<div id="fourStars" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
        <c:if test="${post.member.seller != 1 and post.buyerrate == 4}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>

<!-- 3星評價 -->
<div id="threeStars" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
        <c:if test="${post.member.seller != 1 and post.buyerrate == 3}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>


<!-- 2星評價 -->
<div id="twoStars" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
        <c:if test="${post.member.seller != 1 and post.buyerrate == 2}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>

<!-- 1星評價 -->
<div id="oneStar" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
        <c:if test="${post.member.seller != 1 and post.buyerrate == 1}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>

<div id="commentsButton" class="tabcontent">
  <c:forEach items="${allMembers}" var="member">
    <div class="container">
      <c:forEach items="${member.posts}" var="post">
<c:if test="${post.member.seller != 1 and not empty post.commentcontent and post.commentcontent ne ''}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <c:if test="${not empty post.productphoto}">
                    <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  </c:if>
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
</div>
<div id="media" class="tabcontent">
<c:forEach items="${allMembers}" var="member">
  <c:forEach items="${member.posts}" var="post">
    <!-- 添加检查是否有照片的条件 -->
    <c:if test="${not empty post.productphoto}">
      <div class="container">
        <c:if test="${post.member.seller != 1}">
          <div class="item">
            <i class="avatar"></i>
            <div class="info">
              <p class="name">${member.name}</p>
              <div class="comment-container">
                <div class="comment">
                  <c:if test="${not empty post.buyerrate}">
                    <c:forEach begin="1" end="${post.buyerrate}">
                      <img src="commentPicture/output.png" alt="star" width="20" height="20">
                    </c:forEach>
                  </c:if>
                  <c:if test="${not empty post.commenttime}">
                    <fmt:formatDate value="${post.commenttime}" pattern="yyyy-MM-dd HH:mm" var="formattedCommentTime" />
                    <p class="time">${formattedCommentTime}</p>
                  </c:if>
                  <img class="product-photo" src="${pageContext.request.contextPath}/${post.productphoto}" alt="產品圖片">
                  <p class="text">${post.commentcontent}</p>
                </div>
                <c:if test="${loggedInMember.seller == 1 and not empty post.buyerrate}">
                  <p>
                    <a href="#" class="replyLink" data-target="replyFormContainer${post.commentid}" data-commentid="${post.commentid}">回覆買家</a>
                  </p>
                  <div id="replyFormContainer${post.commentid}" style="display: none;">
                    <form action="/submitReply" method="post" class="bootstrap-frm" id="replyForm${post.commentid}">
                      <span class="close-btn" onclick="closeReplyForm('${post.commentid}')">×</span>
                      <h1 id="alter">回覆<span>請填寫回覆內容</span></h1>
                      <input type="hidden" name="memberId" value="${member.sid}">
                      <input type="hidden" name="commentId" value="${post.commentid}">
                      <label><span>回覆內容:</span> <textarea id="replyContent${post.commentid}" name="replyContent" rows="10" cols="30" maxlength="100" placeholder="Your Reply" required></textarea></label>
                      <span class="replyContent${post.commentid}" id="replyContent" data->輸入的字數:0/100</span><br />
                      <div class="bit-com">
                        評分:<span class="bit" id="bit1"></span> <span class="bit" id="bit2"></span> <span class="bit" id="bit3"></span> <span class="bit" id="bit4"></span> <span class="bit" id="bit5"></span>
                      </div>
                      <input type="hidden" name="rate" id="replyRate${post.commentid}" value="0">
                      <label><span>&nbsp;</span> <input type="submit" class="button" value="Send Reply" /></label>
                    </form>
                  </div>
                </c:if>
                <c:forEach items="${allMembers}" var="seller">
                  <c:forEach items="${seller.posts}" var="reply">
                    <c:if test="${reply.repliedcommentid == post.commentid}">
                      <div class="seller-reply">
                        <p class="text">賣家回覆<br/><br/>${reply.replayconetnt}</p>
                        <c:if test="${not empty reply.replaytime}">
                          <fmt:formatDate value="${reply.replaytime}" pattern="yyyy-MM-dd HH:mm" var="formattedReplayTime" />
                          <p class="time">回覆時間: ${formattedReplayTime}</p>
                        </c:if>
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
      </div>
    </c:if>
  </c:forEach>
</c:forEach>
</div>
	<script>
	$(function(){
		
	
	  $('.replyLink').click(function(event) {
	        event.preventDefault();
	        var targetId = $(this).data('target');
	        var commentId = $(this).data('commentid');
	        var containerOffset = $(this).closest('.container').offset();
	        $('#' + targetId).css({
	            'top' : containerOffset.top + 'px',
	            'left' : containerOffset.left + 'px'
	        }).show();
			
	        $('#' + targetId).find('textarea').focus();

	    
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
	        var commentId = $(this).attr('id').replace('replyForm', ''); // 获取表单的 commentid
	        $('#replyRate' + commentId).val(rating);

	        if (rating < 1) {
	            alert('請選擇服務1~5顆星之間的評分值');
	            return false;
	        }
	        
	        $('#replyFormContainer' + commentId).hide();

	        $('.replyLink[data-commentid="' + commentId + '"]').hide();
	        return true;
	    });
	    $('body').on('input', 'textarea[id^="replyContent"]', function() {
	        var commentId = $(this).attr('id').replace('replyContent', '');
	        var text = $(this).val();
	        var charCount = text.length;
	        $('.replyContent' + commentId).text('輸入的字數:' + charCount + '/100');
	        if (charCount > 100) {
	            $(this).val(text.slice(0, 100));
	            $('.replyContent' + commentId).text('輸入的字數:100/100');
	        }
	    });
	    
	});
	    function closeReplyForm(commentId) {
		    $('#replyFormContainer' + commentId).hide();
		    $('.replyLink[data-commentid="' + commentId + '"]').show();
		}
	
	
	
	</script>
	
	<script>
	function openTab(evt, tabName) {
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(tabName).style.display = "block";
		  evt.currentTarget.className += " active";
		}

		// 頁面加載後，顯示全部內容
		document.getElementById("all").click();
		
		document.getElementById("commentsButton").click();
		
	    document.getElementById("media").click();


	</script>
</body>
</html>