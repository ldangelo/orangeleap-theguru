package com.mpower.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.mpower.domain.TheGuruViewJoin;

@Repository("theGuruViewJoinDao")
public class JPATheGuruViewJoinDao implements TheGuruViewJoinDao {
	@PersistenceContext
	private EntityManager em;

	@Override
	public TheGuruViewJoin findById(long Id) {
		return em.find(TheGuruViewJoin.class, Id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TheGuruViewJoin> getAll() {
		Query q = em
				.createQuery("SELECT theguruviewjoin from com.mpower.domain.TheGuruViewJoin theguruviewjoin order by theguruviewjoin.sortOrder");
		return q.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TheGuruViewJoin> findByViewId(long viewId) {
		Query q = em
		.createQuery("SELECT theguruviewjoin from com.mpower.domain.TheGuruViewJoin theguruviewjoin where theguruviewjoin.viewId = ? order by theguruviewjoin.sortOrder");
		q.setParameter(1, viewId);
		return q.getResultList();
	}
}
