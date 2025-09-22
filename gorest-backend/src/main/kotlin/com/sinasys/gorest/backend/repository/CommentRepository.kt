package com.sinasys.gorest.backend.repository

import com.sinasys.gorest.backend.entity.CommentEntity
import org.springframework.data.jpa.repository.JpaRepository

interface CommentRepository : JpaRepository<CommentEntity, Long> {
}