package cn.edu.ResidentSystem.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HeadOfTeachingController {
	@RequestMapping("/headofteaching")
	public String headOfTeaching(){
		
		return "/headteaching/index";
		
	}
}
