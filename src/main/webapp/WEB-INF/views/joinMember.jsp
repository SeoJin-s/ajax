<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    body { background-color: #f8f9fa; }
    .container { max-width: 800px; margin: 40px auto; }
    table { width: 100%; }
    th { width: 20%; background-color: #f1f1f1; text-align: center; vertical-align: middle; }
    input.form-control { margin-bottom: 8px; }
    .btn-block { width: 100%; }
  </style>
  <script>
    $(function() {
      $('#sn1').on('keyup', function() {
        if ($(this).val().length === 6) {
          $('#sn2').focus();
        }
      });

      $('#sn2').blur(function() {
        let sn1 = $('#sn1').val().trim();
        let sn2 = $('#sn2').val().trim();

        if (sn1.length !== 6 || sn2.length !== 7 || isNaN(sn1) || isNaN(sn2)) {
          alert("주민번호 형식이 잘못되었습니다.");
          return;
        }

        let fullSn = sn1 + sn2;

        $.ajax({
          url: 'http://localhost:9999/isSn/' + fullSn,
          type: 'get',
          success: function(data) {
            if (data === "true") {
              alert('주민번호 인증 성공');
              let genderCode = sn2.substr(0, 1);
              $('#gender').val(genderCode % 2 === 0 ? '여자' : '남자');

              let birthYear = parseInt(sn1.substr(0, 2));
              let birthMonth = parseInt(sn1.substr(2, 2));
              let birthDay = parseInt(sn1.substr(4, 2));
              let fullYear = (genderCode === '1' || genderCode === '2') ? 1900 + birthYear : 2000 + birthYear;

              let today = new Date();
              let age = today.getFullYear() - fullYear;
              if (today.getMonth() < birthMonth - 1 || (today.getMonth() + 1 === birthMonth && today.getDate() < birthDay)) {
                age--;
              }
              $('#age').val(age);
            } else {
              alert('주민번호 인증 실패');
              $('#gender').val('');
              $('#age').val('');
            }
          }
        });
      });

      $('#idckBtn').click(function() {
        let id = $('#idck').val().trim();
        if (!id) {
          alert("ID를 입력해주세요.");
          return;
        }

        $.ajax({
          url: '/isId/' + id,
          type: 'get',
          success: function(data) {
            if (data === "true") {
              alert('이미 사용중인 아이디입니다.');
            } else {
              alert('사용 가능한 아이디입니다.');
              $('#id').val(id);
            }
          },
          error: function() {
            alert("서버 통신 오류!");
          }
        });
      });

      $('#btn').click(function() {
        let id = $('#id').val().trim();
        let pw = $('#pw').val().trim();
        let pw2 = $('#pw2').val().trim();
        let gender = $('#gender').val().trim();
        let age = $('#age').val().trim();

        if (!id || !pw || !pw2 || !gender || !age) {
          alert("모든 항목을 입력해주세요.");
          return;
        }

        if (pw !== pw2) {
          alert("비밀번호가 일치하지 않습니다.");
          return;
        }

        let address = $('#postcode').val() + ' ' +
                      $('#roadAddress').val() + ' ' +
                      $('#jibunAddress').val() + ' ' +
                      $('#detailAddress').val() + ' ' +
                      $('#extraAddress').val();

        $.ajax({
          url: '/joinMember',
          type: 'post',
          data: {
            id: id,
            pw: pw,
            gender: gender,
            age: age,
            address: address
          },
          success: function(data) {
            if (data === "success") {
              alert("회원가입 성공");
              location.href = "/login";
            } else {
              alert("회원가입 실패");
            }
          },
          error: function() {
            alert("오류로 실패 다시 시도바랍");
          }
        });
      });
    });

    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          let roadAddr = data.roadAddress;
          let extraRoadAddr = '';

          if(data.bname !== '' && /[\uB3D9|\uB85C|\uAC00]$/g.test(data.bname)){
            extraRoadAddr += data.bname;
          }
          if(data.buildingName !== '' && data.apartment === 'Y'){
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          if(extraRoadAddr !== ''){
            extraRoadAddr = ' (' + extraRoadAddr + ')';
          }

          $('#postcode').val(data.zonecode);
          $('#roadAddress').val(roadAddr);
          $('#jibunAddress').val(data.jibunAddress);
          $('#extraAddress').val(extraRoadAddr);

          let guideTextBox = $('#guide');
          if(data.autoRoadAddress) {
            guideTextBox.html('(\uC608\uC0C1 \uB3C4\uB85C\uBA85 \uC8FC\uC18C : ' + data.autoRoadAddress + extraRoadAddr + ')');
            guideTextBox.show();
          } else if(data.autoJibunAddress) {
            guideTextBox.html('(\uC608\uC0C1 \uC9C0\uBC88 \uC8FC\uC18C : ' + data.autoJibunAddress + ')');
            guideTextBox.show();
          } else {
            guideTextBox.html('');
            guideTextBox.hide();
          }
        }
      }).open();
    }
  </script>
</head>
<body>
  <div class="container bg-white p-4 shadow rounded">
    <h1 class="text-center mb-4">회원가입</h1>

    <h4>학습 주민번호 확인</h4>
    <table class="table table-bordered mb-4">
      <tr>
        <th>주민번호</th>
        <td>
          <div class="d-flex gap-2">
            <input type="text" id="sn1" name="sn1" class="form-control" placeholder="생년월일 6자리">
            <span class="mt-2">-</span>
            <input type="password" id="sn2" name="sn2" maxlength="7" class="form-control" placeholder="7자리">
          </div>
        </td>
      </tr>
    </table>

    <h4>ID 중복 검색</h4>
    <table class="table table-bordered mb-4">
      <tr>
        <th>ID 검색</th>
        <td>
          <div class="input-group">
            <input type="text" id="idck" class="form-control" placeholder="ID">
            <button type="button" id="idckBtn" class="btn btn-outline-secondary">중복확인</button>
          </div>
        </td>
      </tr>
    </table>

    <form id="joinForm">
      <h4>주소 입력</h4>
      <table class="table table-bordered mb-4">
        <tr>
          <th>주소</th>
          <td>
            <div class="input-group mb-2">
              <input type="text" name="postcode" id="postcode" class="form-control" placeholder="우편번호">
              <button type="button" onclick="execDaumPostcode()" class="btn btn-outline-primary">우편번호 찾기</button>
            </div>
            <input type="text" name="roadAddress" id="roadAddress" class="form-control" placeholder="도로명주소">
            <input type="text" name="jibunAddress" id="jibunAddress" class="form-control" placeholder="지번주소">
            <span id="guide" style="color:#999; display:none"></span>
            <input type="text" name="detailAddress" id="detailAddress" class="form-control" placeholder="상세주소">
            <input type="text" name="extraAddress" id="extraAddress" class="form-control" placeholder="참고항목">
          </td>
        </tr>
      </table>

      <h4>개인 정보</h4>
      <table class="table table-bordered mb-4">
        <tr>
          <th>성별</th>
          <td><input type="text" id="gender" name="gender" class="form-control" readonly></td>
        </tr>
        <tr>
          <th>나이</th>
          <td><input type="text" id="age" name="age" class="form-control" readonly></td>
        </tr>
        <tr>
          <th>ID</th>
          <td><input type="text" id="id" name="id" class="form-control" readonly></td>
        </tr>
        <tr>
          <th>비밀번호</th>
          <td>
            <input type="password" id="pw" name="pw" class="form-control mb-2" placeholder="비밀번호">
            <input type="password" id="pw2" name="pw2" class="form-control" placeholder="비밀번호 확인">
          </td>
        </tr>
      </table>
    </form>

    <button type="button" id="btn" class="btn btn-primary btn-block">회원가입</button>
  </div>
</body>
</html>
