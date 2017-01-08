//
//  LoginAndRegisterRequest.swift
//  LearningFromBook
//
//  Created by 李天培 on 2017/1/6.
//  Copyright © 2017年 lee. All rights reserved.
//

import Foundation

class Request {
    static var main = Request()
    
    func register(user name: String, password: String, completion: ((_ success: Bool, _ error: Error?) -> Void)) {
        // check user and password
        // return info by closure
        guard Users[name] == nil  else {
            completion(false, NSError(domain: "LocalError", code: LocalError.userRepeat.rawValue, userInfo: nil))
            return
        }
        Users[name] = password
        completion(true, nil)
    }
    
    
    
    func login(user name: String, password: String, completion: ((_ success: Bool, _ error: NSError?) -> Void)) {
        // check user and password 
        // return info by closure
        
        // login success demo
//        completion(true, nil)

        // login fail demo
        
        
        guard let userPassword = Users[name] else {
            completion(false, NSError(domain: "LocalError", code: LocalError.userNotExist.rawValue, userInfo: nil))
            return
        }
        guard userPassword == password else {
            completion(false, NSError(domain: "LocalError", code: LocalError.worryPassword.rawValue, userInfo: nil))
            return
        }
        completion(true, nil)
    }
}

enum LocalError: Int {
    case failConnectServer
    case worryPassword
    case userNotExist
    case userRepeat
}
