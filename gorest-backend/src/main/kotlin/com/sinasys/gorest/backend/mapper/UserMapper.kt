package com.sinasys.gorest.backend.mapper

import com.sinasys.gorest.backend.dto.Gender
import com.sinasys.gorest.backend.dto.UserDto
import com.sinasys.gorest.backend.dto.UserStatus
import com.sinasys.gorest.backend.entity.UserEntity


fun UserEntity.toDto(): UserDto {
    return UserDto(
        id = this.id,
        name = this.name,
        email = this.email,
        gender = this.gender,
        userStatus = this.userStatus,
    )
}

fun UserDto.toEntity(updateMode: Boolean = false): UserEntity {
    return UserEntity(
        id = if (updateMode) this.id ?: 0 else 0,
        name = this.name,
        email = this.email,
        gender = this.gender ?: Gender.Male,
        userStatus = this.userStatus ?: UserStatus.Inactive,
    )
}

fun UserDto.update(user: UserEntity): UserEntity {
    user.name = this.name
    user.email = this.email
    user.gender = this.gender ?: user.gender
    user.userStatus = this.userStatus ?: user.userStatus
    return user
}
