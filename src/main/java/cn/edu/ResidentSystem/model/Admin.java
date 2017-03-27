package cn.edu.ResidentSystem.model;

public class Admin {
	//学员编号
    private Integer adminno;
    //
    private int id;
    //年级
    private String grade;
    //姓名
    private String name;
    //学员状态
    private String studentState;
    //培训状态
    private String trainState;
    //性别
    private String sex;
    //学历
    private String education;
    //导师
    private String teacher;
    //在陪学科
	private String major;
    //所属单位
    private String company;
    //所属科室
    private String office;
    //手机
	private String phoneNum;
    //银行账号
    private String bankNum;
    //身份证
    private String idCard;
    //毕业院校
	private String graduateInstitutions;
    //最高学位
    private String maxGraduate;
    //职称
    private String technical;
    //医师资格
    private String doctorQulification;
    //执业资格
    private String practicing;
    //专业
    private String career;
    //身份类别
    private String identity;
    //是否执业医师
    private String yorndoctor;
    //培训年限
    private String trainyear;
   
    
    private int login_id;

    public int getLogin_id() {
		return login_id;
	}

	public void setLogin_id(int login_id) {
		this.login_id = login_id;
	}

	public String getTrainyear() {
		return trainyear;
	}

	public void setTrainyear(String trainyear) {
		this.trainyear = trainyear;
	}

	public String getYorndoctor() {
		return yorndoctor;
	}

	public void setYorndoctor(String yorndoctor) {
		this.yorndoctor = yorndoctor;
	}

	public String getIdentity() {
		return identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStudentState() {
		return studentState;
	}

	public void setStudentState(String studentState) {
		this.studentState = studentState;
	}

	public String getTrainState() {
		return trainState;
	}

	public void setTrainState(String trainState) {
		this.trainState = trainState;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}
	
	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	
	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}
	
	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getBankNum() {
		return bankNum;
	}

	public void setBankNum(String bankNum) {
		this.bankNum = bankNum;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
	public String getGraduateInstitutions() {
		return graduateInstitutions;
	}

	public void setGraduateInstitutions(String graduateInstitutions) {
		this.graduateInstitutions = graduateInstitutions;
	}

	public String getMaxGraduate() {
		return maxGraduate;
	}

	public void setMaxGraduate(String maxGraduate) {
		this.maxGraduate = maxGraduate;
	}

	public String getTechnical() {
		return technical;
	}

	public void setTechnical(String technical) {
		this.technical = technical;
	}

	public String getDoctorQulification() {
		return doctorQulification;
	}

	public void setDoctorQulification(String doctorQulification) {
		this.doctorQulification = doctorQulification;
	}

	public String getPracticing() {
		return practicing;
	}

	public void setPracticing(String practicing) {
		this.practicing = practicing;
	}

	public String getCareer() {
		return career;
	}

	public void setCareer(String career) {
		this.career = career;
	}

	public Integer getAdminno() {
        return adminno;
    }

    public void setAdminno(Integer adminno) {
        this.adminno = adminno;
    }

   
}