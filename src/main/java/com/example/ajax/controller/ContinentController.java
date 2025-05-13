package com.example.ajax.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // ✅ 추가
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ajax.mapper.ContinentMapper;

@Controller
public class ContinentController {
    
    @Autowired
    private ContinentMapper continentMapper;

    @GetMapping({"/", "/continentList"})
    public String continentList(
    		@RequestParam(value = "continent", required = false) String continentNo
    		, @RequestParam(value = "country", required = false) String countryNo
    		, Model model
    	){
    	
        // 대륙
        model.addAttribute("continentList", continentMapper.selectContinentList());

        // 나라
        if (continentNo != null && !continentNo.isEmpty()) {
            model.addAttribute("countryList", continentMapper.selectCountryListByContinent(continentNo));
        }

        // 도시
        if (countryNo != null && !countryNo.isEmpty()) {
            model.addAttribute("cityList", continentMapper.selectCityListByCountry(countryNo));
        }

        return "continentList";
    }
}