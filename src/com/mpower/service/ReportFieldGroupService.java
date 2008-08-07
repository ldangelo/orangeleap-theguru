package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportFieldGroup;

public interface ReportFieldGroupService {
	public List<ReportFieldGroup> readFieldGroupBySubSourceId(Long l);

	public void save(ReportFieldGroup datasource);

	public ReportFieldGroup find(Long Id);

}
