package com.sinasys.gorest.backend.entity

import jakarta.persistence.Id
import jakarta.persistence.Table
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType


@Entity
@Table(name = "post")
open class PostEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    open var id: Long = 0,
    @Column(nullable = false)
    open var title: String = "",
    @Column(nullable = false, columnDefinition = "TEXT")
    open var body: String = "",
    @Column(nullable = false)
    open var userId: Long? = 10
)