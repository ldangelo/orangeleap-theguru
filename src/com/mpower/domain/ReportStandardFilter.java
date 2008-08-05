package com.mpower.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import com.mpower.domain.ReportStandardFilter;

@Entity
public class ReportStandardFilter implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

//    Set<ReportStandardView> views;
}