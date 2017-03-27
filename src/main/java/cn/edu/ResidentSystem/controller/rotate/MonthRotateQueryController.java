package cn.edu.ResidentSystem.controller.rotate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MonthRotateQueryController {
	@RequestMapping("/monthrotatequery")
	public String monthRotateQuery(){
		return "/monthrotatequery/index";
		
	}
	
	
}


