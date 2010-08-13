package com.mpower.service.customfiltercriterialookup;

import com.mpower.domain.ReportCustomFilter;

public interface ReportCustomFilterCriteriaLookupService {
	public String getLookupSql(ReportCustomFilter filter);
}
