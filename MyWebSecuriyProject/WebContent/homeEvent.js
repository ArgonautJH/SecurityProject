/**
 * 
 */
// 폼 서밋 전에 추가 동작을 수행하는 함수
function submitForm(targetId) {
  var target = document.getElementById(targetId);

  if (target.style.display === 'none' || target.style.display === '') {
    target.style.display = 'block'; // 보이게 함
  }

  // 폼 제출
  document.getElementById('hashForm').submit();
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