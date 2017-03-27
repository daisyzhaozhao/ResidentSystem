package cn.edu.ResidentSystem.controller.rotate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.ResidentSystem.model.Department;
import cn.edu.ResidentSystem.model.RotaryResult;
import cn.edu.ResidentSystem.services.impl.DepartmentService;
import cn.edu.ResidentSystem.services.impl.RotaryService;
import cn.edu.ResidentSystem.util.DateUtil;

@Controller
public class MonthRotateListController {
	@Autowired
	RotaryService rotaryService;
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/monthrotatelist")
	public String monthRotateList(@RequestParam(value = "userType", required = false, defaultValue = "1,2,3,4,8,") String userType,
			RotaryResult query, Model model){

		if (query.getStartDate() == null) {
			String startDate = DateUtil.getCurrentDateStr1();
			query.setStartDate(startDate);
			query.setEndDate(DateUtil.formatDate(DateUtil.addMonth(DateUtil.toDate(startDate), 12)));
		}
		RotaryResult result = rotaryService.getTimeTitle(query);
		List<String> title = result.getTitle();
		//查出所以的部门
		List<Department> departmentList = departmentService.queryDepartment();
		//部门对应的轮转结果
		List<RotaryResult> reults = rotaryService.queryRotary(query);
		
		List<Map<Department, Map<String, List<RotaryResult>>>> list = new ArrayList<>();
		model.addAttribute("title", title);
		model.addAttribute("list", list);
		model.addAttribute("departmentList", departmentList);

		Department dept = new Department();// 上一条科室
		String startDate = null;
		Map<String, List<RotaryResult>> dateMap = null;
		List<RotaryResult> stuList = null;
		Map<Department, Map<String, List<RotaryResult>>> deptMap = null;
		for (int i = 0; i < reults.size(); i++) {
			RotaryResult r = reults.get(i);
			if (!r.getDepartmentId().equals(dept.getId())) {
				dept = new Department();
				dept.setId(r.getDepartmentId());
				dept.setDepartmentName(r.getDepartmentName());

				dateMap = new HashMap<String, List<RotaryResult>>();
				int ms = DateUtil.getMonthSpace(r.getStartDate(), r.getEndDate());
				for (int m = 0; m < ms; m++) {
					stuList = new ArrayList<RotaryResult>();
					stuList.add(r);
					if (StringUtils.isEmpty(r.getStartDate())) {
						System.out.println(r.toString());
					}
					dateMap.put(DateUtil.formatDate(DateUtil.addMonth(DateUtil.toDate2(r.getStartDate()), m)), stuList);
				}

				deptMap = new HashMap<Department, Map<String, List<RotaryResult>>>();
				deptMap.put(dept, dateMap);
				list.add(deptMap);

				startDate = r.getStartDate();
			} else {
				if (r.getStartDate().equals(startDate)) {
					// deptMap.get(dept).get(r.getStartDate()).add(r);
					String datetmp = null;
					int ms = DateUtil.getMonthSpace(r.getStartDate(), r.getEndDate());
					for (int m = 0; m < ms; m++) {
						if (StringUtils.isEmpty(r.getStartDate())) {
							System.out.println(r.toString());
						}
						datetmp = DateUtil.formatDate(DateUtil.addMonth(DateUtil.toDate2(r.getStartDate()), m));
						if (deptMap.get(dept).get(datetmp) != null) {
							deptMap.get(dept).get(datetmp).add(r);
						} else {
							stuList = new ArrayList<RotaryResult>();
							stuList.add(r);

							deptMap.get(dept).put(datetmp, stuList);
						}
					}
				} else {
					/*
					 * stuList = new ArrayList<RotaryResult>(); stuList.add(r);
					 * deptMap.get(dept).put(r.getStartDate(), stuList);
					 */
					String datetmp = null;
					int ms = DateUtil.getMonthSpace(r.getStartDate(), r.getEndDate());
					for (int m = 0; m < ms; m++) {
						datetmp = DateUtil.formatDate(DateUtil.addMonth(DateUtil.toDate2(r.getStartDate()), m));
						if (deptMap.get(dept).get(datetmp) != null) {
							deptMap.get(dept).get(datetmp).add(r);
						} else {
							stuList = new ArrayList<RotaryResult>();
							stuList.add(r);

							deptMap.get(dept).put(datetmp, stuList);
						}
					}

					startDate = r.getStartDate();
				}

			}
		}
		
		return "/monthrotatelist/index";
	}
	
	
}
