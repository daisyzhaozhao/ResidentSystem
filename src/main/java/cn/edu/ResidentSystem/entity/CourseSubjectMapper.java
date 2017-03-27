package cn.edu.ResidentSystem.entity;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.ResidentSystem.model.CourseSubject;
import cn.edu.ResidentSystem.model.Office;


public interface CourseSubjectMapper {

	public List<CourseSubject> querySecondNodes(@Param("query") CourseSubject model);
	public CourseSubject getSubjectByName(@Param("name")String subjectName);
	public List<Office> querySecretaryOffice(@Param("office")Office office);
}
