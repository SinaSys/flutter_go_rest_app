package com.sinasys.gorest.backend.mapper

import com.sinasys.gorest.backend.dto.CommentDto
import com.sinasys.gorest.backend.entity.CommentEntity


fun CommentEntity.toDto(): CommentDto {
    return CommentDto(
        id = this.id,
        postId = this.postId!!,
        name = this.name,
        email = this.email,
        body = this.body
    )
}

fun CommentDto.toEntity(updateMode: Boolean = false): CommentEntity {
    return CommentEntity(
        id = if (updateMode) this.id ?: 0 else 0,
        postId = this.postId,
        name = this.name!!,
        email = this.email!!,
        body = this.body!!
    )
}
