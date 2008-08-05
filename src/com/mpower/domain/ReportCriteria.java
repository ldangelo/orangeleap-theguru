package com.mpower.domain;

import java.util.Set;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportStandardFilter;

@Entity
public class ReportCriteria implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @OneToMany
    Set<ReportStandardFilter> standardFilters;

    @OneToMany
    Set<ReportAdvancedFilter> advancedFilters;
    Integer rowCount;
    Boolean    hideDetails;

}