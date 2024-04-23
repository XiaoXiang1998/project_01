package com.team5.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class MemberService {
	
	@Autowired
	private MemberRepository mRepository;

	public Optional<Member> findById(Integer id) {
		return mRepository.findById(id);
	}
	
	public Optional<Member> findByAccountAndPassword(String account, String password){
		return mRepository.findByAccountAndPassword(account, password);
	}
	
	// 获取所有用户以及每个用户的评论数据
    public List<Member> getAllMembersWithPosts() {
        return mRepository.findAllWithPosts();
    }

	public Member insertMember (Member member) {
		return mRepository.save(member);
	}
	
    
    
}
