package com.example.ajax.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ajax.dto.MemberDto;
import com.example.ajax.mapper.MemberMapper;

@Controller
public class MemberController {

    @Autowired
    private MemberMapper memberMapper;

    // 회원가입 폼 보여주기
    @GetMapping("/joinMember")
    public String joinMemberForm() {
        return "joinMember"; // joinMember.jsp로 이동
    }

    // 회원가입 처리
    @PostMapping("/joinMember")
    @ResponseBody
    public String joinMember(MemberDto member) {
        try {
            memberMapper.insertMember(member);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}