package com.mit.repo;

import java.util.List;

public interface FeedimageRepo {
	List<String> select(int no);
	boolean insert(int no, String src);
}
