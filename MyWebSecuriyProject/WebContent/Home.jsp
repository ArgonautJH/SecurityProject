<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Encryption Services</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="styles.css"> <!-- 스타일 시트 추가 -->
</head>
<body>

<div class="container mt-5">
  <h1 class="text-center">Encryption Services</h1>
  
  <div class="row mt-4">
    <div class="col-md-4">
      <button class="btn btn-primary btn-block animated-button" onclick="changePage('hashEncrypt')">해시값 구하기</button>
    </div>
    <div class="col-md-4">
      <button class="btn btn-primary btn-block animated-button" onclick="changePage('FileEncrypt')">파일 암호화</button>
    </div>
    <div class="col-md-4">
      <button class="btn btn-primary btn-block animated-button" onclick="changePage('base64')">Base64</button>
    </div>
  </div>

  <div id="content" class="mt-5">
    <!-- 페이지 내용은 여기에 동적으로 로딩 -->
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="homeEvent.js"></script>

</body>
</html>