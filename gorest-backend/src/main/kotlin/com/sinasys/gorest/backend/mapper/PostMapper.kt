package com.sinasys.gorest.backend.mapper

import com.sinasys.gorest.backend.dto.PostDto
import com.sinasys.gorest.backend.entity.PostEntity


fun PostEntity.toDto(): PostDto {
    return PostDto(
        id = this.id,
        title = this.title,
        body = this.body,
        userId = this.userId!!
    )
}

fun PostDto.toEntity(updateMode: Boolean = false): PostEntity {
    return PostEntity(
        id = if (updateMode) this.id ?: 0 else 0,
        title = this.title,
        body = this.body,
        userId = this.userId,
    )
}

fun PostDto.update(post: PostEntity): PostEntity {
    post.title = this.title
    post.body = this.body
    post.userId = this.userId ?: post.userId
    return post
}