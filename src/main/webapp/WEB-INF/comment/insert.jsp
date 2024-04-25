<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FORM Text</title>
<link rel="stylesheet" id="templatecss" type="text/css"
	href="/commentcss/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
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

#alter {
	text-align: center;
}

button {
	display: block;
	margin: 20px auto; /* 垂直居中并且与表单上方有 20px 的距离 */
	text-align: center; /* 水平居中 */
}

.charCount {
	text-align: center;
	display: block;
}

#file {
	display: inline-block;
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="indexcomment.jsp" %>
	
		<form action="post" method="post" class="basic-grey"
		id="commentForm" enctype="multipart/form-data">
		<h1 id="alter">
			評論區<span>請發表友善評論!</span>
		</h1>
		 <label> <span>要給的評論 :</span> <textarea id="CommentContent"
				name="commentContent" rows="10" cols="30" maxlength="100"
				placeholder="請寫下您的評論"></textarea>
		</label> <span id="charCount" class="charCount">輸入的字數:0/100</span><br /> <label>
			<span id="image">圖片:</span> <input id="file" type="file"
			name="productimage" />
		</label>
		<div class="bit-com">
			服務評價:<span class="bit"></span> <span class="bit"></span> <span
				class="bit"></span> <span class="bit"></span> <span class="bit"></span>
		</div>
		<input type="hidden" name="rate" id="rate" value="0"><label>
			<span>&nbsp;</span> <input type="submit" class="button" value="Send" />
		</label>

	</form>

	<script>

		$(document).ready(function() {
			var rating = 0;

			$('.bit-com .bit').on('click', function() {
				$('.bit-com .bit').removeClass('on');
				var index = $(this).index();
				$('.bit-com .bit').slice(0, index + 1).addClass('on');
				rating = index + 1;
			});

			$('#commentForm').on('submit', function() {

				$('#rate').val(rating);

				if (rating < 1) {
					alert('請選擇服務1~5顆星之間的評分值');
					return false;
				}
				return true;
			});

			$('#CommentContent').on('input', function() {
				var text = $(this).val();
				var charCount = text.length;
				$('#charCount').text(charCount + ' / 100');

				// 如果字數超過 200，則截斷文本
				if (charCount > 100) {
					$(this).val(text.slice(0, 100));
					$('#charCount').text('100 / 100');
				}
			});
		});
	</script>
</body>
</html>