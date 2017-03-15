package cn.edu.ResidentSystem.controller.train;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TrainTypeController {
	@RequestMapping("/traintype")
	public String trainType(){
		return "/traintype/index";
		
	}
}
