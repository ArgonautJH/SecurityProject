<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>

<jsp:useBean id="aes" class="bean.ABSAlogorithm"/>
<jsp:setProperty property="application" name="aes" value="<%=application%>"/>
<jsp:setProperty property="request" name="aes" value="<%=request%>"/>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>Document</title>
</head>
<body>
	<%
		String fileSavePath = "D:";	// 파일 저장 경로 
		// 추후 경로를 C:\\uploads일로 이동 아니면 받아오는 식으로 변경
		
		int maxFileSize = 1024 * 1000 * 20;	// 20MB
		int maxMemorySize = 1024 * 1000 * 5; // 파일 업로드 중에 메모리에 저장되는 최대 크기를 설정하는 부분
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemorySize);
		factory.setRepository(new File(fileSavePath+"\\"));
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxFileSize);
		
		// 파라미터 값을 저장할 변수
	    String encryptType = null;
	    String encryptionAlgorithm = null;
	    String password = null;
	    String fileName = null;
	    String filePath = null;
	    String seedText = null;
	    
	    boolean result = false;

		
		try {
		    // request에서 파일 및 파라미터를 파싱
		    List<FileItem> fileItems = upload.parseRequest(request);

		    // 파일 및 파라미터 처리
		    for (FileItem item : fileItems) {
		        if (item.isFormField()) {
		            // 폼 필드 (파일이 아닌 경우)
		            if (item.getFieldName().equals("encryptType")) {
		                encryptType = item.getString();
		            } else if (item.getFieldName().equals("encryptionAlgorithm")) {
		                encryptionAlgorithm = item.getString();
		            } else if (item.getFieldName().equals("passwordText")){
		            	password = item.getString();
		            } else if (item.getFieldName().equals("seedText")){
		            	seedText = item.getString();
		            }
		        } else {
		            // 파일 필드
		            fileName = new File(item.getName()).getName();
		            filePath = fileSavePath + File.separator + fileName;
		            File uploadedFile = new File(filePath);
		            item.write(uploadedFile);
		        }
		    }

		    aes.setType(encryptionAlgorithm);
		    System.out.println(encryptType);
		    aes.setPassword(password);
		    aes.setFileName(fileName);
		    

		} catch (Exception ex) {
		    out.println("파일 업로드 실패: " + ex);
		}
	%>
	
	<% 
		System.out.println(fileSavePath);
		String errorMessage = null;
	
		if(encryptType.equals("encrypt")){
			aes.doEncrypt("D:");		
			errorMessage = "success";
		}else if(encryptType.equals("decrypt")){
			result = aes.doDecrypt("D:", seedText);
			
			if (!result) {
			    errorMessage = "Decrypt 실패: 비밀번호 또는 시드가 올바르지 않습니다.";
			}else{
				errorMessage = "success";
			}
		}
		
	%>
	
</body>
	<div class="container mt-5 mb-5">
        <div class="card shadow">
            <div class="card-body">
               	<h2 class="card-title text-center mb-4">Encryption/Decryption Result</h2>
	            <!-- 추가: 에러 메시지 출력 -->
	            <% if (!"success".equals(errorMessage)) { %>
	                <div class="alert alert-danger" role="alert">
	                    <%= errorMessage %>
	                </div>
	            <% } else { %>
	            	<% if (encryptType.equals("decrypt")) { %>
	            		<div class="alert alert-success" role="alert">
						        작업이 성공적으로 완료되었습니다.
						</div>
		            <% } else { %>
	            	<ul class="list-group list-group-flush">
		                <li class="list-group-item"><strong>File Name:</strong> <%= aes.getFileName() %></li>
		                <li class="list-group-item"><strong>Password:</strong> <%= aes.getPassword() %></li>
		                <li class="list-group-item"><strong>Seed Value:</strong> <%= aes.getSeedValue() %></li>
		            <% } %>
		            </ul>
	            <% } %>
            </div>
        </div>
    </div>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</html>