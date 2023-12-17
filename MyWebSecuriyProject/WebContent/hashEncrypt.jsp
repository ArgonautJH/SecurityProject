<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container mt-5">
    <div class="card">
        <div class="card-body">
            <h2 class="card-title">해시값 구하기</h2>
            
            <form id="hashForm" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">입력 유형 선택:</label>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="inputType" id="textInput" value="text" checked>
                        <label class="form-check-label" for="textInput">텍스트</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="inputType" id="fileInput" value="file">
                        <label class="form-check-label" for="fileInput">파일</label>
                    </div>
                </div>
                
                <!-- 해시 알고리즘 선택 영역 -->
                <div class="mb-3">
                    <label for="hashAlgorithm" class="form-label">해시 알고리즘 선택:</label>
                    <select class="form-select" id="hashAlgorithm" name="hashAlgorithm">
                        <option value="md5">MD5</option>
                        <option value="sha256">SHA-256</option>
                    </select>
                </div>

                <!-- 텍스트 입력 영역 -->
                <div class="mb-3" id="textArea">
                    <label for="plainText" class="form-label">텍스트 입력:</label>
                    <input type="text" id="plainText" name="plainText" class="form-control" placeholder="텍스트 입력">
                </div>

                <!-- 파일 선택 영역 -->
                <div class="mb-3" id="fileArea" style="display:none;">
                    <label for="file" class="form-label">파일 선택:</label>
                    <input type="file" class="form-control" name="file" id="file">
                </div>
                

                <div class="text-end">
                    <button type="button" class="btn btn-primary mt-3" onclick='generateHash()'>해시값 생성</button>
                </div>
            </form>
        </div>
    </div>

    <div id="contentResult" class="mt-5">
        
    </div>
</div>
