package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	
	@Column(name = "FIELD_ID_X")
	private long fieldIdx;
	
	@Column(name = "FIELD_ID_Y")
	private long fieldIdy;
	
	@Column(name = "OPERATION")
	private String operation;
	
	@Column(name = "LOCATION")
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

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}
}
