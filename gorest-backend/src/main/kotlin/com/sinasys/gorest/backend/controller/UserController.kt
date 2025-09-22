package com.sinasys.gorest.backend.controller

import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import com.sinasys.gorest.backend.dto.Gender
import com.sinasys.gorest.backend.dto.UserDto
import org.springframework.http.ResponseEntity
import com.sinasys.gorest.backend.dto.UserStatus
import com.sinasys.gorest.backend.service.UserService
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping


@RequestMapping("/users")
@RestController
class UserController(
    private val userService: UserService
) {

    @GetMapping
    fun getUserById(
        @RequestParam(required = false, name = "gender") gender: Gender?,
        @RequestParam(required = false, name = "status") status: UserStatus?
    ): List<UserDto> {
        return userService.getUserById(gender, status)
    }

    @PostMapping
    fun addUser(@RequestBody @Valid userDto: UserDto): ResponseEntity<UserDto> {
        val savedUser = userService.addUser(userDto)
        return ResponseEntity.status(HttpStatus.CREATED).body(savedUser)

    }

    @PutMapping("/{id}")
    fun updateUser(
        @PathVariable id: Long,
        @RequestBody userDto: UserDto
    ): ResponseEntity<UserDto> {
        val updated: UserDto = userService.updateUser(id, userDto)
        return ResponseEntity.ok(updated);

    }

    @DeleteMapping("/{id}")
    fun deleteUser(@PathVariable("id") id: Long): ResponseEntity<Void> {
        userService.deleteUser(id)
        return ResponseEntity.noContent().build()
    }

}