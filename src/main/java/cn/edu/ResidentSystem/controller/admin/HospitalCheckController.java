package cn.edu.ResidentSystem.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HospitalCheckController {
	@RequestMapping("/hospitalcheck")
	public String hospitalCheck(){
		return "/hospitalcheck/index";
		
	}
}
