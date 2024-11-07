/**
 * 
 */
// 폼 서밋 전에 추가 동작을 수행하는 함수
function submitForm(targetId, formId) {
  var target = document.getElementById(targetId);

  if (target.style.display === 'none' || target.style.display === '') {
    target.style.display = 'block'; // 보이게 함
  }

  // 폼 제출
  document.getElementById(formId).submit();
}

// ifrmae로드 시 사이즈를 지정하기 위함
function adjustIframeHeight(iframe) {
  iframe.style.height = iframe.contentWindow.document.body.scrollHeight + 'px';
}

function changePage(page) {
  const content = document.getElementById('content');

  // 애니메이션 효과 추가
  content.style.opacity = 0;
  content.style.transform = 'translateY(-20px)';

  // 페이지 전환
  fetch(`${page}.jsp`)
    .then(response => response.text())
    .then(data => {
      content.innerHTML = data;
      // 애니메이션 효과 제거
      setTimeout(() => {
        content.style.opacity = 1;
        content.style.transform = 'translateY(0)';
      }, 100);
    });
}

// 라디오버튼 선택 시 파일 타입 변경
function changeFileType(){

  var textInputRadio = document.getElementById('textInput');
  var fileInputRadio = document.getElementById('fileInput');

  var textArea = document.getElementById('textArea');
  var fileArea = document.getElementById('fileArea');

  var plainText = document.getElementById('plainText');
  var file = document.getElementById('file');

  if(textInputRadio.checked){
    textArea.style.display = 'block';
    fileArea.style.display = 'none';

  }

  if(fileInputRadio.checked){
    textArea.style.display = 'none';
    fileArea.style.display = 'block';
  }

	plainText.value = '';
	file.value = '';
}

// FileEncrypt.jsp에서 암호화 방식 선택 시 입력란 영역 변경
function changeAlgorithmType(){
  var encrypt = document.getElementById('encrypt');
  var decrypt = document.getElementById('decrypt');
  
  var passwordArea = document.getElementById('passwordArea');
  var keyArea = document.getElementById('keyArea');

  var passwordText = document.getElementById('passwordText');
  var seedText = document.getElementById('seedText');
  var file = document.getElementById('file');
  var filePath = document.getElementById('filePath');

  var frame = document.getElementById('encryptResultFrame');

  if(encrypt.checked){
    passwordArea.style.display = 'block';
    keyArea.style.display = 'none';
  }

  if(decrypt.checked){
    keyArea.style.display = 'block';
  }

  frame.style.display = 'none';
  passwordText.value = '';
  seedText.value = '';
  file.value = '';
  filePath.value = '';
}

function initValue(){
	var filePath = document.getElementById('filePath');
	var passwordText = document.getElementById('passwordText');
	
	filePath.value = '';
    passwordText.value = '';
 
}
