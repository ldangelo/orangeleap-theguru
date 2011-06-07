package com.mpower.service;

import java.util.List;
import com.mpower.domain.TheGuruViewJoin;

public interface TheGuruViewJoinService {
	public List<TheGuruViewJoin> readTheGuruViewJoins();
	public List<TheGuruViewJoin> readTheGuruViewJoinsByViewId(long viewId);
	public TheGuruViewJoin find(Long Id);
}
