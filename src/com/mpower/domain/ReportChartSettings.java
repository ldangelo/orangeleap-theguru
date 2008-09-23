package com.mpower.domain;

public class ReportChartSettings implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714845278538209085L;

	private String chartType;
	
	private long fieldId;
	
	private String operation;
	
	public String getChartType() {
		return chartType;
	}

	public void setChartType(String value) {
		this.chartType = value;
	}
	
	public long getFieldId() {
		return fieldId;
	}

	public void setFieldId(long value) {
		this.fieldId = value;
	}
	
	public String getOperation() {
		return operation;
	}

	public void setOperation(String value) {
		this.operation = value;
	}
}
