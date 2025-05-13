package com.example.ajax.rest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.example.ajax.mapper.CityMapper;
import com.example.ajax.mapper.CountryMapper;

@RestController
public class CntnntRest {

    @Autowired
    private CountryMapper countryMapper;

    @Autowired
    private CityMapper cityMapper;

    // 대륙 번호로 나라 목록
    @GetMapping("/cntList/{continentNo}")
    public List<Map<String, Object>> cntList(@PathVariable int continentNo) {
        return countryMapper.selectCountryList(continentNo);
    }

    // 나라 번호로 도시 목록
    @GetMapping("/cityList/{countryNo}")
    public List<Map<String, Object>> ctyList(@PathVariable int countryNo) {
        return cityMapper.selectCityList(countryNo);
    }
}

