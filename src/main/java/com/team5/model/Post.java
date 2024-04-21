package com.team5.model;





import org.springframework.stereotype.Component;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity @Table(name="post")
@Component
public class Post {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer commentid;
	private String commentcontent;
	private  String productphoto;
	
	private java.sql.Timestamp commenttime;
	private java.sql.Timestamp lastmodifiedtime;
	private Integer buyerrate;
	private String replayconetnt;
	private java.sql.Timestamp replaytime;
	private Integer sellerrate;
	
	@ManyToOne
	@JoinColumn(name="fk_userid")
	private Member member;
	
	
	

	public Post() {
		
	}
	
	

	public Post(Integer commentid, String commentcontent, java.sql.Timestamp commenttime) {
		this.commentid = commentid;
		this.commentcontent = commentcontent;
		this.commenttime = commenttime;
	}



	public Integer getCommentid() {
		return commentid;
	}



	public void setCommentid(Integer commentid) {
		this.commentid = commentid;
	}



	public String getCommentcontent() {
		return commentcontent;
	}



	public void setCommentcontent(String commentcontent) {
		this.commentcontent = commentcontent;
	}



	public String getProductphoto() {
		return productphoto;
	}



	public void setProductphoto(String productphoto) {
		this.productphoto = productphoto;
	}



	public java.sql.Timestamp getCommenttime() {
		return commenttime;
	}



	public void setCommenttime(java.sql.Timestamp commenttime) {
		this.commenttime = commenttime;
	}



	public java.sql.Timestamp getLastmodifiedtime() {
		return lastmodifiedtime;
	}



	public void setLastmodifiedtime(java.sql.Timestamp lastmodifiedtime) {
		this.lastmodifiedtime = lastmodifiedtime;
	}



	public Integer getBuyerrate() {
		return buyerrate;
	}



	public void setBuyerrate(Integer buyerrate) {
		this.buyerrate = buyerrate;
	}



	public String getReplayconetnt() {
		return replayconetnt;
	}



	public void setReplayconetnt(String replayconetnt) {
		this.replayconetnt = replayconetnt;
	}



	public java.sql.Timestamp getReplaytime() {
		return replaytime;
	}



	public void setReplaytime(java.sql.Timestamp replaytime) {
		this.replaytime = replaytime;
	}



	public Integer getSellerrate() {
		return sellerrate;
	}



	public void setSellerrate(Integer sellerrate) {
		this.sellerrate = sellerrate;
	}



	public Member getMember() {
		return member;
	}



	public void setMember(Member member) {
		this.member = member;
	}



	
	
}
