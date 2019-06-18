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
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
		<script type="text/javascript" src="/resources/events.js"></script>
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
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
			
			$(function() {
// 				var quantity = $( '#tranQuantity').val();
// 				var prodQuantity = ${product.prodQuantity};
// 				var price =  ${product.price } ;
				
// 				$( "#plus" ).on("click" , function() {
// 					console.log ("�÷��� Ȯ��" );
// 					quantity++;
// 					$( '#tranQuantity').val(  quantity   );
					
// 					if(quantity  >prodQuantity){
// 						alert("${product.prodQuantity}������ �����Ͻ� �� �ֽ��ϴ�.");
// 						$( '#tranQuantity').val(  prodQuantity  );
// 						return;
// 					}
// 			});
			
// 			$( "#minus" ).on("click" , function() {
// 					console.log ("���̳ʽ� Ȯ��" );
// 					quantity--;
// 					$( '#tranQuantity').val(  quantity   );
					
// 					if(quantity  < 1 ){
// 							alert("1�� �̻� �����ϼž� �մϴ�.");
// 							$( '#tranQuantity').val(  1  );
// 							return;
// 					}
// 			});
				
				$( "button:contains('���')" ).on("click" , function() {
					$(self.location).attr("href","/product/listProduct?menu=${ param.menu}");
				});
				
				$( "button:contains('����')" ).on("click" , function() {
					self.location ="/product/updateProduct?prodNo=${ product.prodNo }";
				});
				
				
				$( "button:contains('����')" ).on("click" , function() {
					//self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
					$("form").attr("method" , "GET").attr("action" , "/purchase/addPurchase?prodNo=${product.prodNo}").submit();

					console.log ("/purchase/addPurchase?prodNo=${product.prodNo}" );
				});
			});
			

			$(function() {
				$( "#tranQuantity" ).spinner({ //���ǳʸ� ������ش�.
// 					min: 1,   //���ǳʷ� ���� �� �ִ� �ּ� ��
// 					max: 100,  //���ǳʷ� �ø� �� �ִ� �ִ� ��
// 					step: 1  //�ѹ� Ŭ���� �����Ǵ� ��

					stop: function (event, ui) {
						var quan =  $( "#tranQuantity" ).val();
						var prod = ${product.prodQuantity};
						
// 				        $('#test').text(   $( "#tranQuantity" ).val()  );
						console.log( "���� Ȯ�� : "+ quan  );
						console.log(  ${product.prodQuantity} );
						
						if (  quan>  prod ){
							alert("${product.prodQuantity}������ �����Ͻ� �� �ֽ��ϴ�.");
							 $( "#tranQuantity" ).val( prod );
						}
				    }
				
				});
			});
			
	</script>
</head>

<body>
<form>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����ȸ</h3>
    	</div>
	
	
	      <div class="row marketing">
	        <div class="col-lg-4">
	          <img src="../images/uploadFiles/${product.fileName}" width="400" height="400" 
	    		      onerror="this.src='http://placehold.it/400x400'"/>
<%-- 	    		      ���� �̸� Ȯ�� :  ${product.fileName} --%>
	        </div>
	        
	        <div class="col-lg-1">
	        </div>
	
	        <div class="col-lg-7">
	          <div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>��ǰ��ȣ</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodNo }</div>
				<input type="hidden" id="prodNo" name="prodNo" value="${ product.prodNo }">
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3 "><strong>��ǰ��</strong></div>
				<div class="col-xs-8 col-md-8">${ product.prodName }</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3 "><strong>��ǰ������</strong></div>
				<div class="col-xs-8 col-md-8">${ product.prodDetail }</div>
			</div>
			
			<hr/>
			
<!-- 			<div class="row"> -->
<!-- 		  		<div class="col-xs-4 col-md-3"><strong>��������</strong></div> -->
<%-- 				<div class="col-xs-8 col-md-4">${ product.manuDate }</div> --%>
<!-- 			</div> -->
			
<!-- 			<hr/> -->
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>����</strong></div>
				<div class="col-xs-8 col-md-4">${ product.price }��</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>������</strong></div>
				<div class="col-xs-8 col-md-4"><fmt:formatNumber value="${ product.price*(5/100) }" pattern="0"/>��</div>
			</div>
			
			<hr/>
			
			<div class="row">
		  		<div class="col-xs-4 col-md-3"><strong>����</strong></div>
				<div class="col-xs-2 col-md-2"> 
						<input type="number" class="form-control" id="tranQuantity" name="tranQuantity" value="1" readonly placeholder="����">
				</div>
				<div><span id="test"></span></div>
			</div>
		
<!-- 			<hr/> -->
			
<!-- 			<div class="row"> -->
<!-- 		  		<div class="col-xs-4 col-md-3 "><strong>�������</strong></div> -->
<%-- 				<div class="col-xs-8 col-md-4">${ product.regDate }</div> --%>
<!-- 			</div> -->
          
        </div>
      </div>
		
		<hr/>
				  			<% System.out.println( "�׽�Ʈ@@@@@@@@@@@"+ request.getParameter("menu")); %>
		<div class="row">
		
	  		<div class="col-md-12 text-center ">
		  		<c:if test="${ empty sessionScope.user  }">��ȸ���� �����Ͻ� �� �����ϴ�.<br/>
				</c:if>
		  		<c:if test="${ param.menu ne 'manage' && product.prodQuantity != 0 &&  !(empty sessionScope.user)   }">
		  				<button type="button" class="btn btn-primary">����</button>
		  		</c:if>
		  		<c:if test="${ product.prodQuantity == 0}">
   						<a href="#" class="btn btn-danger" role="button">ǰ��</a>
   				</c:if>
   				<c:if test="${ param.menu eq 'manage'}">
		  				<button type="button" class="btn btn-defalut">����</button>
		  		</c:if>
	  			<button type="button" class="btn btn-defalut">���</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
</form>
</body>

</html>