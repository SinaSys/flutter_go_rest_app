package com.sinasys.gorest.backend.service

import org.springframework.stereotype.Service
import com.sinasys.gorest.backend.mapper.toDto
import com.sinasys.gorest.backend.dto.CommentDto
import com.sinasys.gorest.backend.mapper.toEntity
import com.sinasys.gorest.backend.repository.PostRepository
import com.sinasys.gorest.backend.validation.NotFoundException
import com.sinasys.gorest.backend.repository.CommentRepository

@Service
class CommentService(
    private val commentRepository: CommentRepository,
    private val postRepository: PostRepository,
) {


    fun getComments(postId: Long): List<CommentDto> {


        if (!postRepository.existsById(postId)) {
            throw NotFoundException("Comment", "Post", postId)
        }

        return commentRepository.findAll().filter { commentEntity ->
            commentEntity.postId == postId
        }.map {
            it.toDto()
        }
    }


    fun addComment(commentDto: CommentDto): CommentDto {

        if (!postRepository.existsById(commentDto.postId!!)) {
            throw NotFoundException("Comment", "Post", commentDto.postId)
        }
        return commentRepository.save(commentDto.toEntity()).toDto()
    }

    fun updateComment(commentDto: CommentDto): CommentDto {
        return commentRepository.save(commentDto.toEntity(updateMode = true)).toDto()
    }

    fun deleteComment(id: Long) {
        if (!commentRepository.existsById(id)) {
            throw NotFoundException("Comment", id)
        }
        commentRepository.deleteById(id)
    }
}