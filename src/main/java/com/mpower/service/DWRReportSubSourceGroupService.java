package com.mpower.service;

import java.util.List;

import com.mpower.service.ReportSubSourceGroupService;

public interface DWRReportSubSourceGroupService {
  List<com.mpower.domain.dwr.ReportDataSubSourceGroup> readSubSourceGroupsByReportSourceId(Long l);

  void setReportSubSourceGroup(ReportSubSourceGroupService serv);
}