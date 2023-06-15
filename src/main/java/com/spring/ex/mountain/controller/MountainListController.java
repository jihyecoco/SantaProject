package com.spring.ex.mountain.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.InputSource;

import com.spring.ex.mountain.model.MountainBean;
import com.spring.ex.mountain.model.MountainDao;

@Controller
public class MountainListController {

	//요청 값을 담은 변수
	private final String command = "/mountain/all/list.mnt";
	//이동할 jsp 페이지 변수
	private String getPage = "/mountain/mountainList";
	
	@Autowired
	static
	MountainDao mdao;
	
	//사용자-상단 메뉴에서 mountain 클릭 시 요청 발생=>mountainList.jsp로 이동
	@RequestMapping(value=command)
	public ModelAndView doAPI() throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		//인증 서비스 키
		String serviceKey = "4Nr4EpPOmzOdPQucRWM%2BxXD2SXtgJKTe4sXKKDUnfIJYnd8dx4pJ1Bgyhppi1m%2B1iNVym8TwDikVNKTrgklj1A%3D%3D";
		
		StringBuilder urlBuilder = new StringBuilder("http://openapi.forest.go.kr/openapi/service/trailInfoService/getforeststoryservice"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + serviceKey); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("mntnNm","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*산명*/
        urlBuilder.append("&" + URLEncoder.encode("mntnHght","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*산정보 높이*/
        urlBuilder.append("&" + URLEncoder.encode("mntnAdd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*산 소재지*/
        urlBuilder.append("&" + URLEncoder.encode("mntnInfoAraCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*산정보지역정보*/
        urlBuilder.append("&" + URLEncoder.encode("mntnInfoSsnCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*산정보계절코드*/
        urlBuilder.append("&" + URLEncoder.encode("mntnInfoThmCd","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*산정보주제코드*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        
        //나중에 사용할 map을 선언
        Map<String, Object> map = new HashMap<String, Object>();
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        
        //getResponseCode가 200이상 300이하일때는 정상적으로 작동
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }//if~else end
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }//while end
        rd.close();
        conn.disconnect();
        
        //StringBuilder로 위에 파라미터 더한값을 toString으로 불러와 출력
        System.out.println(sb.toString());
        
        //getResultMap에 xml을 불러온 값을 저장, list 객체로 관리
        List<HashMap<String, String>> list = getResultMap(sb.toString());
        
        //API에서 불러올 값을 map에 저장
        for(Map<String,String> tmpMap : list) {
            map.put("mountain_name", tmpMap.get("mntnnm"));
            map.put("mountain_local", tmpMap.get("mntninfopoflc"));
            map.put("mountain_height", tmpMap.get("mntninfohght"));
            map.put("mountain_content", tmpMap.get("mntninfodtlinfocont"));
            map.put("mountain_image", tmpMap.get("mntnattchimageseq"));
            map.put("mountain_great", tmpMap.get("hndfmsmtnslctnrson"));
        }
        
        firstApiInsert(map);
        
        //mav.addObject("firstApiInsert",firstApiInsert(map));
        mav.setViewName(getPage);
        
        return mav;
    }//doAPI end
	
	//값을 검색하고 db가 비어있으면 api값을 db에 삽입하는 firstApiInsert 함수
	public static void firstApiInsert(Map<String, Object> map){
		//mav 객체 생성
		ModelAndView mav = new ModelAndView();
		
		//검색을 위해 map 객체에 검색 카테고리와 검색 키워드 값 저장
		//Map<String, String> searchMap = new HashMap<String, String>();
		//searchMap.put("whatColumn", whatColumn);
		//searchMap.put("keyword", "%"+keyword+"%");
		
		//전체 튜플 갯수를 구해 변수에 저장, map에 저장된 조건으로도 검색
		//int totalCount = mdao.getTotalCount(searchMap);
		
		//System.out.println("tc:"+totalCount);
				
		//url을 변수에 저장
		//String pagingUrl = request.getContextPath() +"/"+ command;
		
		//페이지 정보 가져오기
		//Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword, null);
		//System.out.println("pageInfo : "+pageInfo);
		
		
		//mountain 목록을 list 객체에 저장
		List<MountainBean> mountainLists = mdao.getAllMountainFirst(/*Searchmap, pageInfo*/);
		
		//dao의 mountainLists가 비어있는지 테스트 출력
		String first_mountain = mountainLists.get(0).getMountainname();
		System.out.println("첫번째 산 이름 : "+first_mountain);
        
        if(first_mountain == null) {
        	//만약 비어있으면 api에서 불러온 값들을 insert해서 값 저장
        	//map을 매개변수로
        	int cnt = mdao.insertMountainFirst(map);
        		
        	if(cnt > 0) {
        		//insert 성공 시
        		
        	}else {
        		//insert 실패 시
        		
        	}
        }else {
        	//만약 비어있지 않으면 해당 값을 mav에 저장해서 list로 넘겨줌
        	mav.addObject("mountainLists",mountainLists);
        }
		
	}//doFirst End
	
	//결과값을 뽑아주는 getResultMap 함수
	public static List<HashMap<String, String>> getResultMap(String data) throws Exception {
		 
		//결과값을 넣어줄 map을 선언
		List<HashMap<String, String>> resultMap = new LinkedList<HashMap<String, String>>();
		        
		InputSource is = new InputSource(new StringReader(data));
		 
		//Document 클래스로 xml데이터를 취득
		Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
		 
		//xPath 팩토리로 객체 생성
		XPath xpath = XPathFactory.newInstance().newXPath();
		 
		//xPath를 컴파일한 후에 node단위로 데이터를 수집
		//xpath로 데이터를 수집할 위치를 잡아줌
		NodeList nodeList = (NodeList) xpath.compile("/response/body/items/item").evaluate(document, XPathConstants.NODESET);
		int nodeListCount = nodeList.getLength();
		for (int i = 0; i < nodeListCount; i++) {
		    NodeList childNode = nodeList.item(i).getChildNodes();
		    HashMap<String, String> nodeMap = new HashMap<String, String>();
		    int childNodeCount = childNode.getLength();
		    for (int j = 0; j < childNodeCount; j++) {
		        nodeMap.put(childNode.item(j).getNodeName(), childNode.item(j).getTextContent());
		    }//for end
		    resultMap.add(nodeMap);
		}//for end
		return resultMap;
	}//getResultMap end
	
	
}//class
