package com.sinasys.gorest.backend.controller

import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import com.sinasys.gorest.backend.dto.PostDto
import org.springframework.http.ResponseEntity
import com.sinasys.gorest.backend.service.PostService
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/posts")
class PostController(private val postService: PostService) {

    @GetMapping
    fun getPost(@RequestParam(name = "user_id") userId: Long): List<PostDto> {
        return postService.findPostByUserId(userId)
    }

    @PostMapping
    fun createPost(@Valid @RequestBody postDto: PostDto): ResponseEntity<PostDto> {
        val savedPost = postService.createPost(postDto)
        return ResponseEntity.status(HttpStatus.CREATED).body(savedPost)
    }

    @PutMapping("/{id}")
    fun updatePost(
        @PathVariable id: Long,
        @RequestBody postDto: PostDto,
    ): ResponseEntity<PostDto> {
        val updatedPost = postService.updatePost(id, postDto)
        return ResponseEntity.ok(updatedPost);
    }

    @DeleteMapping("/{id}")
    fun deletePost(@PathVariable id: Long): ResponseEntity<Void> {
        postService.deletePost(id)
        return ResponseEntity.noContent().build()
    }
}