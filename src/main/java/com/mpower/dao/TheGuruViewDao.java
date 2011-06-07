package com.mpower.dao;

import java.util.List;
import com.mpower.domain.TheGuruView;

public interface TheGuruViewDao {
	public TheGuruView findById(long Id);
	public List<TheGuruView> findByPrimaryTableName(String primaryTableName);
	public TheGuruView findByViewName(String viewName);
	public List<TheGuruView> getAll();
}