package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.mpower.domain.ReportStandardFilter;

@Entity
@Table(name = "REPORTSTANDARDFILTER")
public class ReportStandardFilter implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "REPORTSTANDARDFILTER_ID")
    private long id;

	@Column(name = "REPORTFIELD_ID")
    Long        fieldId;
	
	@Column(name = "DURATION")
	int 		duration;
//    Set<ReportStandardView> views;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getFieldId() {
		return fieldId;
	}

	public void setFieldId(Long fieldId) {
		this.fieldId = fieldId;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}
}