package com.sinasys.gorest.backend.dto

import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.NotBlank
import com.fasterxml.jackson.annotation.JsonProperty

data class CommentDto(
    val id: Long?,
    @field:NotNull(message = "post_id is required")
    @JsonProperty("post_id")
    val postId: Long?,
    @field:NotBlank(message = "Name is required")
    val name: String?,
    @field:NotBlank(message = "Email is required")
    val email: String? ,
    @field:NotBlank(message = "Body is required")
    val body: String?,
)
