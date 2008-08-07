package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;

public interface ReportFieldService {
	public List<ReportField> readFieldByGroupId(Long l);

	public void save(ReportField f);

	public ReportField find(Long Id);

}
