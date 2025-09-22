package com.sinasys.gorest.backend.mapper

import com.sinasys.gorest.backend.dto.TodoDto
import com.sinasys.gorest.backend.dto.TodoStatus
import com.sinasys.gorest.backend.entity.TodoEntity


fun TodoEntity.toDto(): TodoDto {
    return TodoDto(
        id = this.id,
        userId = this.userId,
        title = this.title,
        status = this.status,
        dueOn = dueOn,
    )
}

fun TodoDto.toEntity(updateMode: Boolean = false): TodoEntity {
    return TodoEntity(
        id = if (updateMode) this.id ?: 0 else 0,
        userId = this.userId!!,
        title = this.title ?: "",
        status = this.status ?: TodoStatus.Pending,
        dueOn = dueOn,
    )
}

fun TodoDto.update(todo: TodoEntity): TodoEntity {
    todo.title = this.title ?: ""
    todo.status = this.status ?: todo.status
    todo.dueOn = this.dueOn ?: todo.dueOn
    return todo
}