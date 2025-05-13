<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="form1" action="/cntnntList" method="get">
		<select id="continent" name="continent">
			<option value="">:::대륙선택:::</option>
			<c:forEach var="continent" items="${cntnntList}">
				<option value="${continent.continentNo}">${continent.continentName}</option>
			</c:forEach>
		</select>
		
		<select id="country" name="country">
			<option value="">:::나라선택:::</option>
		</select>
		
		<select id="city" name="city">
			<option value="">:::도시선택:::</option>
		</select>
	</form>
	<script>
		/*
			fetch("API 주소", {method: "POST"})
			.then((respons) => {return response.json()})
			.then((data) => {console.log(data)})
			.catch((error) => {console.log(error)});
		*/
		
		document.querySelector('#continent').addEventListener('change', function() {
			if(this.value == '') {
				alert('대륙 선택하세요');
				return;
			}
			// 선택된 대륙의 나라목록을 가져와서 country에 append(비동기 호출)
			fetch('/cntList/'+this.value)
			.then(function(res){
				return res.json();
			})
			.then(function(result) {
				document.querySelector('#country').innerHTML = '<option value="">:::나라선택:::</option>';
				//console.log(result); // ountry에 append(비동기 호출)
				result.forEach(function(e) {
					let option = document.createElement('option');
					option.setAttribute('value', e.countryNo);
					option.textContent = e.countryName; // ex) <option value='1'>런던</option>
					document.querySelector('#country').append(option);
				});
			});
		});
		
		document.querySelector('#country').addEventListener('change', function() {
			if(this.value == '') {
				alert('나라를 선택하세요');
				return;
			}
			// 선택된 나라의 도시목록을 가져와서 city에 append(비동기 호출)
			fetch('/cityList/'+this.value)
			.then(function(res){
				return res.json();
			})
			.then(function(result) {
				document.querySelector('#city').innerHTML = '<option value="">:::도시선택:::</option>';
				//console.log(result); // ountry에 append(비동기 호출)
				result.forEach(function(e) {
					let option = document.createElement('option');
					option.setAttribute('value', e.cityNo);
					option.textContent = e.cityName; // ex) <option value='1'>런던</option>
					document.querySelector('#city').append(option);
				});
			});
		});
	</script>
</body>
</html>