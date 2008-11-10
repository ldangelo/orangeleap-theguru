package com.mpower.domain;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;

public class ReportCustomFilter implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 839774897397732586L;

	private long customFilterId;
	
	private List<String> reportCustomFilterCriteria;

	public ReportCustomFilter() {
		reportCustomFilterCriteria = LazyList.decorate(new ArrayList<String>(),FactoryUtils.instantiateFactory(String.class));	
	}
	
	public void setReportCustomFilterCriteria(
			List<String> reportCustomFilterCriteria) {
		this.reportCustomFilterCriteria = reportCustomFilterCriteria;
	}

	public List<String> getReportCustomFilterCriteria() {
		return reportCustomFilterCriteria;
	}

	public void setCustomFilterId(long customFilterId) {
		this.customFilterId = customFilterId;
	}

	public long getCustomFilterId() {
		return customFilterId;
	}	
}
