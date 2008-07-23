package com.mpower.domain;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mpower.domain.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@Entity
public class ReportDataSource implements java.io.Serializable {
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

@Id
  @GeneratedValue(strategy = GenerationType.AUTO)
      @Column(name = "REPORTSOURCE_ID")
  private long id;
  
  private String                Name;


  @OneToMany(cascade = CascadeType.ALL)
  private List<com.mpower.domain.ReportDataSubSource> subSource;
  @Transient
  protected final Log logger = LogFactory.getLog(getClass());
  
  public Long getId() {
      return id;
  }

  public void setId(Long id) {
      this.id = id;
  }
  @Column(name="DISPLAY_NAME")
  public String getName()
  {
    return Name;
  }
  
  public void setName(String displayName)
  {
    Name = displayName;
  }
  
  public void setSubSources(List<ReportDataSubSource> ss)
  {
	  subSource = ss;
  }
  
  public List<ReportDataSubSource> getSubSources()
  {
	  logger.info("**** getSubSources");
	  
	  return subSource;
  }
}
