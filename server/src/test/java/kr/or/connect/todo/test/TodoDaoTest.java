package kr.or.connect.todo.test;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import kr.or.connect.todo.domain.Todo;
import kr.or.connect.todo.persistence.TodoDao;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class TodoDaoTest {
	
	@Autowired
	private TodoDao dao;

	private final Logger log = LoggerFactory.getLogger(TodoDao.class);
	
	@Test
	public void shouldSelectAll(){
		List<Todo> allTodos = dao.selectAll();
		assertThat(allTodos, is(notNullValue()));
	}
	
	@Test
	public void shouldSelectByIdAndInsert(){
		Todo testTodo = new Todo();
		testTodo.setTodo("shouldSelectById Test");
		Integer id = dao.insert(testTodo);
		Todo todo = dao.selectById(id);
		assertThat(todo.getTodo(), is("shouldSelectById Test"));
	}
	
	@Test
	public void shouldDeleteById(){
		Todo todo = new Todo();
		todo.setTodo("coding");
		Integer id = dao.insert(todo);
		int result = dao.deleteById(id);
		assertThat(result, is(1));
	}
	
	@Test
	public void updateCompleted(){
		Todo todo = new Todo();
		todo.setTodo("updateCompleted Test");
		Integer id = dao.insert(todo);
		
		todo = dao.selectById(id);
		
		todo.setCompleted(1);
		int result = dao.updateCompleted(todo);
		
		assertThat(result, is(1));
		todo = dao.selectById(id);
		assertThat(todo.getCompleted(), is(1));
		log.info(todo.toString());
	}
	
	@Test
	public void shouldUpdateTodo(){
		Todo todo = new Todo();
		todo.setTodo("coding");
		Integer id = dao.insert(todo);
		
		todo = dao.selectById(id);
		
		todo.setTodo("git, SC");
		int result = dao.updateTodo(todo);
		
		assertThat(result, is(1));
		todo = dao.selectById(id);
		assertThat(todo.getTodo(), is("git, SC"));
		log.info(todo.toString());
	}
	
	@Test
	public void shouldDeleteCompletedAll(){
		int completedCount = dao.getCompletedCount();
		int result = dao.deleteCompletedAll();
		assertThat(result, is(completedCount));
	}
	
	@Test
	public void shouldSetCompletedAll(){
		int totalCount = dao.getTodosCount();
		int completedCount = dao.getCompletedCount();
		
		int result = dao.updateSetCompletedAll();
		assertThat(result, is(totalCount - completedCount));
	}
	
	@Test
	public void shouldSetUncompletedAll(){
		int completedCount = dao.getCompletedCount();
		int result = dao.updateSetUncompletedAll();
		assertThat(result, is(completedCount));
	}
}
