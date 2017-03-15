package cn.edu.ResidentSystem.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.lang.annotation.RetentionPolicy; 
import java.lang.annotation.ElementType;

import cn.edu.ResidentSystem.others.LogOperation;

@Target({ElementType.METHOD})  
@Documented  
@Retention(RetentionPolicy.RUNTIME) 
public @interface OptLog {
	public String operation() default LogOperation.ADD;  
    
    public LogOperation operationModule() default LogOperation.TRAIN;  
     
    public String ext() default ""; 
}
