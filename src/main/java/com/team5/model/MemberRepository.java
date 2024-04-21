package com.team5.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface MemberRepository extends JpaRepository<Member, Integer> {
	 // 根據帳號和密碼查找成員
    Optional<Member> findByAccountAndPassword(String account, String password);
 // 查询所有用户以及每个用户的评论数据
    @Query("SELECT m FROM Member m JOIN FETCH m.posts")
    List<Member> findAllWithPosts();
}
