package com.sinasys.gorest.backend.controller

import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import com.sinasys.gorest.backend.dto.TodoDto
import org.springframework.http.ResponseEntity
import com.sinasys.gorest.backend.dto.TodoStatus
import com.sinasys.gorest.backend.service.TodoService
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping


@RestController
@RequestMapping("/todos")
class TodoController(private val todoService: TodoService) {


    @PostMapping
    fun addTodo(@Valid @RequestBody todoDto: TodoDto): ResponseEntity<TodoDto> {
        val savedTodo = todoService.createTodo(todoDto)
        return ResponseEntity.status(HttpStatus.CREATED).body(savedTodo)
    }

    @GetMapping
    fun findTodoByUserId(
        @RequestParam("user_id") userId: Long,
        @RequestParam(required = false) status: TodoStatus?
    ): List<TodoDto> {
        return todoService.findTodoByUserId(userId, status)
    }

    @DeleteMapping("/{id}")
    fun deleteTodoById(@PathVariable id: Long): ResponseEntity<Void> {
        todoService.deleteTodo(id)
        return ResponseEntity.noContent().build()
    }

    @PutMapping("/{id}")
    fun updateTodo(
        @PathVariable id: Long,
        @RequestBody todoDto: TodoDto
    ): ResponseEntity<TodoDto> {
        val updatedTodo = todoService.updateTodo(id, todoDto)
        return ResponseEntity.ok(updatedTodo);
    }
}


