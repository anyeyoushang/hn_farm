/*
 * @(#) ClearRich.java 2016-11-11
 *
 * Copyright (c) 2015, HaoniuSoft Technology. All Rights Reserved.
 * HaoniuSoft  Technology. CONFIDENTIAL
 */
package other.job;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import model.dao.Animal;
import model.dao.LandTree;


public class deleteFruitTree implements Job {

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("15秒检测一次删除结够了120课果实的果树,和收益满120份的果树!");
		Animal.dao.deleteAnimal();
		LandTree.dao.deleteTree();
	}

}
