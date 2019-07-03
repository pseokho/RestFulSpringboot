package com.Springboot.controller;

import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.Springboot.rest.servcie.RestfulService;
import com.Springboot.services.SearchHistSerivce;
import com.fasterxml.jackson.core.JsonProcessingException;

/**
 * 실제 서비스가 처리되도록 Model 역활
 * 
 * @author p
 *
 */
@Controller
public class MainContoller {
    // serach 관련 Controller
    @Autowired
    SearchHistSerivce searchController;
    // restFul연동 Controller
    @Autowired
    RestfulService restfulController;
    
    @RequestMapping(value = "/popularSearchesHist", produces = "application/text; charset=utf8", method = RequestMethod.GET)
    public @ResponseBody String popularSearchesHist(){
        JSONObject json = new JSONObject();
        json.put("data", searchController.popularSearches());
        return json.toString();
    }
    
    @RequestMapping(value = "/userSearchHist", produces = "application/text; charset=utf8", method = RequestMethod.GET)
    public @ResponseBody String userSearchHist(Authentication auth){
        
        String username = auth.getName();
        JSONObject json = new JSONObject();
        json.put("data", searchController.userSearchHist(username));
        return json.toString();
    }
    @RequestMapping(value = "/serach", produces = "application/text; charset=utf8", method = RequestMethod.GET)
    public @ResponseBody String serach(@RequestParam Map<String, Object> param, Authentication auth)
            throws ParseException, JsonProcessingException, org.apache.tomcat.util.json.ParseException {

        JSONObject json = new JSONObject(restfulController.restfulApiKkakao(param));
        String username = auth.getName();
        String keyword = param.get("keyword").toString();
        searchController.insertSearchHist(username, keyword);
        return json.toString();
    }
    @RequestMapping(value = "/pageSerach", produces = "application/text; charset=utf8", method = RequestMethod.GET)
    public @ResponseBody String pageSerach(@RequestParam Map<String, Object> param)
            throws ParseException, JsonProcessingException, org.apache.tomcat.util.json.ParseException {
        JSONObject json = new JSONObject(restfulController.restfulApiKkakao(param));
        return json.toString();
    }

    @RequestMapping(value = "/")
    public ModelAndView loginPage(Authentication auth) {
        ModelAndView model = new ModelAndView();
        String username = auth.getName();
        model.addObject("username", username);
        model.setViewName("home");// return view 네임지정

        return model;
    }
}
