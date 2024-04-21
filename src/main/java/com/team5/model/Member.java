package com.team5.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity @Table(name="member")
@Component
public class Member {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer sid;
	private String account;
	private String password;
	private String email;
	private String phone;
	private String name;
	private String gender;
	private String address;
	private String photosticker;
	private Integer seller;
	private Integer admin;
	private Integer reviewcount;
	private Integer cumulativescore;
	private Integer totalsalesamount;
	
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "member",cascade = CascadeType.ALL)
	private List<Post> posts=new ArrayList<Post>();

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhotosticker() {
		return photosticker;
	}

	public void setPhotosticker(String photosticker) {
		this.photosticker = photosticker;
	}

	public Integer getSeller() {
		return seller;
	}

	public void setSeller(Integer seller) {
		this.seller = seller;
	}

	public Integer getAdmin() {
		return admin;
	}

	public void setAdmin(Integer admin) {
		this.admin = admin;
	}

	public Integer getReviewcount() {
		return reviewcount;
	}

	public void setReviewcount(Integer reviewcount) {
		this.reviewcount = reviewcount;
	}

	public Integer getCumulativescore() {
		return cumulativescore;
	}

	public void setCumulativescore(Integer cumulativescore) {
		this.cumulativescore = cumulativescore;
	}

	public Integer getTotalSalesamount() {
		return totalsalesamount;
	}

	public void setTotalSalesamount(Integer totalSalesamount) {
		this.totalsalesamount = totalSalesamount;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	
    
}
