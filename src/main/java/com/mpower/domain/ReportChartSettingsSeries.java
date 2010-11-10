package com.mpower.domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

@Entity
@Table(name = "REPORTCHARTSETTINGSSERIES")
public class ReportChartSettingsSeries implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714845278538209085L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REPORTCHARTSETTINGS_SERIES_ID")
	private long id;
	
	@Column(name = "SERIES")
	private long series;
	
	@Column(name = "SERIES_LABEL")
	private String seriesLabel;
	
	@Column(name = "OPERATION")
	private String operation;
		
	@Transient
	private AbstractColumn seriesColumn;
	
	public long getSeries() {
		return series;
	}

	public void setSeries(long value) {
		this.series = value;
	}
	
	public String getOperation() {
		return operation;
	}

	public void setOperation(String value) {
		this.operation = value;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setSeriesColumn(AbstractColumn seriesColumn) {
		this.seriesColumn = seriesColumn;
	}
	

	public AbstractColumn getSeriesColumn() {
		return seriesColumn;
	}

	public void setSeriesLabel(String seriesLabel) {
		this.seriesLabel = seriesLabel;
	}

	public String getSeriesLabel() {
		return seriesLabel;
	}

}
