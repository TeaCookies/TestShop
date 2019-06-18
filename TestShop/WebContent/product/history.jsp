<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body { 
              padding-top : 50px; 
       } 


    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	
	 $(function() {
		 $( "button.btn.btn-default" ).on("click" , function() {
			fncGetList(1);
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");

	
	 });	
	
		
</script>
</head>



<body>

	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		
      <!--  table Start /////////////////////////////////////-->

		<br/>
		
		<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	String history = null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("history")) {
				history = cookie.getValue();
			}
		}
		if (history != null) {
			String[] h = history.split(",");
			for (int i = 0; i < h.length; i++) {
				if (!h[i].equals("null")) {
%>
<a href="/getProduct.do?prodNo=<%=h[i]%>&menu=search"
	target="rightFrame"><%=h[i]%></a>
<br>

		
		  <c:set var="<%=h[i]%>" value="0" />
		  <c:forEach var="product" items="<%=h%>">
			<c:set var="<%=h[i]%>" value="<%=h[i+1]%>" />
						  <div class="col-sm-4 col-md-3">
						    <div class="thumbnail" >
						        <img  src="../images/uploadFiles/${product.fileName}" height="200px"  onerror="this.src='http://placehold.it/200x200'" >	   
						      <div class="caption">
						        <h3 align="center">
						        		<c:if test="${ product.prodQuantity == 0}">
						        		<button  class="btn btn-danger btn-xs">품절</button></c:if>
						    		    ${product.prodName}
						    	</h3>
						        <c:if test="${ param.menu eq 'manage' }">
						        	<p align="center">[남은 수량] ${product.prodQuantity }개</p>  
						        </c:if> 
						        <p align="center">${product.price}원</p>
						        <p align="center">
			      					<a href="#" class="btn btn-default" role="button" >상세보기
			        						<input type="hidden" name="prodNo" value="${product.prodNo}"/>
			        				</a>
						        </p>
						      </div>
						    </div>
						  </div>
          </c:forEach>
	  <%}}}}%>
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>
