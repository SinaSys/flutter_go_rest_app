package com.sinasys.gorest.backend.dto

import jakarta.validation.constraints.NotNull
import com.fasterxml.jackson.annotation.JsonProperty

data class PostDto(
    val id: Long?,
    @field:NotNull(message = "user_id is required")
    @JsonProperty("user_id")
    val userId: Long?,
    val title: String,
    val body: String,
)

