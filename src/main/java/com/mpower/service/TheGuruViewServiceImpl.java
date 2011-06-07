package com.mpower.service;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.TheGuruViewDao;
import com.mpower.domain.TheGuruView;

@Service("theGuruViewService")
public class TheGuruViewServiceImpl implements TheGuruViewService {
	@Resource(name = "theGuruViewDao")
	private TheGuruViewDao theGuruViewDao;

	@Override
	public TheGuruView find(Long Id) {
		return theGuruViewDao.findById(Id);
	}

	@Override
	public List<TheGuruView> readTheGuruViews() {
		return theGuruViewDao.getAll();
	}

	@Override
	public List<TheGuruView> readTheGuruViewsByPrimaryTableName(String primaryTableName) {
		return theGuruViewDao.findByPrimaryTableName(primaryTableName);
	}

	@Override
	public TheGuruView readTheGuruViewByViewName(String viewName) {
		return theGuruViewDao.findByViewName(viewName);
	}
	
	
}
