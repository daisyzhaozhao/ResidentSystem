package cn.edu.ResidentSystem.controller.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import cn.edu.ResidentSystem.model.CourseSubject;
import cn.edu.ResidentSystem.services.impl.CourseSubjectService;

@Controller
public class CourseTypeController {
	
	@Autowired
	private CourseSubjectService courseSubjectService;
	
	@RequestMapping("/coursetype")
	public String courseType(){
		
		return "/coursetype/index";
		
	}
	
	@RequestMapping(value="/secondNode.do", produces={"application/json;charset=utf-8"})
	 @ResponseBody
	 	public String getSecondNode(CourseSubject query, Model model){
		 List<CourseSubject> list = courseSubjectService.querySecondNodes(query);
		 Gson gson = new Gson();
		 String json = gson.toJson(list);
		 System.out.println(json);
		 return json;
	 }

}
