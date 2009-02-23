package com.mpower.domain;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;


public class ReportCrossTabFields implements java.io.Serializable {
	
	public ReportCrossTabFields() {
		//this.reportCrossTabMeasure = -1;
		this.reportCrossTabOperation = new String();
		reportCrossTabMeasure = LazyList.decorate(new ArrayList<ReportGroupByField>(),FactoryUtils.instantiateFactory(ReportGroupByField.class));
		reportCrossTabRows = LazyList.decorate(new ArrayList<ReportGroupByField>(),FactoryUtils.instantiateFactory(ReportGroupByField.class));
		reportCrossTabColumns = LazyList.decorate(new ArrayList<ReportGroupByField>(),FactoryUtils.instantiateFactory(ReportGroupByField.class));
	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714845278538209085L;

	//private long reportCrossTabMeasure;
	
	private String reportCrossTabOperation;
	
	private List<ReportGroupByField> reportCrossTabMeasure;
	
	private List<ReportGroupByField> reportCrossTabRows;
	
	private List<ReportGroupByField> reportCrossTabColumns;
	
/*
	public long getReportCrossTabMeasure() {
		return reportCrossTabMeasure;
	}

	public void setReportCrossTabMeasure(long value) {
		this.reportCrossTabMeasure = value;
	}
*/
	public List<ReportGroupByField> getReportCrossTabMeasure() {
		return reportCrossTabMeasure; 
	}

	public void setReportCrossTabMeasure(List<ReportGroupByField> value) {
		this.reportCrossTabMeasure = value;
	}
	
	public String getReportCrossTabOperation() {
		return reportCrossTabOperation;
	}

	public void setReportCrossTabOperation(String value) {
		this.reportCrossTabOperation = value;
	}
	
	public List<ReportGroupByField> getReportCrossTabRows() {
		return reportCrossTabRows;
	}

	public void setReportCrossTabRows(List<ReportGroupByField> value) {
		this.reportCrossTabRows = value;
	}
	
	public List<ReportGroupByField> getReportCrossTabColumns() {
		return reportCrossTabColumns;
	}

	public void setReportCrossTabColumns(List<ReportGroupByField> value) {
		this.reportCrossTabColumns = value;
	}
	
	
}
