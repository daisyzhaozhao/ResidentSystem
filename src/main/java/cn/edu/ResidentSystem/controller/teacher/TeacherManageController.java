package cn.edu.ResidentSystem.controller.teacher;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TeacherManageController {
	@RequestMapping("/teachermanage")
	public String teacherManage(){
		
		return "/teacher/index";
		
	}
}
