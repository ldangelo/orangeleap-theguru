package com.mpower.domain;

import java.lang.Boolean;
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
import javax.persistence.Enumerated;

import com.mpower.domain.ReportFieldGroup;

@Entity
public class ReportField implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private long id;

  

 // private ReportFieldGroup group;
  private String displayName;
  private String columnName;
 
  @Enumerated
  private ReportFieldType type;
  private Boolean   isDefault;
  private Boolean   canBeSummarized;
  private Boolean   isSummarized;
  
  public long getId() {
    return id;
  }

  public Boolean getIsSummarized() {
    return isSummarized;
  }

  public void setIsSummarized(Boolean isSummarized) {
    this.isSummarized = isSummarized;
  }

public void setDisplayName(String name)
  {
	  displayName = name;
  }

  public String getDisplayName()
  {
	 return displayName; 
  }
  
  public void setColumnName(String cName)
  {
	  columnName = cName;
  }
  
  public String getColumnName()
  {
	  return columnName;
  }
  
  public void setFieldType(ReportFieldType t)
  {
	  type = t;
  }
  
  public ReportFieldType getFieldType()
  {
	  return type;
  }
  
  public void setIsDefault(Boolean d)
  {
	  isDefault = d;
  }
  
  public Boolean getIsDefault()
  {
	  return isDefault;
  }
  
  public void setCanBeSummarized(Boolean cbs)
  {
	  canBeSummarized = cbs;
  }
  
  public Boolean getCanBeSummarized()
  {
	  return canBeSummarized;
  }
  
}