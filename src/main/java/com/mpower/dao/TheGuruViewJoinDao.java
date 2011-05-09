package com.mpower.dao;

import java.util.List;
import com.mpower.domain.TheGuruViewJoin;

public interface TheGuruViewJoinDao {
	public TheGuruViewJoin findById(long Id);
	public List<TheGuruViewJoin> findByViewId(long viewId);
	public List<TheGuruViewJoin> getAll();
}