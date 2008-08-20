package com.mpower.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportStandardFilter;

@Entity
@Table(name = "REPORTCRITERIA")
public class ReportCriteria implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @OneToMany
    Set<ReportStandardFilter> standardFilters;

    @OneToMany
    Set<ReportAdvancedFilter> advancedFilters;
    
    @Column(name = "ROW_COUNT")
    Integer rowCount;
    
    @Column(name = "HIDE_DETAILS")
    Boolean    hideDetails;

}