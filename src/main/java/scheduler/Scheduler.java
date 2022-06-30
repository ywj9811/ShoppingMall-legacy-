package scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


import dao.UserDAO;

@Component
public class Scheduler {
	@Autowired
	UserDAO user_dao;
	
	@Scheduled(cron="10 22 18 * * *")
	public void autoUpdate() {
		
		
		user_dao.updateUser();
	}
}
