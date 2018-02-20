package util;

import java.util.regex.Pattern;

public class VerifyInput {
	public static String basicVerification(String id_stu, String name, String age) {
		if (!isValidId(id_stu)) {
			return "学号必须为1~20位整数！";
		} else if (!isValidName(name)) {
			return "姓名必须为2~10个字符！";
		} else if (!isValidAge(age)) {
			return "年龄必须为1~99之间的整数！";
		}
		return "";
	}

	public static boolean isValidId(String id_stu) {
		return Pattern.compile("[0-9]{1,20}").matcher(id_stu).matches();
	}
	
	public static boolean isValidName(String name) {
		return name.length()>1 && name.length()<10;
	}	

	public static boolean isValidAge(String age) {
		return Pattern.compile("[1-9]?[0-9]").matcher(age).matches();
	}	
	
	public static boolean isValidCourse(String course) {
		return Pattern.compile("^([\\u4E00-\\u9FA5]+$|^[A-Za-z]+)[0-9]*$").matcher(course).matches();
	}	
	
	public static boolean isValidScore(String score) {
		return Pattern.compile("([1-9]?[0-9]|1[0-4][0-9])(\\.[0-9])?|150").matcher(score).matches();
	}	
}
