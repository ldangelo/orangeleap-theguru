package com.mpower.util;

import net.sf.jasperreports.engine.fill.JRFileVirtualizer;

public class JRFileVirtualizerFactory {
	private int maxSize;
	private String directory;
	
	public JRFileVirtualizer getJRFileVirtualizer() {
		JRFileVirtualizer virtualizer = new JRFileVirtualizer(maxSize, directory);
		return virtualizer;
	}
	
	public void setMaxSize(int maxSize) {
		this.maxSize = maxSize;
	}
	
	public int getMaxSize() {
		return maxSize;
	}
	
	public void setDirectory(String directory) {
		this.directory = directory;
	}
	
	public String getDirectory() {
		return directory;
	}	
}
