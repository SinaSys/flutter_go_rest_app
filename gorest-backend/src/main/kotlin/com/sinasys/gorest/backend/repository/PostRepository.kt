package com.sinasys.gorest.backend.repository

import com.sinasys.gorest.backend.entity.PostEntity
import org.springframework.data.jpa.repository.JpaRepository

interface PostRepository : JpaRepository<PostEntity, Long>
