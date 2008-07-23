package com.mpower.domain;

import java.lang.Boolean;
import java.util.Set;
import java.util.List;
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

import com.mpower.domain.ReportField;

@Entity
public class ReportFieldGroup implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

  private String Name;
  
  @OneToMany(cascade = CascadeType.ALL)
  private List<ReportField> fields;
  
  public void setName(String n) 
  {
	  Name = n;
  }
  
  public String getName()
  {
	  return Name;
  }
  
  public void setFields(List<ReportField> f)
  {
	  fields = f;
  }

  public List<ReportField> getFields()
  {
	  return fields;
  }
}