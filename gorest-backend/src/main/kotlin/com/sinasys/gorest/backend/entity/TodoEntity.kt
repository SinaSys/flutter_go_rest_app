package com.sinasys.gorest.backend.entity


import jakarta.persistence.Id
import java.time.LocalDateTime
import jakarta.persistence.Table
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import com.sinasys.gorest.backend.dto.TodoStatus


@Entity
@Table(name = "todo")
open class TodoEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    open var id: Long = 0,

    @Column(nullable = false)
    open var userId: Long = 0,

    @Column(nullable = false)
    open var title: String = "",

    @Column(name = "due_on")
    open var dueOn: LocalDateTime? = null,

    @Enumerated(EnumType.STRING)
    open var status: TodoStatus = TodoStatus.Pending
)