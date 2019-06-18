<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

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
       
       .thumbnail{  
       			 width: 100%; height: 50px; overflow: hidden;  
        }  
       
       img { 
/*       			 max-width: 100%;  */
      			 max-height: 250px; 
      			 min-height: 250px; 
      			 width: 100%; 
      			 vertical-align: middle;
       }

/* 출처: https://webdir.tistory.com/487 [WEBDIR] */


@import url(https://fonts.googleapis.com/css?family=Raleway:300,700);
@import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);
figure.snip1384 {
  font-family: 'Raleway', Arial, sans-serif;
  position: relative;
  overflow: hidden;
  margin: 10px;
  min-width: 230px;
  max-width: 315px;
  width: 100%;
  color: #ffffff;
  text-align: left;
  font-size: 16px;
  background-color: #000000;
}
figure.snip1384 * {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all 0.35s ease;
  transition: all 0.35s ease;
}
figure.snip1384 img {
  max-width: 100%;
  backface-visibility: hidden;
  vertical-align: top;
}
figure.snip1384:after,
figure.snip1384 figcaption {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
}
figure.snip1384:after {
  content: '';
  background-color: rgba(0, 0, 0, 0.65);
  -webkit-transition: all 0.35s ease;
  transition: all 0.35s ease;
  opacity: 0;
}
figure.snip1384 figcaption {
  z-index: 1;
  padding: 40px;
}
figure.snip1384 h3,
figure.snip1384 .links {
  width: 100%;
  margin: 5px 0;
  padding: 0;
}
figure.snip1384 h3 {
  line-height: 1.1em;
  font-weight: 700;
  font-size: 1.4em;
  text-transform: uppercase;
  opacity: 0;
}
figure.snip1384 p {
  font-size: 0.8em;
  font-weight: 300;
  letter-spacing: 1px;
  opacity: 0;
  top: 50%;
  -webkit-transform: translateY(40px);
  transform: translateY(40px);
}
figure.snip1384 i {
  position: absolute;
  bottom: 10px;
  right: 10px;
  padding: 20px 25px;
  font-size: 34px;
  opacity: 0;
  -webkit-transform: translateX(-10px);
  transform: translateX(-10px);
}
figure.snip1384 a {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;
}
figure.snip1384:hover img,
figure.snip1384.hover img {
  zoom: 1;
  filter: alpha(opacity=50);
  -webkit-opacity: 0.5;
  opacity: 0.5;
}
figure.snip1384:hover:after,
figure.snip1384.hover:after {
  opacity: 1;
  position: absolute;
  top: 10px;
  bottom: 10px;
  left: 10px;
  right: 10px;
}
figure.snip1384:hover h3,
figure.snip1384.hover h3,
figure.snip1384:hover p,
figure.snip1384.hover p,
figure.snip1384:hover i,
figure.snip1384.hover i {
  -webkit-transform: translate(0px, 0px);
  transform: translate(0px, 0px);
  opacity: 1;
}

    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	function fncGetList2(currentPage, searchCondition) {
			$("#currentPage").val(currentPage)
			$("#searchCondition").val(searchCondition)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	
	 $(function() {
		 $( "button.btn.btn-default" ).on("click" , function() {
			fncGetList(1);
		});
		
		$("span:contains('품절')").on("click" , function() {
			$(  '#soldOut'  ).val(  '0'  );
			fncGetList(1);
		}); 
		
		$("span:contains('낮은')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '1'  );
			fncGetList2(1,'1');
		}); 
		
		$("span:contains('높은')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '2'  );
			fncGetList2(1,'2');
// 			fncGetList(1);
		}); 
		
		$("span:contains('등록')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '3'  );
			fncGetList2(1,'3');
		}); 
		
		$("span:contains('신상품')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '4'  );
			fncGetList2(1,'4');
		}); 
		
// 		$( "a:contains('상세보기')" ).on("click" , function() {	
// 			self.location ="/product/getProduct?prodNo="+ $(this).children().val()+"&menu=${param.menu}";
// 			console.log ( $(  this  ).children().val() );
// 		});
		
// 		$( "img" ).on("click" , function() {	
// 			self.location ="/product/getProduct?prodNo="+  $(  this  ).parent().children().val()+"&menu=${param.menu}";
// 		});
		
		$( ".snip1384" ).on("click" , function() {	
			self.location ="/product/getProduct?prodNo="+  $(  this  ).children().val()+"&menu=${param.menu}";
		});
		
		$( "a:contains('바로구매')" ).on("click" , function() {	
			self.location = "/purchase/addPurchase?prodNo="+$(this).children().val();
			console.log ( $(this).children().val() );
		});
		
// 		$( "a:contains('수정')" ).on("click" , function() {	
// 			self.location ="/product/updateProduct?prodNo="+$(this).children().val();
// 			console.log ( $(this).children().val() );
// 		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		$(".hover").mouseleave(
				  function () {
				    $(this).removeClass("hover");
				  }
				);
	
			
	 });	
	 

		
</script>
</head>



<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>
		       <c:if test="${ param.menu eq 'manage' }">
		       			상품관리
		       	</c:if>
		       <c:if test="${ param.menu ne 'manage' }">
		       			상품목록조회
		       	</c:if>	       
	       </h3>
	    </div>
	    
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수
		    		<c:if test="${ !(empty sessionScope.user)   }">
		    		, 현재 ${resultPage.currentPage}  페이지
		    		</c:if>
		    	</p>
		    </div>

		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
<!-- 			      <div class="form-group"> -->
<!-- 				    <select class="form-control" name="searchCondition" > -->
<%-- 						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>낮은 가격 순</option> --%>
<%-- 						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>높은 가격 순</option> --%>
<!-- 					</select> -->
<!-- 				  </div> -->
			    
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/><br/>
				  <input type="hidden" id="searchCondition" name="searchCondition" value=""/><br/>
				  <input type="hidden" id="soldOut" name="soldOut" value="1"/><br/>
				 <c:if test="${ !(empty sessionScope.user)   }">
						  <span> [품절상품제외] </span>
						  <span> [낮은 가격 순] </span>
						  <span> [높은 가격 순] </span>
						  <span> [등록 순] </span>
						  <span> [신상품 순] </span>
				  </c:if>
				</form>
	    	</div>
	    	
		</div>
		

		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
<div class="col-md-12">
		 <br/>  	<br/>
		    </div>
		
		
      <!--  table Start /////////////////////////////////////-->

		<br/>
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			
			
			<div class="col-sm-4 col-md-3" style="vertical-align: middle;margin-top: ">
			<figure class="snip1384">
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
				  <img src="../images/uploadFiles/${product.fileName}" onerror="this.src='http://placehold.it/400x400'"/>
				  <figcaption>
					    <h3>${product.prodName}<c:if test="${ product.prodQuantity == 0}">
						        		<button  class="btn btn-danger btn-xs">품절</button></c:if></h3>
					    <p> ${product.price}원</p><i class="ion-ios-arrow-right"></i>
				  </figcaption>
				  <c:if test="${ param.menu eq 'manage' }">
				  [재고] ${product.prodQuantity}개
				  </c:if>
			</figure>
			</div>			


<!-- 		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			
			
<!-- 						  <div class="col-sm-4 col-md-3"> -->
<!-- 						    <div class="thumbnail" style="height: 360px"> -->
<%-- 								<input type="hidden" name="prodNo" value="${product.prodNo}"/> --%>
<%-- 						        <img   height="700" src="../images/uploadFiles/${product.fileName}"  height="100" onerror="this.src='http://placehold.it/400x400'" > --%>

<!-- 						      <div class="caption"> -->
<!-- 						        <h3 align="center"> -->
<%-- 						        		<c:if test="${ product.prodQuantity == 0}"> --%>
<%-- 						        		<button  class="btn btn-danger btn-xs">품절</button></c:if> --%>
<%-- 						    		    ${product.prodName} --%>
<!-- 						    	</h3> -->
<!-- 						        <p align="center"> -->
<%-- 						        <c:if test="${ param.menu eq 'manage' }"> --%>
<%-- 						        	[재고 :  ${product.prodQuantity }개]&nbsp;  --%>
<%-- 						        </c:if>  --%>
<%-- 						        ${product.price}원 --%>
						        
						        
<!-- 		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
<%-- 						        <c:if test="${ param.menu eq 'manage' }"> --%>
<!-- 		        						<a href="#" class="btn btn-default btn-xs" role="button">수정 -->
<%-- 		        						<input type="hidden" name="prodNo" value="${product.prodNo}"/></a>   --%>
<%-- 		        				</c:if> --%>
						        </p>
<!-- 						        <p align="center"> -->
<!-- 						      					<a href="#" class="btn btn-default" role="button" >상세보기 -->
<%-- 						        						<input type="hidden" name="prodNo" value="${product.prodNo}"/> --%>
<!-- 						        				</a> -->
						        				
<%-- 						        				<c:if test="${ param.menu ne 'manage'  && product.prodQuantity != 0}"> --%>
<!-- 						        						<a href="#" class="btn btn-primary" role="button">바로구매 -->
<%-- 						        						<input type="hidden" name="prodNo" value="${product.prodNo}"/></a>   --%>
<%-- 						        				</c:if> --%>
<%-- 						        				<c:if test="${ param.menu eq 'manage' }"> --%>
<!-- 						        						<a href="#" class="btn btn-primary btn-xs" role="button">수정 -->
<%-- 						        						<input type="hidden" name="prodNo" value="${product.prodNo}"/></a>   --%>
<%-- 						        				</c:if> --%>
<!-- 						        	</p> -->


<!-- 		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
<!-- 						      </div> -->
<!-- 						    </div> -->
<!-- 						  </div> -->
						  
						  
						  
          </c:forEach>
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

 	
 	<!-- PageNavigation Start... -->
<%--  	<c:if test="${ !(empty sessionScope.user)   }"> --%>
			<jsp:include page="../common/pageNavigator_new.jsp"/>
<%-- 	</c:if> --%>
	<!-- PageNavigation End... -->
	
</body>
</html>
