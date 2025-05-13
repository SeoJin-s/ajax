package com.example.ajax.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.ajax.dto.MemberDto;

@Mapper
public interface MemberMapper {
	// ID 중복검사
	public String selectMemberId(String id);
	// 회원가입
	int insertMember(MemberDto member);
}
