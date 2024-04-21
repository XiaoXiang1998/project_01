package com.team5.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team5.model.Member;
import com.team5.model.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginCommentController {
	 @Autowired
	    private MemberService memberService;

	    @GetMapping("/login")
	    public String showLoginForm() {
	        return "comment/logintest";
	    }
	    
	  
	    
	    
	    @PostMapping("/login")
	    public String processLoginForm(@RequestParam("username") String username,
	                                   @RequestParam("pwd") String password,
	                                   Model model,
	                                   RedirectAttributes redirectAttributes,
	                                   HttpSession session) {
	        Optional<Member> optionalMember = memberService.findByAccountAndPassword(username, password);
	        if (optionalMember.isPresent()) {
	            // 登入成功
	            Member loggedInMember = optionalMember.get();
	            session.setAttribute("loggedInMember", loggedInMember);
	            model.addAttribute("loggedInMember", loggedInMember); 
	            return "comment/indexcomment";
	        } else {
	            // 登入失敗
	            redirectAttributes.addFlashAttribute("error", "帳號或密碼錯誤");
	            return "redirect:/login";
	        }
	    }

	    @GetMapping("/logout")
	    public String logout(SessionStatus sessionStatus, HttpSession session) {
	        session.removeAttribute("loggedInMember");
	        sessionStatus.setComplete();
	        return "redirect:/login";
	    }
}
