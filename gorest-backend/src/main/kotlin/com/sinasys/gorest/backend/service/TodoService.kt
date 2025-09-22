package com.sinasys.gorest.backend.service

import org.springframework.stereotype.Service
import com.sinasys.gorest.backend.dto.TodoDto
import com.sinasys.gorest.backend.mapper.toDto
import com.sinasys.gorest.backend.mapper.update
import com.sinasys.gorest.backend.dto.TodoStatus
import com.sinasys.gorest.backend.mapper.toEntity
import com.sinasys.gorest.backend.repository.TodoRepository
import com.sinasys.gorest.backend.repository.UserRepository
import com.sinasys.gorest.backend.validation.NotFoundException


@Service
class TodoService(
    val todoRepository: TodoRepository,
    private val userRepository: UserRepository,
) {


    fun createTodo(todoDto: TodoDto): TodoDto {
        if (!userRepository.existsById(todoDto.userId!!)) {
            throw NotFoundException("Todo", "User", todoDto.userId)
        }

        return todoRepository.save(todoDto.toEntity()).toDto()
    }

    fun findTodoByUserId(userId: Long, status: TodoStatus?): List<TodoDto> {

        if (!userRepository.existsById(userId)) {
            throw NotFoundException("User", userId)
        }

        val todos = if (status != null) {
            todoRepository.findByUserIdAndStatus(userId, status)
        } else {
            todoRepository.findByUserId(userId)
        }

        return todos.map { it.toDto() }
    }

    fun deleteTodo(id: Long) {
        if (!todoRepository.existsById(id)) {
            throw NotFoundException("todo", id)
        }
        todoRepository.deleteById(id)
    }

    fun updateTodo(id: Long, todoDto: TodoDto): TodoDto {

        val todoEntity = todoRepository.findById(id)
            .orElseThrow { NotFoundException("Todo", id) }

        val updatedTodo = todoDto.update(todoEntity)

        return todoRepository.save(updatedTodo).toDto()

    }
}


