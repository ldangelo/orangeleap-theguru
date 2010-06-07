package com.mpower.controller;

import java.io.File;
import java.io.IOException;

public class TempFileUtil {
	
	private static String TEMP_DIR = System.getProperty("theguru.temp.file.dir");
	private static String JAVA_IO_TEMP_DIR = System.getProperty("java.io.tmpdir");
	
    // Puts temp files in a separate directory for the instance
	public static synchronized File createTempFile(String prefix, String suffix) throws IOException {
		
		String dir = TEMP_DIR == null ?  JAVA_IO_TEMP_DIR : TEMP_DIR;
		return File.createTempFile(prefix, suffix, new File(dir)); 
		
	}
	
	
}
