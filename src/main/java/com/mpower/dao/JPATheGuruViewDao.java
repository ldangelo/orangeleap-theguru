package com.mpower.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.mpower.domain.TheGuruView;

@Repository("theGuruViewDao")
public class JPATheGuruViewDao implements TheGuruViewDao {
	@PersistenceContext
	private EntityManager em;

	@Override
	public TheGuruView findById(long Id) {
		return em.find(TheGuruView.class, Id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TheGuruView> getAll() {
		Query q = em
				.createQuery("SELECT theguruview from com.mpower.domain.TheGuruView theguruview order by theguruview.sortOrder");
		return q.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TheGuruView> findByPrimaryTableName(String primaryTableName) {
		Query q = em
		.createQuery("SELECT theguruview from com.mpower.domain.TheGuruView theguruview where theguruview.primaryTable = ? order by theguruview.sortOrder");
		q.setParameter(1, primaryTableName);
		return q.getResultList();
	}
	
	@Override
	public TheGuruView findByViewName(String viewName) {
		Query q = em
		.createQuery("SELECT theguruview from com.mpower.domain.TheGuruView theguruview where theguruview.viewName = ? order by theguruview.sortOrder");
		q.setParameter(1, viewName);
		if (q.getResultList().size() > 0)
			return (TheGuruView) q.getResultList().get(0);
		else
			return null;
	}	
}
