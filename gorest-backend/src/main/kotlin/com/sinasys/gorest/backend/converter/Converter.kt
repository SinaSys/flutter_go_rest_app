package com.sinasys.gorest.backend.converter

import com.sinasys.gorest.backend.dto.Gender
import com.sinasys.gorest.backend.dto.TodoStatus
import com.sinasys.gorest.backend.dto.UserStatus


import org.springframework.core.convert.converter.Converter
import org.springframework.stereotype.Component




abstract class EnumConverter<T : Enum<T>>(
    private val enumClass: Class<T>,
    private val label: String
) : Converter<String, T> {
    override fun convert(source: String): T =
        enumClass.enumConstants?.firstOrNull { it.name.equals(source, ignoreCase = true) }
            ?: throw IllegalArgumentException(
                "Invalid $label value: '$source'. Valid values are: " +
                        enumClass.enumConstants?.joinToString { it.name.lowercase() }
            )
}

@Component
class StringToGenderConverter : EnumConverter<Gender>(Gender::class.java, "gender")

@Component
class StringToUserStatusConverter : EnumConverter<UserStatus>(UserStatus::class.java, "user status")

@Component
class StringToTodoStatusConverter : EnumConverter<TodoStatus>(TodoStatus::class.java, "todo status")
