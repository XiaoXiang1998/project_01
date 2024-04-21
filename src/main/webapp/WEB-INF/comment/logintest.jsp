<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登入</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	text-decoration: none;
}

body {
	background-color: #a4a4d2;
}

.hill {
	width: 400px;
	height: 500px;
	background-color: #81D8cf;
	margin: 10% auto;
	color: #2d3436;
	border-radius: 15px;
	padding: 60px;
	transition: .5s;
}

.hill h1 {
	text-align: center;
	margin: 15px 0;
	letter-spacing: 1px;
	color: #FD7914;
}

.hill form {
	margin-top: 10px;
	width: 100%;
}

.hill .form-group {
	margin-bottom: 10px;
}

.hill .form-group .form-control {
	border: none;
	background: transparent;
	border-bottom: 1px solid #ccc;
	outline: none;
	padding: 10px;
	width: 100%;
}

.hill .form-group .log-btn {
	border: 0;
	background-image: linear-gradient(100deg, #F6D242, #FF52E5, #5ffbf1);
	/*
#F6D242
#FF52E5 */
	padding: 10px 0;
	color: #ffff;
	font-size: 15px;
	letter-spacing: 0.5px;
	margin-top: 5px;
	background-size: 100%;
	transition: 0.5s;
	border-radius: 10px;
}

.hill .sign-up #si {
	transition: 0.5s;
	font-size: 17px;
	margin-left: 2px;
	display: inline-block;
	color: #54a0ff;
}

#forget {
	margin-left: 170px;
	display: inline-block;
	color: #54a0ff;
}
</style>
</head>
<body>


	<div class="hill">
		<h1>用戶登錄</h1>
		<div class="data">
			<form action="login" method="post">
				<div class="form-group">
					<input type="text" class="form-control" name="username"
						placeholder="帳號" /><br>
					<br>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" name="pwd"
						placeholder="密碼" /><br>
				</div>

				<c:if test="${not empty error}">
					<div class="error-message">
						<p>${error}</p>
					</div>
				</c:if>
				<div class="form-group" style="margin-top: 20px">
					<input type="checkbox"> <span class="chk-box"> 記住密碼<br>
					</span>
				</div>
				<div class="form-group">
					<input type="submit" class="form-control log-btn" placeholder="登录" />
				</div>
				<div class="form-group">
					<input type="reset" class="form-control log-btn" placeholder="重置" />
				</div>
			</form>
		</div>
	</div>

</body>
</html>