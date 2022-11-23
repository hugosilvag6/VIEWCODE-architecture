//
//  UserProvider.swift
//  arquitetura
//
//  Created by Hugo Silva on 23/11/22.
//

import Foundation
import FirebaseAuth

protocol UserProviderProtocol {
   func login(parameters: [AnyHashable:Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void)
   func register(parameters: [AnyHashable:Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void)
}

class UserProvider: UserProviderProtocol {
   
   lazy var auth = Auth.auth()
   
   func login(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
      let body: NSDictionary = parameters[Constants.ParametersKeys.body] as! NSDictionary
      let userModel = body[Constants.ParametersKeys.userModel] as! UserModel
      
      self.auth.signIn(withEmail: userModel.email, password: userModel.password) { result, error in
         if let error {
            completionHandler(.failure(error))
         } else {
            completionHandler(.success(userModel))
         }
      }
   }
   
   func register(parameters: [AnyHashable : Any], completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
      let body: NSDictionary = parameters[Constants.ParametersKeys.body] as! NSDictionary
      let userModel = body[Constants.ParametersKeys.userModel] as! UserModel
      
      self.auth.createUser(withEmail: userModel.email, password: userModel.password) { result, error in
         if let error {
            completionHandler(.failure(error))
         } else {
            completionHandler(.success(userModel))
         }
      }
   }
}
