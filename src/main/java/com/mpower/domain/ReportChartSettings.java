package com.mpower.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;
import org.hibernate.annotations.IndexColumn;

import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

@Entity
@Table(name = "REPORTCHARTSETTINGS")
public class ReportChartSettings implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714845278538209085L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTCHARTSETTINGS_ID")
	private long id;
	
	@Column(name = "CHART_TYPE")	
	private String chartType;
	
	@Column(name = "CHART_TITLE")	
	private String chartTitle;
	
	@Column(name = "CHART_SUB_TITLE")	
	private String chartSubTitle;
	
	@Column(name = "FIELD_ID_X")
	private long fieldIdx;
	
	@Column(name = "CATEGORY_AXIS_LABEL")
	private String categoryAxisLabel;
	
	@Column(name = "VALUE_AXIS_LABEL")
	private String valueAxisLabel;
	
	@Column(name = "LOCATION")
	private String location;
	
	@Transient
	private AbstractColumn category;

	@OneToMany(cascade = CascadeType.ALL)
	@IndexColumn(name="REPORTCHARTSETTINGS_SERIES_ID")
	private List<ReportChartSettingsSeries> reportChartSettingsSeries;
	
	public ReportChartSettings (){
		reportChartSettingsSeries = LazyList.decorate(new ArrayList<ReportChartSettingsSeries>(),FactoryUtils.instantiateFactory(ReportChartSettingsSeries.class));
	}
	
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

	public void setLocation(String location) {
		this.location = location;
	}

	public String getLocation() {
		return location;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setCategory(AbstractColumn category) {
		this.category = category;
	}

	public AbstractColumn getCategory() {
		return category;
	}

	public void setReportChartSettingsSeries(
			List<ReportChartSettingsSeries> reportChartSettingsSeries) {
		this.reportChartSettingsSeries = reportChartSettingsSeries;
	}

	public List<ReportChartSettingsSeries> getReportChartSettingsSeries() {
		return reportChartSettingsSeries;
	}

	public void setChartTitle(String chartTitle) {
		this.chartTitle = chartTitle;
	}

	public String getChartTitle() {
		return chartTitle;
	}

	public void setCategoryAxisLabel(String categoryAxisLabel) {
		this.categoryAxisLabel = categoryAxisLabel;
	}

	public String getCategoryAxisLabel() {
		return categoryAxisLabel;
	}

	public void setValueAxisLabel(String valueAxisLabel) {
		this.valueAxisLabel = valueAxisLabel;
	}

	public String getValueAxisLabel() {
		return valueAxisLabel;
	}

	public void setChartSubTitle(String chartSubTitle) {
		this.chartSubTitle = chartSubTitle;
	}

	public String getChartSubTitle() {
		return chartSubTitle;
	}


}
