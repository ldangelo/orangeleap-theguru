package com.mpower.domain;

public class ReportChartSettings implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714845278538209085L;

	private String chartType;
	
	private long xAxisFieldId;
	
	private long yAxisFieldId;
	
	private String chartOperation;
	
	
	public String getChartType() {
		return chartType;
	}

	public void setChartType(String chartType) {
		this.chartType = chartType;
	}
	
	public long getXAxisFieldId() {
		return xAxisFieldId;
	}

	public void setXAxisFieldId(long xAxisFieldId) {
		this.xAxisFieldId = xAxisFieldId;
	}
	
	public long getYAxisFieldId() {
		return yAxisFieldId;
	}

	public void setYAxisFieldId(long yAxisFieldId) {
		this.yAxisFieldId = yAxisFieldId;
	}
	
	public String getchartOperation() {
		return chartOperation;
	}

	public void setchartOperation(String chartOperation) {
		this.chartOperation = chartOperation;
	}
	
	

}
