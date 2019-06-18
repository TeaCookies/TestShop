package com.model2.mvc.service.domain;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;


public class Product {
	
	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	private String proTranCode;
	private MultipartFile upload;
	private int prodQuantity;
//	private int tranQuantity;

	private int prodTranNo;
	private int prodTranPrice;


	
//	public int getTranQuantity() {
//		return tranQuantity;
//	}
//
//	public void setTranQuantity(int tranQuantity) {
//		this.tranQuantity = tranQuantity;
//	}

	public int getProdTranPrice() {
		return prodTranPrice;
	}

	public void setProdTranPrice(int prodTranPrice) {
		this.prodTranPrice = prodTranPrice;
	}

	public int getProdTranNo() {
		return prodTranNo;
	}

	public void setProdTranNo(int prodTranNo) {
		this.prodTranNo = prodTranNo;
	}

	public int getProdQuantity() {
		return prodQuantity;
	}

	public void setProdQuantity(int prodQuantity) {
		this.prodQuantity = prodQuantity;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}

	public Product(){
	}
	
	public String getProTranCode() {
		if (proTranCode != null) {
			proTranCode = proTranCode.trim();
		}
		return proTranCode;
	}
	public void setProTranCode(String proTranCode){
		if (proTranCode != null) {
			proTranCode = proTranCode.trim();
		}
		this.proTranCode = proTranCode;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	// Override
	public String toString() {
		return "Product : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo+"[proTranCode]"+proTranCode;
	}	
}