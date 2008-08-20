

package com.mpower.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "REPORTADVANCEDFILTER")
public class ReportAdvancedFilter implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Column(name = "REPORTADVANCEDFILTER_ID")
  private long id;
  
  @Column(name = "REPORT_FIELD")
  ReportField field;

  @Enumerated
  @Column(name = "FILTER_OPERATOR")
  FilterOperator operator;
  String value;
  
  public ReportAdvancedFilter() {
    field = null;
    value = "";
    operator = FilterOperator.NONE;
  }
}