package com.sinasys.gorest.backend.service

import org.springframework.stereotype.Service
import com.sinasys.gorest.backend.dto.PostDto
import com.sinasys.gorest.backend.mapper.toDto
import com.sinasys.gorest.backend.mapper.update
import com.sinasys.gorest.backend.mapper.toEntity
import com.sinasys.gorest.backend.repository.UserRepository
import com.sinasys.gorest.backend.repository.PostRepository
import com.sinasys.gorest.backend.validation.NotFoundException


@Service
class PostService(
    private val postRepository: PostRepository,
    private val userRepository: UserRepository,
) {

    fun findPostByUserId(userId: Long): List<PostDto> {

        if (!userRepository.existsById(userId)) {
            throw NotFoundException("Post", "User", userId)
        }

        return postRepository.findAll().filter { postEntity ->
            postEntity.userId == userId
        }.map {
            it.toDto()
        }
    }

    fun createPost(postDto: PostDto): PostDto {

        if (!userRepository.existsById(postDto.userId!!)) {
            throw NotFoundException("Post", postDto.userId)
        }
        return postRepository.save(postDto.toEntity()).toDto()
    }

    fun updatePost(id: Long, postDto: PostDto): PostDto {

        val postEntity = postRepository.findById(id)
            .orElseThrow { NotFoundException("Post", id) }

        val updatedPost = postDto.update(postEntity)

        return postRepository.save(updatedPost).toDto()

    }

    fun deletePost(id: Long) {
        if (!postRepository.existsById(id)) {
            throw NotFoundException("Post", id)
        }

        postRepository.deleteById(id)
    }
}