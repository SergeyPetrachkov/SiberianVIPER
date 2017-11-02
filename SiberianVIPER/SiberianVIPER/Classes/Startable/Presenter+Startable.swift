//
//  Presenter+Startable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

public protocol Presenter: Startable {
  func requestClose()
}
