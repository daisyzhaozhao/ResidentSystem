package cn.edu.ResidentSystem.controller.rotate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MonthRotateListController {
	@RequestMapping("/monthrotatelist")
	public String monthRotateList(){
		
		return "/monthrotatelist/index";
		
	}
}
