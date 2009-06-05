package com.mpower.controller;

import java.io.File;
import java.io.IOException;

public class TempFileUtil {
	
	private static String TEMP_DIR = System.getProperty("theguru.temp.file.dir");
	private static String JAVA_IO_TEMP_DIR = System.getProperty("java.io.tmpdir");
	
	public static File createTempFile(String prefix, String suffix) {
		
		String n = "" + (int)Math.floor(Math.random() * 10000000.0d);
	    n = n.substring(n.indexOf('.')+1);
		return new File(TEMP_DIR == null ?  JAVA_IO_TEMP_DIR : TEMP_DIR, prefix + n + suffix); 
		
	}
	
	public static void main(String[] args) {
		File f = createTempFile("a", ".txt");
		try {
			f.createNewFile();
			System.out.println(f.getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
