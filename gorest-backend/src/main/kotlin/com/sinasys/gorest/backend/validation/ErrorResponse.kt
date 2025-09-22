package com.sinasys.gorest.backend.validation

import java.util.Date

data class ErrorResponse(
    val status: Int,
    val message: String,
    val timestamp: Date,
    val details: String
)
