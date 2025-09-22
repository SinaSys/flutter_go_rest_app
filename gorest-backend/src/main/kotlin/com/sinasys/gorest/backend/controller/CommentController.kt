package com.sinasys.gorest.backend.controller

import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import com.sinasys.gorest.backend.dto.CommentDto
import com.sinasys.gorest.backend.service.CommentService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping


@RestController
@RequestMapping("/comments")
class CommentController(private val commentService: CommentService) {


    @GetMapping
    fun getComment(@RequestParam(name = "post_id") postId: Long): List<CommentDto> {
        return commentService.getComments(postId)
    }

    @PostMapping
    fun addComment(@Valid @RequestBody commentDto: CommentDto): ResponseEntity<CommentDto> {
        val savedComment = commentService.addComment(commentDto)
        return ResponseEntity.status(HttpStatus.CREATED).body(savedComment)

    }

    @DeleteMapping("/{id}")
    fun deleteComment(@PathVariable id: Long): ResponseEntity<Void> {
        commentService.deleteComment(id)
        return ResponseEntity.noContent().build()
    }
}