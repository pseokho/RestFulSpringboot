package com.Springboot.rest.servcie;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

@Service
public class RestServiceImpl implements RestfulService {

    @Override
    public String restfulApiKkakao(Map<String, Object> param) {
        String rtnResult = null;
        try {
            rtnResult = getRestFulApiKakaoSerach(param);
        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
        return rtnResult;
    }

    /**
     * 
     * @param param : 사용자가 검색한 키워드
     * @return json 데이터 형식
     * @throws ParseException
     * @throws IOException
     */
    public String getRestFulApiKakaoSerach(Map<String, Object> param) throws ParseException, IOException {

        String jsonData = null;
        String keyWord = null;
        String listSize = null;
        String pageNum = null;
        final String USER_AGENT = "KakaoAK 1c34ad52f343baa8e023b821aa14f5a6";
        String GET_URL = "https://dapi.kakao.com/v2/local/search/keyword.json?query=";
        try {

            keyWord = param.get("keyword").toString();
            listSize = param.get("listSize").toString();
            pageNum = param.get("pageNum").toString();
            CloseableHttpClient httpClient = HttpClients.createDefault();
            GET_URL = GET_URL + keyWord; // 검색을 원하는 질의어
            GET_URL = GET_URL + "&size=" + listSize; // 한 페이지에 보여질 문서의 개수
            GET_URL = GET_URL + "&page=" + pageNum; // 결과 페이지 번호

            // get 메서드와 URL 설정
            HttpGet httpGet = new HttpGet(GET_URL);

            // agent 정보 설정
            httpGet.addHeader("Authorization", USER_AGENT);
            httpGet.addHeader("Content-type", "application/json");

            // get 요청
            CloseableHttpResponse httpResponse = httpClient.execute(httpGet);

            jsonData = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");

            httpClient.close();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        }
        return jsonData;

    }

}
