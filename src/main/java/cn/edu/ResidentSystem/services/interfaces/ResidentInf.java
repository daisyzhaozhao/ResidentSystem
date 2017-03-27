package cn.edu.ResidentSystem.services.interfaces;

import java.io.InputStream;

import cn.edu.ResidentSystem.model.Msg;

public interface ResidentInf {
	Msg importExcel(InputStream in) throws RuntimeException, Exception;
}
