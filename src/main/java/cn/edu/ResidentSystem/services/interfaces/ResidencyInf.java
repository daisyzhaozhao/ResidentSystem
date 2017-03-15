package cn.edu.ResidentSystem.services.interfaces;

import java.io.File;
import java.io.InputStream;

import cn.edu.ResidentSystem.model.Msg;

public interface ResidencyInf {
	Msg importExcel(InputStream in) throws RuntimeException, Exception;
}
