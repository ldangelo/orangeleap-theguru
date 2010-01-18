package com.mpower.domain;

public enum ReportFieldType { NONE, STRING, INTEGER, DOUBLE, DATE, MONEY, BOOLEAN, PICKLIST;
	public Boolean getIsDate() {
		if (this == DATE) return true;
		else return false;
	}
	
	public Boolean getIsPicklist() {
		if (this == PICKLIST) return true;
		else return false;
	}
}