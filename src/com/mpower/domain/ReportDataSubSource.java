package com.mpower.domain;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;
import javax.persistence.OneToMany;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mpower.domain.*;

@Entity
public class ReportDataSubSource implements java.io.Serializable {
  /**
	 * 
	 */
@Transient
  protected final Log            logger = LogFactory.getLog(getClass());
	private static final long serialVersionUID = 1L;

@Id
  @GeneratedValue(strategy = GenerationType.AUTO)
      @Column(name = "REPORTSOURCE_ID")
  private long id;
  
  private String                displayName;
  private String                viewName;

  @Enumerated
  private ReportFormatType reportType;
  //  private ReportStandardFilter standardFilter;
  //  private ReportAdvancedFilter advancedFilter;
  //  private Integer rowCount;  

  @OneToMany(cascade = CascadeType.ALL)
  private List<com.mpower.domain.ReportFieldGroup> fieldGroups;
  
  public Long getId() {
      return id;
  }

  public void setId(Long id) {
      this.id = id;
  }
  @Column(name="DISPLAY_NAME")
  public String getDisplayName()
  {
    return displayName;
  }
  
  public void setDisplayName(String displayName)
  {
    this.displayName = displayName;
  }
  
  @Column(name="VIEW_NAME")
  public String getViewName()
  {
    return viewName;
  }
  
  public void setViewName(String viewName)
  {
    this.viewName = viewName;
  }

  public void setFieldGroups(List<ReportFieldGroup> fg)
  {
    logger.info("**** setFieldGroups");
	  fieldGroups = fg;
  }
  
  public List<ReportFieldGroup> getFieldGroups()
  {
    logger.info("**** getFieldGroups");
	  return fieldGroups;
  }
}
