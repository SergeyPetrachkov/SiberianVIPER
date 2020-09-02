//
//  CloseableRouter.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

public protocol CloseableRouter {
  func close(module: Closeable)
}
