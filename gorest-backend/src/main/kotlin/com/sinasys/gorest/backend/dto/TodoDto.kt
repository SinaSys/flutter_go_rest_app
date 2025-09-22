package com.sinasys.gorest.backend.dto

import java.time.LocalDateTime
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.NotBlank
import com.fasterxml.jackson.annotation.JsonProperty


enum class TodoStatus {
    @JsonProperty("completed")
    Completed,

    @JsonProperty("pending")
    Pending,
}

data class TodoDto(
    val id: Long?,
    @field:NotNull(message = "user_id is required")
    @JsonProperty("user_id")
    val userId: Long?,
    @field:NotBlank(message = "title is required")
    val title: String?,
    @JsonProperty("status")
    val status: TodoStatus? = TodoStatus.Pending,

    @JsonProperty("due_on")
    val dueOn: LocalDateTime?,
)