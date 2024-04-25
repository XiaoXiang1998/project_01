package com.team5.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity @Table(name = "result")
@Component
public class Result {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer rid;
	
	private Integer flag;
	
	private String message;
	
	@ManyToOne
	@JoinColumn(name="fk_userid")
	private Member memberResult;

	public Integer getRid() {
		return rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Member getMemberResult() {
		return memberResult;
	}

	public void setMemberResult(Member memberResult) {
		this.memberResult = memberResult;
	}
	
	
	
}
