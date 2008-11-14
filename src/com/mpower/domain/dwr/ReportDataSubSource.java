package com.mpower.domain.dwr;

import java.lang.String;

public class ReportDataSubSource {
  private long id;
  private String displayName;

  public ReportDataSubSource(com.mpower.domain.ReportDataSubSource rdss) {
    id = rdss.getId();
    displayName = rdss.getDisplayName();
  }

  public long getId() {
    return id;
  }

  public String getDisplayName() {
    return displayName;
  }

}