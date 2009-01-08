package com.mpower.domain;

public class ReportChartSettings implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714845278538209085L;

	private String chartType;
	
	private long fieldIdx;
	
	private long fieldIdy;
	
	private String operation;
	
	private String location;
	
	public String getChartType() {
		return chartType;
	}

	public void setChartType(String value) {
		this.chartType = value;
	}
	
	public long getFieldIdx() {
		return fieldIdx;
	}

	public void setFieldIdx(long value) {
		this.fieldIdx = value;
	}
	
	public long getFieldIdy() {
		return fieldIdy;
	}

	public void setFieldIdy(long value) {
		this.fieldIdy = value;
	}
	
	public String getOperation() {
		return operation;
	}

	public void setOperation(String value) {
		this.operation = value;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getLocation() {
		return location;
	}
}
