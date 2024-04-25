package com.team5.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ResultService {
	
	@Autowired
	private ResultRepository repository;
	
	
	public Result insert(Result result) {
		return repository.save(result);
	}
}
