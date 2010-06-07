package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportField;

public interface ReportFieldDao {
	public ReportField findById(long Id);

	public List<ReportField> getAll();
	public List<ReportField> getAllByGroupId(Long id);
	
	public void save(ReportField field);
	public ReportField copy(ReportField field);
	
	public ReportField update(ReportField field);

	public void delete(ReportField field);
}
