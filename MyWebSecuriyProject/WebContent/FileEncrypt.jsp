<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-5 mb-5">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title">파일 암/복호화 서비스</h2>
            
            <form id="encrypyForm" action="FileResult.jsp" method="post" target="encryptResultFrame" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="file" class="form-label">파일 선택:</label>
                    <input type="file" class="form-control" name="file" id="file" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">방식 선택:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="encryptType" id="encrypt" onchange="changeAlgorithmType()" value="encrypt" checked>
                        <label class="form-check-label" for="encrypt">암호화</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="encryptType" id="decrypt" onchange="changeAlgorithmType()" value="decrypt">
                        <label class="form-check-label" for="decrypt">복호화</label>
                    </div>
                </div>

                <!-- 텍스트 입력 영역 -->
                <div class="mb-3" id="passwordArea">
                    <label for="passwordText" class="form-label">비밀번호 입력:</label>
                    <input type="password" id="passwordText" name="passwordText" class="form-control">
                </div>

                <div class="mb-3" id="keyArea" style="display:none;">
                    <label for="seedText" class="form-label">시드키 입력:</label>
                    <input type="text" id="seedText" name="seedText" class="form-control">
                </div>
                
                <div class="text-end">
                    <button type="button" class="btn btn-primary mt-3" onclick="submitForm('encryptResultFrame','encrypyForm')">암호화 진행</button>
                </div>
            </form>
        </div>
    </div>
    <iframe id="encryptResultFrame" name="encryptResultFrame" class="mt-4 border" style="display: none; width: 100%; height: 300px; border-radius: 5px;"></iframe>
</div>    
