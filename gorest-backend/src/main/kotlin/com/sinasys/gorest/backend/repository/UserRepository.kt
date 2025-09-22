package com.sinasys.gorest.backend.repository

import com.sinasys.gorest.backend.entity.UserEntity
import org.springframework.data.jpa.repository.JpaRepository


interface UserRepository : JpaRepository<UserEntity, Long>

