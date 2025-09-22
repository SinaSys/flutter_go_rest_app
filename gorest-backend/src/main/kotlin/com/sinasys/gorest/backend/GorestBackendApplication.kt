package com.sinasys.gorest.backend

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class GorestBackendApplication

fun main(args: Array<String>) {
    runApplication<GorestBackendApplication>(*args)
}
