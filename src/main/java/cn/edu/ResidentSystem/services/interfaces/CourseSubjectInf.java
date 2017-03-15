package cn.edu.ResidentSystem.services.interfaces;

import java.util.List;

import cn.edu.ResidentSystem.model.CourseSubject;

public interface CourseSubjectInf {
	public List<CourseSubject> querySecondNodes(CourseSubject query);
}
