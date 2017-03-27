package cn.edu.ResidentSystem.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.edu.ResidentSystem.model.Login;
import cn.edu.ResidentSystem.services.impl.LoginService;

@Controller
public class AdminController {
	@Autowired
	public LoginService loginServer;
	@RequestMapping(value="/adminlogin",method=RequestMethod.GET)
	public String adminlogin(){
		return "/admin/adminlogin";
	}
	@RequestMapping(value="/adminlogindo",method=RequestMethod.GET)
	public String adminlogin2(){
		return "/admin/adminlogin";
	}
	@RequestMapping(value="/adminlogindo",method=RequestMethod.POST)
	public String adminlogindo(Login admin,HttpSession session,Model model){
		if(loginServer.select(admin.getAdminname()).getAdminpass().equals(admin.getAdminpass())){
			session.setAttribute("admin",loginServer.select(admin.getAdminname()));
			return "redirect:/adminMeau";
		}else{
			model.addAttribute("msg", "用户名密码错误，请稍后再试！");
			return "forward:WEB-INF/views/admin/adminlogin.jsp";
		}
	}
	@RequestMapping(value="/adminMeau",method=RequestMethod.GET)
	public String adminMeau(){
		
		return "/meau/meau";
		
	}
}
