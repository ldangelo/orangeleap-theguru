package com.mpower.service;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import com.mpower.domain.ReportDataSubSource;
import com.mpower.service.DWRReportSubSourceService;

public class DWRReportSubSourceServiceImpl implements DWRReportSubSourceService {

  //
  // injected by spring
  private ReportSubSourceService reportSubSource;

  public List<com.mpower.domain.dwr.ReportDataSubSource> readSubSourcesByReportSourceId(Long l) {
    List<ReportDataSubSource> lrdss = reportSubSource.readSubSourcesByReportSourceId(l);
    ArrayList<com.mpower.domain.dwr.ReportDataSubSource> dwrList = new ArrayList<com.mpower.domain.dwr.ReportDataSubSource>();

    for (Iterator it = lrdss.iterator(); it.hasNext();) {
      ReportDataSubSource rdss = (ReportDataSubSource) it.next();
      dwrList.add(new com.mpower.domain.dwr.ReportDataSubSource(rdss));
    }
    return dwrList;
  }

  public void setReportSubSource(ReportSubSourceService serv)
  {
    reportSubSource = serv;
  }
}