<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="faes" class="bean.FolderFileABS"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	    String filePath = request.getParameter("filePath");
		String encryptType = request.getParameter("encryptType");
		String passwordText = request.getParameter("passwordText");
		
		faes.setFolderPath(filePath);
		faes.setPassword(passwordText);
	%>
	
	<%
		boolean success = false;
		if (encryptType.equals("encrypt")) {
	        success = faes.doFolderEncrypt();
	    } else {
	        success = faes.doFolderDecrypt();
	    }
		
		if (success) {
	%>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
	    <div class="alert alert-success" role="alert">
	        작업이 성공적으로 완료되었습니다.
	    </div>
	<%
	    } else {
	%>
	    <div class="alert alert-danger" role="alert">
	        작업 중 오류가 발생했습니다.
	    </div>
	<%
	    }
	%>

</html>