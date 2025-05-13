package com.example.ajax.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.ajax.mapper.MemberMapper;

@RestController
public class MemberRest {
	@Autowired MemberMapper memberMapper;
	
	@GetMapping("/isId/{id}")
	@ResponseBody
	public String isId(@PathVariable String id) {
	    String result = memberMapper.selectMemberId(id);
	    System.out.println(">>> [중복확인] id: " + id + ", result: " + result);
	    return (result != null) ? "true" : "false"; // ← 문자열!
	}
}
