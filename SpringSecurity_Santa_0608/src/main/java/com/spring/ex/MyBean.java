<<<<<<< HEAD
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
		String osName = System.getProperty("os.name").toLowerCase();
		System.out.println("MyBean OS name : " + osName);
		String str = "";
		if (osName.contains("win")) 
		{
			System.out.println("사용자 OS - Window ");
			str = "C:/tempUpload";
		} 
		else if (osName.contains("mac")) 
		{
			System.out.println("사용자 OS - MAC ");
			str = "/Users/ol7roeo/Documents/tempUpload"; 
		} 
		File destination_local = new File(str); // 임시 폴더

		FileUtils.copyDirectory(destination_local, destination);
	}

}//MyBean
=======
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
		String osName = System.getProperty("os.name").toLowerCase();
		System.out.println("MyBean OS name : " + osName);
		String str = "";
		if (osName.contains("win")) 
		{
			System.out.println("사용자 OS - Window ");
			str = "C:/tempUpload";
		} 
		else if (osName.contains("mac")) 
		{
			System.out.println("사용자 OS - MAC ");
			str = "/Users/ol7roeo/Documents/tempUpload"; 
		} 
		File destination_local = new File(str); // 임시 폴더

		FileUtils.copyDirectory(destination_local, destination);
	}

}//MyBean
>>>>>>> 4e246532303b5c8deea54eb54aa01591413f0758
