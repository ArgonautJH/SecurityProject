<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="hash" class="bean.HashBean"/>
<%
    String plainText = request.getParameter("plainText");
    String hashAlgorithm = request.getParameter("hashAlgorithm");
    
	System.out.println(plainText);
	System.out.println(hashAlgorithm);
    
    hash.setPlainText(plainText);
    hash.setType(hashAlgorithm);
    
    String hashResult = hash.getHashResult();
	System.out.println(hashResult);
%>

<div>
    <!-- 결과를 표시하는 부분 -->
    <h3>해시 결과:</h3>
    <p><%= hashResult %></p>
</div>