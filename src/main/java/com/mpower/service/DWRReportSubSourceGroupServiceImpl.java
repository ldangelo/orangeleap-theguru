package com.mpower.service;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import com.mpower.domain.ReportDataSubSourceGroup;
import com.mpower.service.DWRReportSubSourceGroupService;

public class DWRReportSubSourceGroupServiceImpl implements DWRReportSubSourceGroupService {

  //
  // injected by spring
  private ReportSubSourceGroupService reportSubSourceGroup;

  public List<com.mpower.domain.dwr.ReportDataSubSourceGroup> readSubSourceGroupsByReportSourceId(Long l) {
    List<ReportDataSubSourceGroup> lrdss = reportSubSourceGroup.readSubSourceGroupsByReportSourceId(l);
    ArrayList<com.mpower.domain.dwr.ReportDataSubSourceGroup> dwrList = new ArrayList<com.mpower.domain.dwr.ReportDataSubSourceGroup>();

    for (Iterator it = lrdss.iterator(); it.hasNext();) {
      ReportDataSubSourceGroup rdss = (ReportDataSubSourceGroup) it.next();
      dwrList.add(new com.mpower.domain.dwr.ReportDataSubSourceGroup(rdss));
    }
    return dwrList;
  }

  public void setReportSubSourceGroup(ReportSubSourceGroupService serv)
  {
    reportSubSourceGroup = serv;
  }
}