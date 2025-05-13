package com.example.ajax.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContinentMapper  {
	// 대륙
	List<Map<String, Object>> selectContinentList(); 
	// 나라
	List<Map<String, Object>> selectCountryListByContinent(String continentNo);
	// 도시
	List<Map<String, Object>> selectCityListByCountry(String countryNo);
}
