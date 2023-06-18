package com.spring.ex.pay.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PayDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insertPay(PayBean pay_bean) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert("InsertPay", pay_bean);
		return cnt;
	}

	public PayBean getPayByPrdnum(PayBean pay_bean) {
		PayBean pay_result = sqlSessionTemplate.selectOne("GetPayByPrdnum", pay_bean);
		return pay_result;
	}
}
