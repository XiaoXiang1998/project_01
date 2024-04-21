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
</style>
</head>
<body>
    <c:forEach items="${allMembers}" var="member">
        <div class="container">
            <c:forEach items="${member.posts}" var="post">
                <div class="item">
                    <i class="avatar"></i>
                    <div class="info">
                        <p class="name">${member.name}</p>
                        <div class="comment-container"> <!-- New container for each comment -->
                            <div class="comment"> <!-- New container for each comment -->
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
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div> <!-- Close the container inside the loop -->
    </c:forEach>
</body>
</html>