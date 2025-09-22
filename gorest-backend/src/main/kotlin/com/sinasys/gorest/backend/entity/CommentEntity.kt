package com.sinasys.gorest.backend.entity

import jakarta.persistence.Id
import jakarta.persistence.Table
import jakarta.persistence.Entity
import jakarta.persistence.Column
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType


@Entity
@Table(name = "comment")
open class CommentEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    open var id: Long = 0,
    @Column(nullable = false)
    open var postId: Long? = 0,
    @Column(nullable = false)
    open var name: String = "",
    @Column(nullable = false)
    open var email: String = "",
    @Column(nullable = false)
    open var body: String = ""
)
