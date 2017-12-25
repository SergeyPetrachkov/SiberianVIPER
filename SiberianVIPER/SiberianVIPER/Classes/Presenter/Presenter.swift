//
//  Presenter+Startable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
public protocol PresenterOutput: class {
  
}
public protocol CloseableModule {
  func requestClose()
}

public protocol ModuleOutput: class {
  
}

public protocol Router {
  
}
public protocol Interactor {
  
}
public protocol View {
  
}

public protocol Presenter {
}


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
  func didEnterPendingState(visible: Bool, blocking: Bool)
  func didExitPendingState()
}

public protocol SiberianPresenterOutput: PresenterOutput {
  
}
open class SiberianPresenter: Awaitable, Startable, CloseableModule {
  
  // MARK: - Awaitable presenter
  open var awaitableModel: BusyViewModel?
  public weak var awaitableDelegate: AwaitableDelegate?
  
  public init() {
  }
  // MARK: - Startable
  open func start() {
    
  }
  
  open func stop() {
    
  }
  // MARK: - Closeable module
  public func requestClose() {
  }
  open func enterPendingState(visible: Bool, blocking: Bool) {
    self.awaitableDelegate?.didEnterPendingState(visible: visible, blocking: blocking)
    self.awaitableModel?.isBusy = true
  }
  open func exitPendingState() {
    self.awaitableDelegate?.didExitPendingState()
    self.awaitableModel?.isBusy = false
  }
}
