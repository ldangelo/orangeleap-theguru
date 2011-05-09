package com.mpower.service;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.TheGuruViewJoinDao;
import com.mpower.domain.TheGuruViewJoin;

@Service("theGuruViewJoinService")
public class TheGuruViewJoinServiceImpl implements TheGuruViewJoinService {
	@Resource(name = "theGuruViewJoinDao")
	private TheGuruViewJoinDao theGuruViewJoinDao;

	@Override
	public TheGuruViewJoin find(Long Id) {
		return theGuruViewJoinDao.findById(Id);
	}

	@Override
	public List<TheGuruViewJoin> readTheGuruViewJoins() {
		return theGuruViewJoinDao.getAll();
	}

	@Override
	public List<TheGuruViewJoin> readTheGuruViewJoinsByViewId(long viewId) {
		return theGuruViewJoinDao.findByViewId(viewId);
	}
}
