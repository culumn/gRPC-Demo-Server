//
//  Server.swift
//  grpc-server
//
//  Created by Matsuoka Yoshiteru on 2017/06/25.
//
//

import Foundation
import gRPC

class Provider: Proto_UserServiceProvider {
    var users: [String: Any] = [:]

    func create(request: Proto_CreateRequest, session: Proto_UserServiceCreateSession) throws -> Proto_CreateResponse {
        var user = Proto_User()
        user.name = request.name
        user.age = request.age
        user.sex = request.sex
        if let _ = self.users[user.name] as? Proto_User {
            var response = Proto_CreateResponse()
            response.status = Proto_Status.fail
            response.message = "user already exists"
            return response
        }

        self.users[user.name] = user
        var response = Proto_CreateResponse()
        response.status = Proto_Status.ok
        response.message = "success"
        return response
    }

    func update(request: Proto_UpdateRequest, session: Proto_UserServiceUpdateSession) throws -> Proto_UpdateResponse {
        var user = Proto_User()
        user.name = request.name
        user.age = request.age
        user.sex = request.sex

        if self.users[user.name] as? Proto_User == nil{
            var response = Proto_UpdateResponse()
            response.status = Proto_Status.fail
            response.message = "no such user exists"
            return response
        }

        var response = Proto_UpdateResponse()
        self.users[user.name] = user
        response.status = Proto_Status.ok
        response.message = "success"
        return response
    }

    func getall(request: Proto_GetAllRequest, session: Proto_UserServiceGetAllSession) throws -> Proto_GetAllResponse {
        var users: [Proto_User] = []
        for v in self.users.values {
            users.append(v as! Proto_User)
        }

        var response = Proto_GetAllResponse()
        response.status = Proto_Status.ok
        response.message = "success"
        response.users = users
        return response
    }

    func get(request: Proto_GetRequest, session: Proto_UserServiceGetSession) throws -> Proto_GetResponse {
        let username = request.name

        if self.users[username] as? Proto_User == nil {
            var response = Proto_GetResponse()
            response.status = Proto_Status.fail
            response.message = "no such user exists"
            return response
        }

        var response = Proto_GetResponse()
        response.status = Proto_Status.ok
        response.message = "success"
        response.user = self.users[username] as! Proto_User
        return response
    }

    func delete(request: Proto_DeleteRequest, session: Proto_UserServiceDeleteSession) throws -> Proto_DeleteResponse {
        let username = request.name

        if self.users[username] as? Proto_User == nil {
            var response = Proto_DeleteResponse()
            response.status = Proto_Status.fail
            response.message = "no such user exists"
            return response
        }

        var response = Proto_DeleteResponse()
        response.status = Proto_Status.ok
        response.message = "success"
        self.users.removeValue(forKey: username)
        return response
    }
}
