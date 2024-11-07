<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-5">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title">폴더 내 모든 파일 암호화/복호화 서비스</h2>
            
            <form id="encrypyFolderForm" action="FolderFileResult.jsp" method="post" target="folderEncryptResultFrame">
                <div class="mb-3">
                    <label for="filePath" class="form-label">폴더 경로 입력:</label>
                    <input type="text" class="form-control" name="filePath" id="filePath" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">방식 선택:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="encryptType" id="encrypt" onchange="initValue()" value="encrypt" checked>
                        <label class="form-check-label" for="encrypt">암호화</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="encryptType" id="decrypt" onchange="initValue()" value="decrypt">
                        <label class="form-check-label" for="decrypt">복호화</label>
                    </div>
                </div>

                <!-- 텍스트 입력 영역 -->
                <div class="mb-3" id="passwordArea">
                    <label for="passwordText" class="form-label">비밀번호 입력:</label>
                    <input type="password" id="passwordText" name="passwordText" class="form-control">
                </div>
                
                <div class="text-end">
                    <button type="button" class="btn btn-primary mt-3" onclick="submitForm('folderEncryptResultFrame','encrypyFolderForm')">암호화 진행</button>
                </div>
            </form>
        </div>
    </div>
    <iframe id="folderEncryptResultFrame" name="folderEncryptResultFrame" class="mt-4 border" style="display: none; width: 100%; border-radius: 5px;" onload="adjustIframeHeight(this)"></iframe>
</div>    