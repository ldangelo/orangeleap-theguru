package com.mpower.domain;

import java.util.Set;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportStandardFilter;

@Entity
public class ReportStandardFilter implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

//    Set<ReportStandardView> views;
}