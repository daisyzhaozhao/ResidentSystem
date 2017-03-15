package cn.edu.ResidentSystem.entity;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.edu.ResidentSystem.model.CourseSubject;


public interface CourseSubjectMapper {

	public List<CourseSubject> querySecondNodes(@Param("query") CourseSubject model);
}
