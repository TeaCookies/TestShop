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
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listManage").submit();
	}
	
	
	 $(function() {
		$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			fncGetList(1);
		});
		
		$( "td:nth-child(4)" ).on("click" , function() {
			self.location ="/product/getProduct?prodNo="+ $(this).children().val()+"&menu=${param.menu}";
			console.log ( $(this).children().val() );
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
		$( "button:contains('배송하기')" ).on("click" , function() {
			self.location ="/purchase/updateTranCode?tranNo="+$(this).children().val()+"&tranCode="+$(this).parent().children().val() ;
			console.log (    $(this).children().val()    );
			console.log (    $(this).parent().children().val()    );
		});
				
	 });	
	 
	 $(function() {			
			$( "td:nth-child(4) " ).css("font-weight" , "bold");
			//주문번호 클릭
			$( "td:nth-child(2)" ).on("click" , function() {
				var tranNo = $(this).text().trim();
				//alert(tranNo);
				
				$.ajax( 
					 		{
								url : "/purchase/json/getPurchase/"+tranNo ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
													"Accept" : "application/json",
													"Content-Type" : "application/json"
													},
								success : function(JSONData , status) {
					
									//alert(status);
									console.log("JSONData : \n"+JSON.stringify(JSONData));
									if ($.trim(JSONData.paymentOption) == '0' ){JSONData.paymentOption="현금결제"}
									if ($.trim(JSONData.paymentOption) == '1' ){JSONData.paymentOption="카드결제"}
									
									if (JSONData.receiverPhone == null ){JSONData.receiverPhone=" "}
									if (JSONData.divyAddr == null ){JSONData.divyAddr=" "}
									if (JSONData.divyRequest == null ){JSONData.divyRequest=" "}
									if (JSONData.divyDate == null ){JSONData.divyDate=" "}
		
									var displayValue = "<h6>"
																+"상품번호 : "+JSONData.purchaseProd.prodNo+"<br/>"
																+"구매방법 : "+JSONData.paymentOption+"<br/>"
																+"사용 적립금 : "+JSONData.mileage+"원<br/>"
																+"구매자이름 : "+JSONData.receiverName+"<br/>"
																+"구매자연락처 : "+JSONData.receiverPhone+"<br/>"
																+"구매자주소 : "+JSONData.divyAddr+"<br/>"
																+"구매요청사항 : "+JSONData.divyRequest+"<br/>"
																+"배송희망일 : "+JSONData.divyDate+"<br/>"
																+"주문일 : "+JSONData.orderDate+"<br/>"
																+"</h6>";
																
									//Debug...									
									//alert(displayValue);
									$("h6").remove();
									$( "#"+tranNo+"" ).html(displayValue);
							}
					});
			});

			
			$(  "td:nth-child(3) " ).on("click" , function() {

				var userId = $(this).text().trim();
				var userAjax =     $(      $(  "td:nth-child(3) " ).children()[   $(  "td:nth-child(3) " ).index(this)   ]    );
// 				var userAjax =     $(      $(  "td:nth-child(3) " ).children(   "#"+userId+""    )[   $(  "td:nth-child(3) " ).index(this)   ]    );


				$.ajax( 
						{
							url : "/user/json/getUser/"+userId ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								if (JSONData.email == null ){JSONData.email=" "}

								var displayValue = "<h6>"
															+"아이디 : "+JSONData.userId+"<br/>"
															+"이  름 : "+JSONData.userName+"<br/>"
															+"이메일 : "+JSONData.email+"<br/>"
															+"ROLE : "+JSONData.role+"<br/>"
															+"등록일 : "+JSONData.regDate+"<br/>"
															+"</h6>";
								$("h6").remove();
								userAjax.html(displayValue);
// 								alert(displayValue);
//  							$( "#"+userId+"" ).html(displayValue);
								
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				
		});
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
		       		주문관리      
	       </h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  <br/>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		<br/>
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="left">No</th>
			<th align="left" >주문번호</th>
			<th align="left" >고객ID</th>
            <th align="left" >상품명</th>
		    <th align="left" >구매수량</th>
            <th align="left">구매가격</th>
            <th align="left">구매날짜</th>
            <th align="left">현재상태</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
					  <td align="left">${ i }</td>
					  <td align="left">${ purchase.tranNo }
						  		<span id="${purchase.tranNo}"></span>
					  </td>
					  <td align="left">${ purchase.buyer.userId }
						  		<span id="${purchase.buyer.userId}"></span>
					  </td>
					  <td align="left"  title="Click : 상품정보 확인">${purchase.purchaseProd.prodName} 
								<input type="hidden" value="${purchase.purchaseProd.prodNo}"/>
					  </td>
					  <td align="left">${purchase.tranQuantity}개</td>
					  <td align="left">${purchase.tranPrice}원</td>
					  <td align="left">${purchase.orderDate}</td>
					  <td align="left">
						  		 <input type="hidden" id="tranCode" value="${ purchase.tranCode }"/>	
								 <c:if test="${purchase.tranCode eq '1'}">판매완료
								 		 <button type="button" class="btn btn-default btn-xs">배송하기
								 		 			<input type="hidden" value="${purchase.tranNo}"/>
								 		 </button>
								 </c:if>
								 <c:if test="${purchase.tranCode eq '2'}">배송중</c:if>
								 <c:if test="${purchase.tranCode eq '3'}">고객수취확인</c:if>
								 <c:if test="${purchase.tranCode eq '4'}">취소완료</c:if>
					  </td>
<!--				  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodName} "></i>
			  	<input type="hidden" value="${product.prodName} ">
			  </td>-->
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->

 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>
