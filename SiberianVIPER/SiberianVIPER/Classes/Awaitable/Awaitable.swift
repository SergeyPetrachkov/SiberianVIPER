//
//  Awaitable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 25/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

public protocol Awaitable {
  /// Ask an object to go into pending state
  /// - parameters:
  ///   - visible: should indicate pending state
  ///   - blocking: should block interaction with the object
  func enterPendingState(visible: Bool, blocking: Bool)
  /// Ask an object to exit pending state
  func exitPendingState()
}
public protocol AwaitableDelegate: class {
  // Callback that signals an async operation start
  func didEnterPendingState(visible: Bool, blocking: Bool)
  // Callback that signals an async operation end
  func didExitPendingState()
}
