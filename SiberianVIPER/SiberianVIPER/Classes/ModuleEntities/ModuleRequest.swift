//
//  ModuleRequest.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 22/03/2018.
//  Copyright © 2018 Sergey Petrachkov. All rights reserved.
//

public protocol ModuleRequest { }

public protocol PaginationRequest: ModuleRequest {
  var paginationParams: PaginationParameters { get set }
}

public struct PaginationParameters {
  public let skip: Int
  public let take: Int
  public init(skip: Int, take: Int) {
    self.skip = skip
    self.take = take
  }
}
