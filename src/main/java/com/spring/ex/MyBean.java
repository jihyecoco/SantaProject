package com.spring.ex;

import java.io.File;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;

public class MyBean implements InitializingBean {
	
	@Autowired
	ServletContext servletContext;
	
	@PostConstruct
	public void init() {
		System.out.println("------init()------");
	}
	
	@Override
	public void afterPropertiesSet() throws Exception {
		System.out.println("-----afterPropertiesSet()-----");
		
		String uploadPath = servletContext.getRealPath("/resources/images/products/");
		
		File destination = new File(uploadPath); // 웹 서버 폴더
		//String str = "/Users/ol7roeo/Documents/tempUpload"; // 가영 임시 폴더
		String str = "C:/tempUpload";// 지혜 임시 폴더
		File destination_local = new File(str); // 임시 폴더
		
		FileUtils.copyDirectory(destination_local, destination);
	}

}//MyBean
