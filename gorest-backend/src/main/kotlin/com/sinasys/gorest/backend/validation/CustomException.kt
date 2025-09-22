package com.sinasys.gorest.backend.validation


class NotFoundException : RuntimeException {

    // Constructor for entity not found
    constructor(entityName: String, id: Long) : super("$entityName not found with id: $id")


    // Constructor for resource not found (e.g., todos for user)
    constructor(resourceName: String, ownerEntity: String, ownerId: Long) :
            super("$resourceName not found for $ownerEntity with id: $ownerId")

}