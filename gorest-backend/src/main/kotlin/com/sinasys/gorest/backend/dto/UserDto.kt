package com.sinasys.gorest.backend.dto

import jakarta.validation.constraints.Email
import jakarta.validation.constraints.NotBlank
import org.hibernate.validator.constraints.Length
import com.fasterxml.jackson.annotation.JsonProperty


enum class Gender {
    @JsonProperty("male")
    Male,

    @JsonProperty("female")
    Female
}

enum class UserStatus {
    @JsonProperty("inactive")
    Inactive,

    @JsonProperty("active")
    Active
}


data class UserDto(
    val id: Long?,
    @field:Length(min = 4, max = 15, message = "Name must be between 4 and 15")
    val name: String,
    @field:NotBlank(message = "Email must not be blank")
    @field:Email(message = "Invalid email format")
    val email: String,
    val gender: Gender? = null,
    @JsonProperty("status")
    val userStatus: UserStatus? = null,
)