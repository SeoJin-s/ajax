package com.example.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ajax.mapper.ContinentMapper;

@Controller
public class CntnntController {
    @Autowired
    private ContinentMapper continentMapper;
    
    @GetMapping({"/cntnntList"})
    public String continentList(
    		@RequestParam(value = "continent", required = false) String continentNo
    		, @RequestParam(value = "country", required = false) String countryNo
    		, Model model
    	){
    	
        // 대륙
        model.addAttribute("cntnntList", continentMapper.selectContinentList());

        // 나라
        if (continentNo != null && !continentNo.isEmpty()) {
            model.addAttribute("countryList", continentMapper.selectCountryListByContinent(continentNo));
        }

        // 도시
        if (countryNo != null && !countryNo.isEmpty()) {
            model.addAttribute("cityList", continentMapper.selectCityListByCountry(countryNo));
        }

        return "cntnntList";
    }
}