//
//  ErrorReporter.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 22/03/2018.
//  Copyright © 2018 Sergey Petrachkov. All rights reserved.
//

import Foundation

public protocol ErrorReporter {
  func track(error: Error)
}
