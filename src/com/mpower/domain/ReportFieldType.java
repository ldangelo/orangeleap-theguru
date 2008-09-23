package com.mpower.domain;

public enum ReportFieldType { NONE, STRING, INTEGER, DOUBLE, DATE, MONEY, BOOLEAN ;
	public Boolean getIsDate() {
		if (this == DATE) return true;
		else return false;
}
}