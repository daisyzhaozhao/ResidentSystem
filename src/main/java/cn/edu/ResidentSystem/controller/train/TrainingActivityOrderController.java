package cn.edu.ResidentSystem.controller.train;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TrainingActivityOrderController {
	@RequestMapping("/trainorder")
	public String trainingActivity(){
		return "/trainorder/index";
		
	}
}
