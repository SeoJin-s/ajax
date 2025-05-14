package com.example.ajax.dto;

public class MemberDto {
	private String id;
	private String pw;
	private String gender;
	private int age;
	private String address; // ✅ 통합 주소 필드

	public MemberDto() {}

	public MemberDto(String id, String pw, String gender, int age, String address) {
		this.id = id;
		this.pw = pw;
		this.gender = gender;
		this.age = age;
		this.address = address;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", gender=" + gender + ", age=" + age + ", address=" + address + "]";
	}

	// Getters / Setters
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
