package cn.edu.ResidentSystem.controller.person;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import cn.edu.ResidentSystem.model.PageBean;
import cn.edu.ResidentSystem.services.impl.PersonService;

@Controller
public class SearchPersonController {
	@Autowired
	public PersonService personService;
	
	@RequestMapping("/searchperson")
	public String searchPerson(){
		
		return "/person/index";
		
	}
	
	@RequestMapping("/person/list.do")
	public@ResponseBody String teacherAll(@RequestParam(value="staffName", required=false)String staffName,@RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model){
		
		PageBean  page=null;
		if(pageNumber!=null){
			page=new PageBean();
			page.setCurrPage(pageNumber);
			page.setPageSize(pageSize);	
		}
		
	    Gson gson =new Gson();
	   // int size = personService.countAll(staffName);
		List<String> list = personService.query(staffName,page);
	    String json=gson.toJson(list);
	    if(pageNumber!=null){
		json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() +"}";
	    }
		return json;
		
	}
}
