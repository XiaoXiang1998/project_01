package com.team5.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;


import jakarta.transaction.Transactional;

@Service
@Transactional
public class PostService {
	
	@Autowired
	private PostRepository pRepository;

	public Post insert(Post post) {
		return pRepository.save(post);
	}
	
	public Post Update(Post post) {
	    Optional<Post> existingComment = pRepository.findById(post.getCommentid());
	    if (existingComment.isPresent()) {
	         Post oldComment = existingComment.get();
	        if (post.getCommentcontent() != null) {
	            oldComment.setCommentcontent(post.getCommentcontent());
	        }
	        if(post.getLastmodifiedtime()!=null) {
	        	oldComment.setLastmodifiedtime(post.getLastmodifiedtime());
	        }

	        return pRepository.save(oldComment);
	    } else {
	        // 如果找不到該評論，則可能需要處理此情況
	        // 例如拋出異常或返回null
	        return null;
	    }
	}
	
	public void deleteById(Integer id) {
		pRepository.deleteById(id);
	}
	
	
	public Post getById(Integer id) {
		 Optional<Post> op1 = pRepository.findById(id);
		 if(op1.isPresent()) {
			 return op1.get();
		 }
		 
		 return null;
	}
	public List<Post> getAll(){
		return pRepository.findAll();
	}

	public List<Post> findByMember(Member member) {
		return pRepository.findByMember(member);
	}
	
	
	
	
}
