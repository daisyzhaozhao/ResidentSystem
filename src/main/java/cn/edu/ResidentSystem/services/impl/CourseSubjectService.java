package cn.edu.ResidentSystem.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.ResidentSystem.entity.CourseSubjectMapper;
import cn.edu.ResidentSystem.model.CourseSubject;
import cn.edu.ResidentSystem.model.Office;
import cn.edu.ResidentSystem.services.interfaces.CourseSubjectInf;

@Service
public class CourseSubjectService implements CourseSubjectInf{

	@Autowired
	private CourseSubjectMapper courseSubjectMapper;
	
	public List<CourseSubject> querySecondNodes(CourseSubject query){

		List<CourseSubject> list = courseSubjectMapper.querySecondNodes(query);
		return list;
	}

	@Override
	public CourseSubject getSubjectByName(String subjectName) {
		// TODO Auto-generated method stub
		CourseSubject courseSubject = courseSubjectMapper.getSubjectByName(subjectName);
		return courseSubject;
	}

	@Override
	public List<Office> querySecretaryOffice(Office office) {
		// TODO Auto-generated method stub
		return courseSubjectMapper.querySecretaryOffice(office);
	}
}
