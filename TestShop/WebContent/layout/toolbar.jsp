<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	         	
	         	<c:if test="${ !(empty sessionScope.user)   }">
	            
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                         
<!-- 	                         <li class="divider"></li> -->
<!-- 	                         <li><a href="#">etc...</a></li> -->
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li><a href="#">주문관리</a></li>
<!-- 		                         <li class="divider"></li> -->
		                         <li><a href="#">비전</a></li>
		                         <li><a href="#">지도</a></li>
		                         <li><a href="#">지도마커여러개</a></li>
		                         <li><a href="#">경로</a></li>
		                         <li><a href="#">달력</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상품검색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">최근본상품</a></li>
<!-- 	                         <li class="divider"></li> -->
<!-- 	                         <li><a href="#">etc..</a></li> -->
	                     </ul>
	                 </li>
	                 
<!-- 	                 <li><a href="#">etc...</a></li> -->
	             </ul>
	             </c:if>
	             
	             <ul class="nav navbar-nav navbar-right">
		             	<c:if test="${ !(empty sessionScope.user)   }">
		                		<li><a href="#">로그아웃</a></li>
		                </c:if>
		             	<c:if test="${ empty sessionScope.user   }">
		                		<li><a href="#">회원가입</a></li>
		                		<li><a href="#">로그인</a></li>
		                </c:if>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
		//============= logout Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
			
		 	$("a:contains('로그인')").on("click" , function() {
				$(self.location).attr("href","/user/login");
			}); 
			
		 	$("a:contains('회원가입')").on("click" , function() {
				$(self.location).attr("href","/user/addUser");
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
		
		
	 	$( "a:contains('판매상품등록')" ).on("click" , function() {
	 		self.location = "../product/addProductView.jsp"
		}); 
	 	
	 	
	 	$( "a:contains('판매상품관리')" ).on("click" , function() {
	 		$(self.location).attr("href","/product/listProduct?menu=manage");
		}); 
	 	
	 	
	 	$( "a:contains('주문관리')" ).on("click" , function() {
	 		$(self.location).attr("href","/purchase/listManage");
		}); 
	 	
	 	//////////////////////////////////////////////////////////////////////////////////
	 	$( "a:contains('비전')" ).on("click" , function() {
	 		self.location = "../product/testVision.jsp"
		}); 
	 	
	 	$( "a:contains('지도')" ).on("click" , function() {
	 		self.location = "../product/testMapGoogle.jsp"
		}); 
	 	
	 	$( "a:contains('마커')" ).on("click" , function() {
	 		self.location = "../product/testMapGoogleMarker.jsp"
		}); 
	 	
	 	$( "a:contains('경로')" ).on("click" , function() {
	 		self.location = "../product/testMapGooglePoly.jsp"
		}); 
	 	
	 	$( "a:contains('달력')" ).on("click" , function() {
	 		self.location = "../product/testCalendar.jsp"
		}); 
	 	

	 	//////////////////////////////////////////////////////////////////////////////////
	 	
	 	$( "a:contains('상품검색')" ).on("click" , function() {
	 		self.location = "/product/listProduct?menu=search"
		}); 
	 	
	 	
	 	$( "a:contains('구매이력조회')" ).on("click" , function() {
	 		$(self.location).attr("href","/purchase/listPurchase");
		}); 
	 	
	 	
	 	$( "a:contains('최근본상품')" ).on("click" , function() {
			history();
		}); 
	 	
		function history(){
			popWin = window.open("/history.jsp",
														"popWin",
														"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}
	
		
	</script>  