package com.mpower.service;

import javax.servlet.ServletRequest;

import com.mpower.domain.ReportDataSource;


public interface SessionService {

    public ReportDataSource lookupReportDataSource(ServletRequest request);
}
