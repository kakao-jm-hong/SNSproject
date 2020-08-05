package com.mit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mit.dto.Team;
import com.mit.repo.TeamRepo;

@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	private TeamRepo teamRepo;

	@Override
	public boolean insert(Team team) {
		return teamRepo.insert(team);
	}

	@Override
	public List<Team> select(String no) {
		return teamRepo.select(no);
	}

}
