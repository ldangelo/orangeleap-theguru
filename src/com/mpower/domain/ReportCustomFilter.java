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

	private String displayHtml;
	
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

	public void setDisplayHtml(String displayHtml) {
		this.displayHtml = displayHtml;
	}

	public String getDisplayHtml() {
		String result = displayHtml;
		result = result.replace("\"", "&quot;");
		result = result.replace(">", "&gt;");
		result = result.replace("<", "&lt;");
		return result;
	}
	
	public String getPopulatedDisplayHtml() {
		String result = displayHtml;
		if (result != null && result.length() != 0) {
			int criteriaSize = getReportCustomFilterCriteria().size();
			for (int index = 0; index < criteriaSize; index++) {
				result = result.replace("{" + Integer.toString(index) + "}", getReportCustomFilterCriteria().get(index));
			}
		}
		return result;
	}
}
