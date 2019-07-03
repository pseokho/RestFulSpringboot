package com.Springboot.services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Springboot.mapper.SearchHistMapper;
import com.Springboot.vo.HistSearch;

@Service
public class SearchHistImpl implements SearchHistSerivce{

    @Autowired
    SearchHistMapper searchHistMapper;
    @Override
    public void insertSearchHist(String username, String keyword) {
        String search_Time   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
        searchHistMapper.insertSearchHist(username, keyword, search_Time);
        
    }

    @Override
    public List<Map<String,Object>> popularSearches() {
        return searchHistMapper.popularSearches();
    }

    public List<Map<String,Object>> userSearchHist(String username){
        return searchHistMapper.userSearchHist(username);
    }

}
