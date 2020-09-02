//
//  ModuleResponse.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 22/03/2018.
//  Copyright © 2018 Sergey Petrachkov. All rights reserved.
//

public protocol ModuleResponse {
  associatedtype RequestType = ModuleRequest
  var originalRequest: RequestType { get set }
}
