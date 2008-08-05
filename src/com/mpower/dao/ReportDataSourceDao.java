package com.mpower.dao;

import java.util.SortedSet;

import com.mpower.domain.ReportDataSource;

public interface ReportDataSourceDao {
	public ReportDataSource findById(long Id);

	public SortedSet<ReportDataSource> getAll();

	public void save(ReportDataSource datasource);

	public ReportDataSource update(ReportDataSource datasource);

	public void delete(ReportDataSource datasource);
}