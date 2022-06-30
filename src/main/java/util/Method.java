package util;

public class Method {
	public static String math(int num) {
		StringBuffer sb=new StringBuffer();
		sb.append(num);
		for(int i=sb.length()-3;i>0;i-=3)sb.insert(i,",");
		
		return sb.toString();
	}

}
