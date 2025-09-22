package com.sinasys.gorest.backend.validation

import java.util.Date
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.context.request.WebRequest
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice


@RestControllerAdvice
class GLobalException {


    @ExceptionHandler(NotFoundException::class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    fun handleNotFoundException(
        ex: NotFoundException,
        request: WebRequest
    )
            : ResponseEntity<ErrorResponse> {
        val errorResponse = ErrorResponse(
            status = HttpStatus.NOT_FOUND.value(),
            message = ex.message ?: "Resource not found",
            timestamp = Date(),
            details = request.getDescription(false)
        )
        return ResponseEntity(
            errorResponse,
            HttpStatus.NOT_FOUND,
        )
    }

}