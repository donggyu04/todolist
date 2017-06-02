package kr.or.connect.todo.test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.mockito.Matchers.isNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import kr.or.connect.todo.domain.Todo;
import kr.or.connect.todo.service.TodoService;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class TodoControllerTest {

	@Autowired
	private WebApplicationContext wax;
	
	@Autowired
	private TodoService service;
	
	private MockMvc mvc;
	
	@Before
	public void setUp(){
		this.mvc = MockMvcBuilders.webAppContextSetup(this.wax).build();	
	}
	
	@Test
	public void shouldCreate() throws Exception{
		mvc.perform(post("/api/todos").param("todo", "insert controller test"))
		.andExpect(status().isCreated())
		.andExpect(jsonPath("$.id").exists())
		.andExpect(jsonPath("$.todo").value("insert controller test"))
		.andExpect(jsonPath("$.completed").value(0))
		.andExpect(jsonPath("$.date").exists());
	}
	
	@Test
	public void shouldUpdateCompleted() throws Exception {
		Todo todo = new Todo();
		todo.setTodo("updateCompleted controller test");;
		Integer id = service.insertTodo(todo);
		
		mvc.perform(put("/api/todos/" + id).param("completed", "1"))
		.andExpect(status().isNoContent());
		
		todo = service.selectById(id);
		assertThat(todo.getCompleted(), is(1));
	}

	@Test
	public void shouldUpdateTodo() throws Exception {
		Todo todo = new Todo();
		todo.setTodo("updateCompleted controller test");;
		Integer id = service.insertTodo(todo);
		
		mvc.perform(put("/api/todos/" + id).param("todo", "updated todo"))
		.andExpect(status().isNoContent());
		
		todo = service.selectById(id);
		assertThat(todo.getTodo(), is("updated todo"));
	}
	
	@Test
	public void shouldDeleteById() throws Exception {
		Todo todo = new Todo();
		todo.setTodo("DeleteById controller test");
		Integer id = service.insertTodo(todo);
		
		mvc.perform(delete("/api/todos/" + id))
		.andExpect(status().isNoContent());
		
		todo = service.selectById(id);
		assertThat(todo , is(isNull()));
	}
	
}
