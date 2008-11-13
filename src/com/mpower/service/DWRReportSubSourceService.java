package com.mpower.service;

import java.util.List;

import com.mpower.service.ReportSubSourceService;

public interface DWRReportSubSourceService {
  List<com.mpower.domain.dwr.ReportDataSubSource> readSubSourcesByReportSourceId(Long l);

  void setReportSubSource(ReportSubSourceService serv);
}