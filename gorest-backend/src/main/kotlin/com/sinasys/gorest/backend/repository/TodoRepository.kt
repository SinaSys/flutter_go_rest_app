package com.sinasys.gorest.backend.repository

import com.sinasys.gorest.backend.dto.TodoStatus
import com.sinasys.gorest.backend.entity.TodoEntity
import org.springframework.data.jpa.repository.JpaRepository

interface TodoRepository : JpaRepository<TodoEntity, Long> {

    fun findByUserId(userId: Long): List<TodoEntity>

    fun findByUserIdAndStatus(userId: Long, status: TodoStatus): List<TodoEntity>
}
