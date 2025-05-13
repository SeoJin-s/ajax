<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <form id="form1" action="/continentList" method="get">
    <!-- 대륙  -->
    <select name="continent" onchange="this.form.submit()">
      <option value="">:::대륙 선택:::</option>
      <c:forEach var="continent" items="${continentList}">
        <option value="${continent.continentNo}"
          <c:if test="${param.continent == continent.continentNo}">selected</c:if>>
          ${continent.continentName}
        </option>
      </c:forEach>
    </select>

    <!-- 나라 -->
	   <select name="country" onchange="this.form.submit()">
	  <option value="">:::나라 선택:::</option>
	  <c:forEach var="country" items="${countryList}">
	    <option value="${country['countryNo']}"
	      <c:if test="${param.country == country['countryNo']}">selected</c:if>>
	      ${country['countryName']}
	    </option>
	  </c:forEach>
	</select>

    <!--도시  -->
    <select name="city">
      <option value="">:::도시 선택:::</option>
      <c:forEach var="city" items="${cityList}">
        <option value="${city.cityNo}"
          <c:if test="${param.city == city['cityNo']}">selected</c:if>>
          ${city.cityName}
        </option>
      </c:forEach>
    </select>
  </form>
<script type="text/javascript">
	document.querySelector('#continent').addEventListener('change', function() {
		if(this.value == '') {
			alert('대륙을 선택하세요');
			return;
		}
		document.querySelector('#form1').submit();
	});
	
	document.querySelector('#country').addEventListener('change', function() {
		if(this.value == '') {
			alert('나라를 선택하세요');
			return;
		}
		document.querySelector('#form1').submit();
	});
</script>
</body>
</html>