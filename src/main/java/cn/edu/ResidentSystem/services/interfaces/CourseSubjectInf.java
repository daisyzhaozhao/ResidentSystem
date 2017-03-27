package cn.edu.ResidentSystem.services.interfaces;

import java.util.List;

import cn.edu.ResidentSystem.model.CourseSubject;
import cn.edu.ResidentSystem.model.Office;

public interface CourseSubjectInf {
	public List<CourseSubject> querySecondNodes(CourseSubject query);
	public CourseSubject getSubjectByName(String subjectName);
	public List<Office> querySecretaryOffice(Office office );
}
