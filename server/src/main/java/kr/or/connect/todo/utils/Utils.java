package kr.or.connect.todo.utils;

public class Utils {
	public static String simpleFilter(String todo){
		todo = todo.replaceAll("<", "&lt;");
		todo = todo.replaceAll(">", "&gt;");
		return todo;
	}
}
