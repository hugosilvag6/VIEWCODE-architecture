//
//  Business.swift
//  arquitetura
//
//  Created by Hugo Silva on 23/11/22.
//

import Foundation

// responsável por pegar o que preciso passar pro provider pra ele passar pra api
// também decide se, por exemplo, gravará local ou na web (dependendo se user ta on ou off)

protocol UserBusinessProtocol {
   func login(email: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void)
   func register(email: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void)
}

class UserBusiness: UserBusinessProtocol {
   let provider: UserProvider = UserProvider()
   
   func login(email: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
      provider.login(parameters: self.getParams(email, password)) { result in
         switch result {
         case .success(let userModel):
            completionHandler(.success(userModel))
         case .failure(let error):
            completionHandler(.failure(error))
         }
      }
   }
   
   func register(email: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
      provider.register(parameters: self.getParams(email, password)) { result in
         switch result {
         case .success(let userModel):
            completionHandler(.success(userModel))
         case .failure(let error):
            completionHandler(.failure(error))
         }
      }
   }
   
   private func getParams(_ email: String, _ password: String) -> [AnyHashable:Any] {
      let userModel = UserModel(email: email, password: password)
      let params: [AnyHashable:Any] = [Constants.ParametersKeys.body: [Constants.ParametersKeys.userModel: userModel]]
      return params
   }
}
