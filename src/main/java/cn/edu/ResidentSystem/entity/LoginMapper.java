package cn.edu.ResidentSystem.entity;

import cn.edu.ResidentSystem.model.Login;

public interface LoginMapper {
  Login selectByLoginName(String adminname);
}
