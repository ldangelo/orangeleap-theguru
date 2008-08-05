package com.mpower.domain;

import java.util.Set;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import com.mpower.domain.ReportDuration;
import com.mpower.domain.ReportField;


@Entity
public class ReportStandardView implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    String                 name;
    @OneToMany
    Set<ReportField> columns;

    @OneToMany
    Set<ReportDuration> duration;

}