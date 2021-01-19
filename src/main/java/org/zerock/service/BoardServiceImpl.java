package org.zerock.service;

import java.util.List;


import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor 
@Log4j
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		mapper.insertSelectKey(board);			
		}
	/*
	@Override
	public List<BoardVO> getList() {
		return mapper.getList()
	}
	*/
	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);		
	}
	
	@Override
	public BoardVO get(Long bno) {	
		return mapper.read(bno);
	}
	
	@Override
	public boolean remove(Long bno) {
		return mapper.delete(bno) == 1; // 영향을받은 레코드가 변경이되었는지 확인하는 코드
	}
	
	@Override
	public boolean modify(BoardVO board) {		
		return mapper.update(board) == 1;
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
}
