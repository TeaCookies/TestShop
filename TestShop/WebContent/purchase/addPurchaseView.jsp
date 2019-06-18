<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
	<script type="text/javascript" src="/resources/events.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css">
	

	
<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	function fncAddPurchase(){
		//Form 유효성 검증		
		var quantity = $( '#tranQuantity').val();
		var mileage=$("#mileage").val();

		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
	}
	
	$(function() {	
			var quantity = $( '#tranQuantity').val();
			var prodQuantity = ${product.prodQuantity};
			var price =  ${purchase.purchaseProd.price } ;
			
// 			$( "#plus" ).on("click" , function() {
// 					console.log ("플러스 확인" );
// 					console.log ("${purchase.tranQuantity}" );
// 					quantity++;
// 					$( '#tranQuantity').val(  quantity   );
// 					$( '#tranPrice').val( price  * quantity );
// 					$( '#prodMile').text( (price  * quantity)*(5/100)+"원" );
					
// 					if(quantity  >prodQuantity){
// 						alert("${product.prodQuantity}개까지 구매하실 수 있습니다.");
// 						$( '#tranQuantity').val(  prodQuantity  );
// 						$( '#tranPrice').val(  ${purchase.purchaseProd.price * product.prodQuantity  } );
// 						return;
// 					}
// 			});
			
// 			$( "#minus" ).on("click" , function() {
// 					console.log ("마이너스 확인" );
// 					quantity--;
// 					$( '#tranQuantity').val(  quantity   );
// 					$( '#tranPrice').val( price  * quantity );
// 					$( '#prodMile').text( (price  * quantity)*(5/100)+"원" );
					
// 					if(quantity  < 1 ){
// 							alert("1개 이상 구매하셔야 합니다.");
// 							$( '#tranQuantity').val(  1  );
// 							$( '#tranPrice').val(${purchase.purchaseProd.price} );
// 							return;
// 					}
// 			});
			

 		 $( "#mileage" ).keyup(function( ) {
				var mileage =  $( "#mileage" ).val().trim() ;
				var usermileage = ${purchase.buyer.mileage };
				var price = $( '#tranPrice').val();
				$( '#userMileage').text( usermileage-mileage  );
				console.log ("마일리지 : "+mileage);
				console.log ("가격 : "+price);
				console.log (parseInt(price) +parseInt(mileage));
				
				if( parseInt(mileage) > parseInt(usermileage)  ){
	 				alert("${purchase.buyer.mileage }원 이하로 입력해주세요.");
	 				$(  "#mileage" ).val(  ${purchase.buyer.mileage }  );
	 				$( '#userMileage').text( 0 );
	 				return;
 				}
	 			if( parseInt(price) <  parseInt(mileage) ){
		 				alert( $( '#tranPrice').val()+"원 이하로 입력해주세요.");
		 				$(  "#mileage" ).val(  price  );
		 				$( '#userMileage').text( usermileage-price )
		 				return;
	 			}
	 			
 		 } ) ; 
 		 
 		$( 'input[type=checkbox]').on('click', function(){
			var price = $( '#tranPrice').val();
			var mileage =  $( "#mileage" ).val() ;
			var quantity = $( '#tranQuantity').val(  );
			var usermileage = ${purchase.buyer.mileage };
			
 			if (    $( 'input[type=checkbox]').prop("checked")   ){
					console.log ("체크 확인" );
					console.log (  $( 'input[type=checkbox]').val()  );
					$( '#tranPrice').val(  parseInt(price)- parseInt(mileage)  );
			}else{
				$( '#tranPrice').val( ${purchase.purchaseProd.price } *  parseInt(quantity)  );
			}
 		});
				
		 
		$( "button:contains('구매')" ).on("click" , function() {
			fncAddPurchase();
		});

		$( "button:contains('취소')" ).on("click" , function() {
			history.go(-1);
		});
	});
	
	
	$(function() {		
		$( "#divyDate" ).datepicker({
			dateFormat: 'yy-mm-dd',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: '년'

		});
	
	});
	


</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">주문결제</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" name="prodNo" placeholder="상품번호" value="${purchase.purchaseProd.prodNo }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명" value="${purchase.purchaseProd.prodName }" readonly>
		    </div>
		  </div>
		  
<!-- 		  <div class="form-group"> -->
<!-- 		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label> -->
<!-- 		    <div class="col-sm-4"> -->
<%-- 		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자" value="${purchase.purchaseProd.manuDate}" readonly> --%>
<!-- 		    </div> -->
<!-- 		  </div> -->
		  
		  <div class="form-group">
		    <label for="tranPrice" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="tranPrice" name="tranPrice" placeholder="가격" value="${purchase.purchaseProd.price*purchase.tranQuantity}" readonly>
		    </div>
		  </div>
		  		  		  
		   <div class="form-group">
		    <label for="tranQuantity" class="col-sm-offset-1 col-sm-3 control-label"> 수량</label>
		    <div class="col-sm-1">
		      <input type="text" class="form-control" id="tranQuantity" name="tranQuantity" value="${purchase.tranQuantity}" readonly >
		    </div>
		  </div>

		  		  
		  <div class="form-group">
		    <label for="prodMile" class="col-sm-offset-1 col-sm-3 control-label">적립 예정</label>
		    <div class="col-sm-4">
					<span id="prodMile"><fmt:formatNumber  value="${purchase.purchaseProd.price *purchase.tranQuantity* (5/100) }" pattern="0"/>원</span>
		    </div>
		  </div>

		  
		   <div class="form-group">
		    <label for="mileage" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 적립금 사용</label>
		     <div class="col-sm-3">
		      <input type="number" class="form-control" id="mileage" name="mileage" value="0" placeholder="적립금" >
		      보유 적립금 : <span id="userMileage">${purchase.buyer.mileage }</span> 원
		    </div>
		     <div class="col-sm-3">
		       <span id="spanMileage" > 사용 <input type="checkbox" > </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" placeholder="구매자 아이디" value="${purchase.buyer.userId }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매방법</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="paymentOption" id="paymentOption">
				  	<option value="0" >현금결제</option>
					<option value="1" >카드결제</option>
				</select>
		    </div>
		  </div>

		   <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="구매자이름" value="${purchase.buyer.userName }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매자연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="구매자연락처" value="${purchase.buyer.phone }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> 구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="구매자주소" value="${purchase.buyer.addr }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="배송희망일자" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" >구매</button>
			  <button type="button" class="btn btn-defalut">취소</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>