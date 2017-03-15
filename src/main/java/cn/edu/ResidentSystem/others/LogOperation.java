package cn.edu.ResidentSystem.others;

public enum LogOperation {
	TRAIN("TRAIN", "规培系统"),AUTH("AUTH","授权系统");

	public static final String LOGIN = "LOGIN";
	
	public static final String QUIT = "QUIT";
	
	public static final String SAVE = "SAVE";
	public static final String EXT_SAVE = "保存";
	
	public static final String AUDIT = "AUDIT";
	public static final String EXT_AUDIT = "审核";
	
	public static final String IMPORT_FILE = "IMPORT_FILE";
	public static final String EXT_IMPORT_FILE = "文件导入";
	
	public static final String ADD = "ADD";

	public static final String GET = "GET";

	public static final String MODIFY = "MODIFY";
	public static final String EXT_MODIFY = "修改";

	public static final String ADD_DIR = "ADD_DIR";

	public static final String REMOVE = "REMOVE";
	public static final String EXT_REMOVE = "删除";

	public static final String REMOVE_DIR = "REMOVE_DIR";

	public String name;

	public String code;

	LogOperation(String code, String name) {
		this.name = name;
		this.code = code;
	}
}
