<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		
		$( "button:contains('����')" ).on("click" , function() {
			self.location = "/purchase/updatePurchase?tranNo=${purchase.tranNo}";
		});
		
		
		$( "button:contains('���')" ).on("click" , function() {
			console.log("��� Ŭ��");
			self.location = "/purchase/listPurchase";
		});
	});
	


</script>


</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">���Ż���ȸ</h3>
    </div>
    
    <div class="media">
		  <div class="media-left">
			    <a href="#">
				       <img src="../images/uploadFiles/${purchase.purchaseProd.fileName}" width="64" height="64" 
					    		      onerror="this.src='http://placehold.it/64x64'"/>
			    </a>
		  </div>
		  <div class="media-body">
			    <h4 class="media-heading">[${purchase.purchaseProd.prodNo}] ${purchase.purchaseProd.prodName }</h4>
			   [�����ݾ�] ${purchase.tranPrice }�� [����] ${purchase.tranQuantity }��
		  </div>
	</div>
	<br/><br/><br/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�ֹ���ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.tranNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">
						<c:if test="${purchase.paymentOption eq '0'}">���ݰ���</c:if>
						 <c:if test="${purchase.paymentOption eq '1'}">ī�����</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��� ������</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.mileage}��</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ֹ���</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<c:if test="${purchase.tranCode eq '1' }">
	  				<button type="button" class="btn btn-primary">����</button>
	  			</c:if>
	  			<c:if test="${purchase.tranCode ne '1' }">
					�߼� �Ŀ��� �����Ͻ� �� �����ϴ�.
	  			</c:if>
	  			<button type="button" class="btn btn-default">���</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>