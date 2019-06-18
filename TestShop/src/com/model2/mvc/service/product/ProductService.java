package com.model2.mvc.service.product;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;


public interface ProductService {
	
	//��ǰ�߰�
	public void addProduct(Product productVO) throws Exception;

	//��ǰ����Ȯ��
	public Product getProduct(int prodNo) throws Exception;
	public Product getProduct2(int tranNo) throws Exception;

	//��ǰ ����Ʈ
	public Map<String,Object> getProductList(Search searchVO) throws Exception;

	//��ǰ ���� ����
	public void updateProduct(Product productVO) throws Exception;
	
	public void updateProdQuantity(Product productVO) throws Exception;
	
}