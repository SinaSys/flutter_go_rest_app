package com.sinasys.gorest.backend.entity

import jakarta.persistence.Id
import jakarta.persistence.Table
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import com.sinasys.gorest.backend.dto.Gender
import com.sinasys.gorest.backend.dto.UserStatus

@Entity
@Table(name = "users")
open class UserEntity(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    open var id: Long = 0,
    @Column(nullable = false)
    open var name: String = "",
    @Column(nullable = false)
    open var email: String = "",
    @Enumerated(EnumType.STRING)
    open var gender: Gender = Gender.Male,
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    open var userStatus: UserStatus = UserStatus.Inactive,
)