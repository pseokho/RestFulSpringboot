package com.Springboot.services;

import java.util.List;
import java.util.Map;

import com.Springboot.vo.HistSearch;

public interface SearchHistSerivce {

	/**
	 * 사용자가 검색을 하면 정보를 입력한다.
	 * @param  사용자이름 / 키워드
	 */
	public void  insertSearchHist (String username, String keyword); 
	
	/**
	 * 인기 검색어 검색
	 * @return 인기 검색정보. 키워드 /키워드 별로 검색된 횟수 별로  많은순서대로 10개까지효출
	 */
	public List<Map<String,Object>> popularSearches();

	/**
	 * 유저에 마지막 검색어 목록
	 * @return 내 검색 히스토리 리턴
	 */
    public List<Map<String,Object>> userSearchHist(String username);
}
