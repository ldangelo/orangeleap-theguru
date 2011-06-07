package com.mpower.service;

import java.util.List;
import com.mpower.domain.TheGuruView;

public interface TheGuruViewService {
	public List<TheGuruView> readTheGuruViews();
	public List<TheGuruView> readTheGuruViewsByPrimaryTableName(String primaryTableName);
	public TheGuruView readTheGuruViewByViewName(String viewName);
	public TheGuruView find(Long Id);
}
