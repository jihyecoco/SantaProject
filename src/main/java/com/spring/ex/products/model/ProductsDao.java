package com.spring.ex.products.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductsDao {
	//private final String namespace ="products.ProductsBean";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertProducts(ProductsBean pb) {
		int cnt = -1;
		//cnt = sqlSessionTemplate.insert(namespace+".InsertProducts", pb);
		cnt = sqlSessionTemplate.insert("InsertProducts", pb);
		return cnt;
	}

	public List<ProductsBean> getAllProducts() {
		List<ProductsBean> plist = new ArrayList<ProductsBean>();
		//plist = sqlSessionTemplate.selectList(namespace+".GetAllProducts");
		plist = sqlSessionTemplate.selectList("GetAllProducts");
		return plist;
	}

	public ProductsBean getProductsByNum(int num) {
		ProductsBean pb = new ProductsBean();
		//pb = sqlSessionTemplate.selectOne(namespace+".GetProductsByNum",num);
		pb = sqlSessionTemplate.selectOne("GetProductsByNum",num);
		return pb;
	}
	
}
