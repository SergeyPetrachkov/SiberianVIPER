//
//  Closeable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

public protocol Closeable {
  func close(animated: Bool, completion: (() -> Void)?)
}
