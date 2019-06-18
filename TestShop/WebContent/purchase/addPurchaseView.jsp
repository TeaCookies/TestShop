<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
		//Form ��ȿ�� ����		
		var quantity = $( '#tranQuantity').val();
		var mileage=$("#mileage").val();

		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
	}
	
	$(function() {	
			var quantity = $( '#tranQuantity').val();
			var prodQuantity = ${product.prodQuantity};
			var price =  ${purchase.purchaseProd.price } ;
			
// 			$( "#plus" ).on("click" , function() {
// 					console.log ("�÷��� Ȯ��" );
// 					console.log ("${purchase.tranQuantity}" );
// 					quantity++;
// 					$( '#tranQuantity').val(  quantity   );
// 					$( '#tranPrice').val( price  * quantity );
// 					$( '#prodMile').text( (price  * quantity)*(5/100)+"��" );
					
// 					if(quantity  >prodQuantity){
// 						alert("${product.prodQuantity}������ �����Ͻ� �� �ֽ��ϴ�.");
// 						$( '#tranQuantity').val(  prodQuantity  );
// 						$( '#tranPrice').val(  ${purchase.purchaseProd.price * product.prodQuantity  } );
// 						return;
// 					}
// 			});
			
// 			$( "#minus" ).on("click" , function() {
// 					console.log ("���̳ʽ� Ȯ��" );
// 					quantity--;
// 					$( '#tranQuantity').val(  quantity   );
// 					$( '#tranPrice').val( price  * quantity );
// 					$( '#prodMile').text( (price  * quantity)*(5/100)+"��" );
					
// 					if(quantity  < 1 ){
// 							alert("1�� �̻� �����ϼž� �մϴ�.");
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
				console.log ("���ϸ��� : "+mileage);
				console.log ("���� : "+price);
				console.log (parseInt(price) +parseInt(mileage));
				
				if( parseInt(mileage) > parseInt(usermileage)  ){
	 				alert("${purchase.buyer.mileage }�� ���Ϸ� �Է����ּ���.");
	 				$(  "#mileage" ).val(  ${purchase.buyer.mileage }  );
	 				$( '#userMileage').text( 0 );
	 				return;
 				}
	 			if( parseInt(price) <  parseInt(mileage) ){
		 				alert( $( '#tranPrice').val()+"�� ���Ϸ� �Է����ּ���.");
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
					console.log ("üũ Ȯ��" );
					console.log (  $( 'input[type=checkbox]').val()  );
					$( '#tranPrice').val(  parseInt(price)- parseInt(mileage)  );
			}else{
				$( '#tranPrice').val( ${purchase.purchaseProd.price } *  parseInt(quantity)  );
			}
 		});
				
		 
		$( "button:contains('����')" ).on("click" , function() {
			fncAddPurchase();
		});

		$( "button:contains('���')" ).on("click" , function() {
			history.go(-1);
		});
	});
	
	
	$(function() {		
		$( "#divyDate" ).datepicker({
			dateFormat: 'yy-mm-dd',
	        prevText: '���� ��',
	        nextText: '���� ��',
	        monthNames: ['1��', '2��', '3��', '4��', '5��', '6��', '7��', '8��', '9��', '10��', '11��', '12��'],
	        monthNamesShort: ['1��', '2��', '3��', '4��', '5��', '6��', '7��', '8��', '9��', '10��', '11��', '12��'],
	        dayNames: ['��', '��', 'ȭ', '��', '��', '��', '��'],
	        dayNamesShort: ['��', '��', 'ȭ', '��', '��', '��', '��'],
	        dayNamesMin: ['��', '��', 'ȭ', '��', '��', '��', '��'],
	        showMonthAfterYear: true,
	        yearSuffix: '��'

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

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">�ֹ�����</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" name="prodNo" placeholder="��ǰ��ȣ" value="${purchase.purchaseProd.prodNo }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ��" value="${purchase.purchaseProd.prodName }" readonly>
		    </div>
		  </div>
		  
<!-- 		  <div class="form-group"> -->
<!-- 		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label> -->
<!-- 		    <div class="col-sm-4"> -->
<%-- 		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="��������" value="${purchase.purchaseProd.manuDate}" readonly> --%>
<!-- 		    </div> -->
<!-- 		  </div> -->
		  
		  <div class="form-group">
		    <label for="tranPrice" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="tranPrice" name="tranPrice" placeholder="����" value="${purchase.purchaseProd.price*purchase.tranQuantity}" readonly>
		    </div>
		  </div>
		  		  		  
		   <div class="form-group">
		    <label for="tranQuantity" class="col-sm-offset-1 col-sm-3 control-label"> ����</label>
		    <div class="col-sm-1">
		      <input type="text" class="form-control" id="tranQuantity" name="tranQuantity" value="${purchase.tranQuantity}" readonly >
		    </div>
		  </div>

		  		  
		  <div class="form-group">
		    <label for="prodMile" class="col-sm-offset-1 col-sm-3 control-label">���� ����</label>
		    <div class="col-sm-4">
					<span id="prodMile"><fmt:formatNumber  value="${purchase.purchaseProd.price *purchase.tranQuantity* (5/100) }" pattern="0"/>��</span>
		    </div>
		  </div>

		  
		   <div class="form-group">
		    <label for="mileage" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> ������ ���</label>
		     <div class="col-sm-3">
		      <input type="number" class="form-control" id="mileage" name="mileage" value="0" placeholder="������" >
		      ���� ������ : <span id="userMileage">${purchase.buyer.mileage }</span> ��
		    </div>
		     <div class="col-sm-3">
		       <span id="spanMileage" > ��� <input type="checkbox" > </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">������ ���̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="buyerId" name="buyerId" placeholder="������ ���̵�" value="${purchase.buyer.userId }" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> ���Ź��</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="paymentOption" id="paymentOption">
				  	<option value="0" >���ݰ���</option>
					<option value="1" >ī�����</option>
				</select>
		    </div>
		  </div>

		   <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> �������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="�������̸�" value="${purchase.buyer.userName }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> �����ڿ���ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="�����ڿ���ó" value="${purchase.buyer.phone }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label"><i class="glyphicon glyphicon-ok" ></i> �������ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="�������ּ�" value="${purchase.buyer.addr }" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="���ſ�û����">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="����������" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" >����</button>
			  <button type="button" class="btn btn-defalut">���</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>

</html>