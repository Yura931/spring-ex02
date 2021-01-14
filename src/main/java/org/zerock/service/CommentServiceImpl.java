package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.CommentVO;
import org.zerock.mapper.CommentMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CommentServiceImpl implements CommentService {
	
	private CommentMapper mapper; // 의존성 주입, 이 필드를 가지고 자동으로 생성자를 만듦
	
	@Override
	public void register(CommentVO comment) {
		mapper.insertSelectKey(comment);		
	}
	
	@Override
	public List<CommentVO> getList() {
		return mapper.getList();
	}
	
	@Override
	public CommentVO get(Long cno) {
		return mapper.read(cno);
	}
	
	@Override
	public Boolean remove(Long cno) {
		return mapper.delete(cno) == 1;
	}
	
	@Override
	public Boolean modify(CommentVO comment) {
		return mapper.update(comment) == 1;
	}
}
