package com.example.ajax.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CountryMapper {
    List<Map<String, Object>> selectCountryList(int ContinentNo);
}
