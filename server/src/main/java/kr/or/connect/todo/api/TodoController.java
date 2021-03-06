package kr.or.connect.todo.api;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import kr.or.connect.todo.domain.Todo;
import kr.or.connect.todo.service.TodoService;
import kr.or.connect.todo.utils.Utils;

@RestController
@RequestMapping("/api/todos")
public class TodoController {
	
	private final TodoService service;
	private final String SET_COMPLETED_ALL = "setCompletedAll";
	
	@Autowired
	public TodoController(TodoService service){
		this.service = service;
	}
	
	@GetMapping
	List<Todo> getAllTodos(){
		return service.getAllTodos();
	}
	
	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	Todo insertTodo(Todo todo){
		todo.setTodo(Utils.simpleFilter(todo.getTodo()));
		Integer id = service.insertTodo(todo);

		return service.selectById(id);
	}
	
	@PutMapping("/{id}")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	void update(@PathVariable Integer id, Todo todo){
		if(todo.getTodo() == null) service.updateCompleted(todo);
		else{
			todo.setTodo(Utils.simpleFilter(todo.getTodo()));
			service.updateTodo(todo);
		}
	}
	
	@PutMapping
	int updateCompleAndUnComple(@RequestParam String mode){
		int count;
		if(mode.equals(SET_COMPLETED_ALL)){
			count = service.updateSetCompletedAll();
		}else{
			count = service.updateSetUncompletedAll();
		}
		return count;
	}
	
	@DeleteMapping
	@ResponseStatus(HttpStatus.NO_CONTENT)
	void deleteAll(){
		service.deleteCompletedAll();
	}
	
	@DeleteMapping("/{id}")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	void delete(@PathVariable Integer id){
		service.deleteById(id);
	}
	
}
