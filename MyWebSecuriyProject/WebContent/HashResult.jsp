<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<jsp:useBean id="hash" class="bean.HashBean"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css"> <!-- 스타일 시트 추가 -->
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" 
        crossorigin="anonymous" 
        referrerpolicy="no-referrer" />
</head>
<body>
    <%
        // hashEncryption.jsp에서 넘어온 데이터를 받는 부분

        request.setCharacterEncoding("UTF-8");
        String inputType = request.getParameter("inputType");
        String plainText = request.getParameter("plainText");
        String type = request.getParameter("type");
        
        System.out.println("Input Type: " + inputType);
        System.out.println("Plain Text: " + plainText);
        System.out.println("Hash Algorithm: " + type);

        hash.setPlainText(plainText);
        hash.setType(type);

        String hashResult = "";
        
        if(plainText != null && type != null){
            hashResult = hash.getHashResult();
            System.out.println(hashResult);
        }
    %>

    <div class="container mt-5 mb-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card shadow result-container">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">해시 결과</h3>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>입력 텍스트:</strong> <%= hash.getPlainText() %></li>
                            <li class="list-group-item"><strong>입력 타입:</strong> <%= inputType %></li>
                            <li class="list-group-item"><strong>해시 알고리즘:</strong> <%= hash.getType() %></li>
                            <li class="list-group-item">
                                <strong>해시 결과:</strong>
                                <div class="input-group">
                                    <span id="hashResult" class="form-control"><%= hashResult %></span>
                                    <button class="btn btn-outline-secondary" type="button" onclick="copyToClipboard('hashResult')">
                                        <i class="fa-solid fa-copy"></i> 복사
                                    </button>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        function copyToClipboard(elementId) {
      // 텍스트 선택 영역 생성
        var range = document.createRange();
        range.selectNode(document.getElementById(elementId));
    
        // 현재 선택 영역 설정
        window.getSelection().removeAllRanges();
        window.getSelection().addRange(range);
    
        // 복사 명령 실행
        document.execCommand('copy');
    
        // 선택 영역 초기화
        window.getSelection().removeAllRanges();
    
        // 복사가 완료되었다는 메시지 또는 로직을 추가할 수 있습니다.
        alert('복사되었습니다: ' + document.getElementById(elementId).innerText);
        }
    </script>
</body>
</html>