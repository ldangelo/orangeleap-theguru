package com.mpower.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.mpower.domain.ReportSegmentationType;

@Repository("reportSegmentationTypeDao")
public class JPAReportSegmentationTypeDao implements ReportSegmentationTypeDao {
	@PersistenceContext
	private EntityManager em;

	public void delete(ReportSegmentationType reportSegmentationType) {
		em.remove(reportSegmentationType);
	}

	public ReportSegmentationType findById(long Id) {
		return em.find(ReportSegmentationType.class,Id);
	}

	public List<ReportSegmentationType> getAll() {
		Query q = em
		.createQuery("SELECT reportSegmentationType from ReportSegmentationType reportSegmentationType");
		List<ReportSegmentationType> lrcfd = q.getResultList();
		return lrcfd;
	}

	public List<ReportSegmentationType> getAllByReportDataSubSourceId(Long id) {
		Query q = em.createQuery("select reportSegmentationType from ReportSegmentationType reportSegmentationType left join reportSegmentationType.reportDataSubSource as reportSubSource where reportSubSource.id = ?");

		q.setParameter(1, id);
		List<ReportSegmentationType> lrcfd = q.getResultList();

		return lrcfd;
	}

	public List<ReportSegmentationType> getAllBySegmentationTypeName(String segmentationTypeName) {
		Query q = em.createQuery("select reportSegmentationType from ReportSegmentationType reportSegmentationType where reportSegmentationType.segmentationType = ?");

		q.setParameter(1, segmentationTypeName);
		List<ReportSegmentationType> lrcfd = q.getResultList();

		return lrcfd;
	}

	public void save(ReportSegmentationType reportSegmentationType) {
		if (reportSegmentationType.getId() != null && em.find(ReportSegmentationType.class, reportSegmentationType) != null) {
			em.merge(reportSegmentationType);
			return;
		}
		em.persist(reportSegmentationType);
	}

	public ReportSegmentationType update(ReportSegmentationType reportSegmentationType) {
		em.merge(reportSegmentationType);
		return null;
	}

	@Override
	public ReportSegmentationType copy(ReportSegmentationType reportSegmentationType) {
		return new ReportSegmentationType(reportSegmentationType);
	}

}
