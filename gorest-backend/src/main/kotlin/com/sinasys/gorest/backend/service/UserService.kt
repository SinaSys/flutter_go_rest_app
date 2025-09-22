package com.sinasys.gorest.backend.service

import com.sinasys.gorest.backend.dto.Gender
import org.springframework.stereotype.Service
import com.sinasys.gorest.backend.dto.UserDto
import com.sinasys.gorest.backend.mapper.toDto
import com.sinasys.gorest.backend.mapper.update
import com.sinasys.gorest.backend.dto.UserStatus
import com.sinasys.gorest.backend.mapper.toEntity
import com.sinasys.gorest.backend.entity.UserEntity
import com.sinasys.gorest.backend.repository.UserRepository
import com.sinasys.gorest.backend.validation.NotFoundException


@Service
class UserService(private val userRepository: UserRepository) {

    fun addUser(userDto: UserDto): UserDto {
        return userRepository.save(userDto.toEntity()).toDto()
    }

    fun getAllUsers(): List<UserDto> {
        return userRepository.findAll().map { it.toDto() }
    }


    fun getUserById(gender: Gender?, status: UserStatus?): List<UserDto> {
        if (gender != null) {
            return userRepository.findAll().filter { it.gender == gender }.map { it.toDto() }
        }
        if (status != null) {
            return userRepository.findAll().filter { it.userStatus == status }.map { it.toDto() }
        }
        return getAllUsers()
    }

    fun updateUser(id: Long, userDto: UserDto): UserDto {

        val userEntity: UserEntity = userRepository.findById(id)
            .orElseThrow { NotFoundException("User", id) }

        val updatedUser = userDto.update(userEntity)

        return userRepository.save(updatedUser).toDto()
    }

    fun deleteUser(id: Long) {
        if (!userRepository.existsById(id)) {
            throw NotFoundException("User", id)
        }
        userRepository.deleteById(id)
    }
}