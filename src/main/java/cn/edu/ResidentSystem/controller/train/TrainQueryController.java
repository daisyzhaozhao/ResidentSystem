package cn.edu.ResidentSystem.controller.train;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TrainQueryController {
	@RequestMapping("/trainquery")
	public String trainQuery(){
		return "/trainquery/index";
		
	}
}
