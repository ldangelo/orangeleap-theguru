package com.mpower.domain;

public class WizardStep implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4396516416935021229L;
	private String description;
	private String targetName;
	public WizardStep(String desc, String target) {
		description = desc;
		targetName  = target;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTargetName() {
		return targetName;
	}
	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}
	
}
