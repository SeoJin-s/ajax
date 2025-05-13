<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	// 외부서버 API = 비동기 구현 필수 
	$(function(){
	// 포커스
	$('#sn1').on('keyup', function() {
		if ($(this).val().length === 6) {
			$('#sn2').focus();
		}
	})
		// 주민번호 
		$('#sn2').blur(function() {
			let sn1 = $('#sn1').val().trim();
			let sn2 = $('#sn2').val().trim();

			// 유효성 체크
			if (sn1.length !== 6 || sn2.length !== 7 || isNaN(sn1) || isNaN(sn2)) {
				alert("주민번호 형식이 잘못되었습니다.");
				return;
			}

			let fullSn = sn1 + sn2;
			alert('http://localhost:9999/isSn/' + fullSn);

			$.ajax({
				url: 'http://localhost:9999/isSn/' + fullSn,
				type: 'get',
				success: function(data) {
					alert("서버 응답: " + data);

					if (data === "true") {
						alert('주민번호 인증 성공');

						// 성별 추출
						let genderCode = sn2.substr(0, 1);
						if (genderCode % 2 === 0) {
							$('#gender').val('여');
						} else {
							$('#gender').val('남');
						}

						// 나이 계산
						let birthYear = parseInt(sn1.substr(0, 2));
						let birthMonth = parseInt(sn1.substr(2, 2));
						let birthDay = parseInt(sn1. substr(4, 2));
						let fullYear = (genderCode === '1' || genderCode === '2') ? 1900 + birthYear : 2000 + birthYear;
						
						let today = new Date();
						let thisYear = today.getFullYear();
						let thisMonth = today.getMonth();
						let thisDay = today.getDate();
						
						let age = thisYear - fullYear;
						if (thisMonth < birthMonth || (thisMonth === birthMonth && thisDay < birthDay)) {
	                        age--; // 생일 안 지났으면 1살 빼기
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
		// 내부 API서버를 호출 - 비동기 구현 필수 x
		$('#idckBtn').click(function() {
			let id = $('#idck').val().trim();
			if (id === "") {
				alert("ID를 입력해주세요.");
				return;
			}

			$.ajax({
				url: '/isId/' + $('#idck').val(),
				type: 'get',
				success: function(data) {
					if (data === "true") {
						alert('이미 사용중인 아이디입니다.');
					} else {
						alert('사용 가능한 아이디입니다.');
						$('#id').val(id); // 입력 필드에 값 넣기
					}
				},
				error: function() {
					alert("서버 통신 오류!");
				}
			});
		});
		
		$('#btn').click(function() {
		    // 입력값 가져오기
		    let id = $('#id').val().trim();
		    let pw = $('#pw').val().trim();
		    let pw2 = $('#pw2').val().trim();
		    let gender = $('#gender').val().trim();
		    let age = $('#age').val().trim();

		    // 유효성 검사
		    if (!id || !pw || !pw2 || !gender || !age) {
		        alert("모든 항목을 입력해주세요.");
		        return;
		    }

		    if (pw !== pw2) {
		        alert("비밀번호가 일치하지 않습니다.");
		        return;
		    }

		    // AJAX로 회원가입 요청
		    $.ajax({
		        url: '/joinMember',
		        type: 'post',
		        data: {
		            id: id,
		            pw: pw,
		            gender: gender,
		            age: age
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
		            alert("오류로 실패 다시 시도바람");
		        }
		    });
		});
	});
</script>

</head>
<body>
	<h1>회원가입</h1>
	<hr>
		<h2>주민번호확인</h2>
		<table border="1">
				<tr>
				<th>주민번호</th>
				<td>
					<input type="text" id="sn1" name="sn1" > <!-- keyup, length 6, focus sn2 -->
					-
					<input type="password" id="sn2" name="sn2" maxlength="7"> <!-- blur length ==7, snapi호출, true gender+age, false alet 잘못된 주민번호 -->
				</td>
			</tr>
		</table>	
	<hr>

	
	<hr>
<h2>ID검색</h2>
<table border="1">
	<tr>
		<th>ID검색</th>
		<td>
			<input type="text" id="idck">
			<button type="button" id="idckBtn">중복확인</button>
		</td>
	</tr>
</table>

<br>

<form id="joinForm">
<table border="1">	
	<tr>
		<th>성별</th>
		<td><input type="text" id="gender" name="gender" readonly></td>
	</tr>
	<tr>
		<th>나이</th>
		<td><input type="text" id="age" name="age" readonly></td>
	</tr>
	<tr>
		<th>아이디</th>
		<td><input type="text" id="id" name="id" readonly></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td>
			<input type="password" id="pw" name="pw">
			확인 - <input type="password" id="pw2" name="pw2">
		</td>
	</tr>
</table>
</form>

<button type="button" id="btn">회원가입</button>

</body>
</html>