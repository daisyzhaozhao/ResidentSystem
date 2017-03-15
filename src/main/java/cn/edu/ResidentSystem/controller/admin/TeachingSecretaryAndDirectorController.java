package cn.edu.ResidentSystem.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TeachingSecretaryAndDirectorController {
	@RequestMapping("/teachingsecretary")
	public String teachingSecretaryAndDirector(){
		
		return "/teaching/index";
		
	}
}
