package com.team5.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.hibernate.sql.Insert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.team5.model.Member;
import com.team5.model.MemberService;
import com.team5.model.Post;
import com.team5.model.PostService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostController {
	@Autowired
	private PostService pService;
	
	@Autowired
	private MemberService mService;
	
	@PostMapping("/post")
	public String postAction(@RequestParam("commentContent") String commentContent,@RequestParam("productimage")  MultipartFile mf,@RequestParam("rate") int rate,
            HttpSession session) throws IllegalStateException, IOException {
		Member loggedInMember = (Member) session.getAttribute("loggedInMember");
		
		Post post =new Post();
		
		if (mf != null && !mf.isEmpty()) { // 檢查圖片是否不為空
			 String fileName = UUID.randomUUID().toString(); // 生成唯一的文件名

			String fileDir = "D:/Action/workspace/TestProject/src/main\\webapp\\WEB-INF\\commentPicture";

			File fileDirPath = new File(fileDir);
			if (!fileDirPath.exists()) {
				fileDirPath.mkdirs();
			}
	        String fileExtension = FilenameUtils.getExtension(mf.getOriginalFilename()); // 獲取文件擴展名
	        String uploadedFileName = fileName + "." + fileExtension; // 構造完整的文件名


			File uploadedFile = new File(fileDirPath, uploadedFileName);
			mf.transferTo(uploadedFile);

			post.setProductphoto("commentPicture/" + uploadedFileName);
		}
		Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String formattedDateTime = sdf.format(currentTimestamp);
		post.setCommentcontent(commentContent);
		post.setBuyerrate(rate);
		post.setCommenttime(currentTimestamp);
		post.setLastmodifiedtime(currentTimestamp);
		post.setMember(loggedInMember);
		pService.insert(post);
		
		return "redirect:indexcomment";
	}
	
	 @GetMapping("/userComments")
	    public String getUserComments(Model model, HttpSession session) {
	        Member loggedInMember = (Member) session.getAttribute("loggedInMember");
	        
	       List<Post> userComments = pService.findByMemberOrderByCommenttimeDesc(loggedInMember);
	        
	        model.addAttribute("post", userComments);
	        
	        return "comment/userComment"; 
	    }
	 
	 @DeleteMapping("/post/{pid}")
	 public ResponseEntity<String> deleteAction(@PathVariable("pid") Integer id) {
	     pService.deleteById(id);
	     return new ResponseEntity<>("評論已成功刪除", HttpStatus.OK);
	 }
	 
	 @PutMapping("/post/{pid}")
	 public ResponseEntity<String> updateAction(@PathVariable("pid") Integer pid,@RequestParam("commentContent") String commentContent) {
		 long currentTimeMillis = System.currentTimeMillis();
			java.sql.Timestamp currTimestamp = new java.sql.Timestamp(currentTimeMillis);
			Post post = new Post(pid,commentContent,currTimestamp);
			pService.Update(post);
		     return new ResponseEntity<>("評論已成功修改", HttpStatus.OK);

	 }
	 
	 @GetMapping("/allUsersComments")
	 public String viewAllUsersComments(Model model) {
	     List<Member> allMembersWithPosts = mService.getAllMembersWithPosts();
	     model.addAttribute("allMembers", allMembersWithPosts);
	     return "comment/allUsersComments";
	 }
	 
	 @PostMapping("/submitReply")
	    public String submitReply(@RequestParam("memberId") Integer memberId, 
	                              @RequestParam("replyContent") String replyContent,
	                              @RequestParam("rate") Integer sellerRate,
	                              @RequestParam("commentId") Integer commentId, 
	                              HttpSession session) {
			Member loggedInMember = (Member) session.getAttribute("loggedInMember");

	        // 保存回复内容
	        Post reply = new Post();
	        reply.setReplayconetnt(replyContent);
	        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String formattedDateTime = sdf.format(currentTimestamp);
	        reply.setReplaytime(currentTimestamp);
	        reply.setSellerrate(sellerRate);
	        reply.setMember(loggedInMember);
	        
	        
	        reply.setRepliedcommentid(commentId);
	        
	       pService.insert(reply);
	       
	        

	        // 更新会员信息
	        Member member = mService.findById(memberId).orElse(null);
	        if (member != null) {
	            // 更新评论次数和累积分数
	            member.setReviewcount(member.getReviewcount() + 1);
	            member.setCumulativescore(member.getCumulativescore() + sellerRate);
	            mService.insertMember(member);
	        }

	        return "redirect:allUsersComments";
	    }
	
}
