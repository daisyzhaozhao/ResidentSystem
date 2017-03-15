package cn.edu.ResidentSystem.entity;

import java.util.List;

import cn.edu.ResidentSystem.model.Persistentable;

public interface BaseMapper<T extends Persistentable> {
	List<T> findAll(T model);
}
