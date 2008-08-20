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

//    Set<ReportStandardView> views;
}