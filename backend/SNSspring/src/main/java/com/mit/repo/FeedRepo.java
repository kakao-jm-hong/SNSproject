package com.mit.repo;

import java.util.List;


import com.mit.dto.Feed;
public interface FeedRepo {
	public List<Feed> selectAll();
	public List<Feed> selectNikckname(String nickname);
	public Feed selectOne(String no);
	public boolean insert(Feed feed);
	public boolean update(Feed feed);
	public boolean delete(String no);
}
