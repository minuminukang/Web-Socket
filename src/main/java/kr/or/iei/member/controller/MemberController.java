package kr.or.iei.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("memberService")
	private MemberService service;
	
	public MemberController() {
		System.out.println("생성");
	}

	@RequestMapping(value = "/login.do")
	public String loginMember(HttpSession session, Member m) {
		
		Member member =service.selectOneMember(m);
		if (member != null) {
			session.setAttribute("member", member);
			return "member/loginSuccess";
		} else {
			return "member/loginFailed";
		}
	}
	
	@RequestMapping(value = "logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/error.do")
	public String error() {
		return "common/error";
	}
	
	@ExceptionHandler(RuntimeException.class)
	public String errorHandler() {
		return "redirect:error.do";
	}
	
	@RequestMapping("/goChat.do")
	public String chat() {
		return "member/chat";
	}
	
}
