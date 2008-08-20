package com.mpower.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.mpower.domain.ReportDuration;
import com.mpower.domain.ReportField;


@Entity
@Table(name = "REPORTSTANDARDVIEW")
public class ReportStandardView implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "REPORTSTANDARDVIEW_ID")
    private long id;

    @Column(name = "NAME")
    String                 name;
    @OneToMany
    @Column(name = "COLUMNS")
    Set<ReportField> columns;

    @OneToMany
    @Column(name = "DURATION")
    Set<ReportDuration> duration;

}