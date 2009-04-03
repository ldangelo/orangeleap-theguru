package com.mpower.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;
import org.hibernate.annotations.IndexColumn;

@Entity
@Table(name = "REPORTCUSTOMFILTER")
public class ReportCustomFilter implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 839774897397732586L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTCUSTOMFILTER_ID")
	private long customFilterId;
	
	@Column(name = "REPORTCUSTOMFILTERDEFINITION_ID")
	private long customFilterDefinitionId;

	@OneToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTCUSTOMFILTERCRITERIA_ID")
	private List<ReportCustomFilterCriteria> reportCustomFilterCriteria;

	@Column(name = "DISPLAY_HTML", length=8000)	
	private String displayHtml;
	
	public ReportCustomFilter() {
		reportCustomFilterCriteria = LazyList.decorate(new ArrayList<ReportCustomFilterCriteria>(),FactoryUtils.instantiateFactory(ReportCustomFilterCriteria.class));
	}
	
	public void setReportCustomFilterCriteria(
			List<ReportCustomFilterCriteria> reportCustomFilterCriteria) {
		this.reportCustomFilterCriteria = reportCustomFilterCriteria;
	}

	public List<ReportCustomFilterCriteria> getReportCustomFilterCriteria() {
		return reportCustomFilterCriteria;
	}

	public void setCustomFilterId(long customFilterId) {
		this.customFilterId = customFilterId;
	}

	public long getCustomFilterId() {
		return customFilterId;
	}

	public void setDisplayHtml(String displayHtml) {
		if (displayHtml != null) {
			displayHtml = displayHtml.replace("&quot;", "\"");
			displayHtml = displayHtml.replace("&gt;", ">");
			displayHtml = displayHtml.replace("&lt;", "<");
		}		
		this.displayHtml = displayHtml;
		
	}

	public String getDisplayHtml() {
		String result = displayHtml;
		if (result != null) {
			result = result.replace("\"", "&quot;");
			result = result.replace(">", "&gt;");
			result = result.replace("<", "&lt;");
		}
		return result;
	}
	
	public String getPopulatedDisplayHtml() {
		String result = displayHtml;
		if (result != null && result.length() != 0 && getReportCustomFilterCriteria() != null) {
			int criteriaSize = getReportCustomFilterCriteria().size();
			for (int index = 0; index < criteriaSize; index++) {
				result = result.replace("{" + Integer.toString(index) + "}", getReportCustomFilterCriteria().get(index).getCriteria());
			}
		}
		return result;
	}

	public void setCustomFilterDefinitionId(long customFilterDefinitionId) {
		this.customFilterDefinitionId = customFilterDefinitionId;
	}

	public long getCustomFilterDefinitionId() {
		return customFilterDefinitionId;
	}
}
