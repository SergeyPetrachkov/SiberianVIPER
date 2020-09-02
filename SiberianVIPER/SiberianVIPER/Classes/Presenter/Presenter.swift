//
//  Presenter+Startable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

open class SiberianPresenter: Awaitable, Startable, CloseableModule {
  // MARK: - Initializer
  public init() { }
  // MARK: - Startable
  open func start() {
    
  }
  
  open func stop() {
    
  }
  // MARK: - Closeable module
  open func requestClose() {
    
  }
  // MARK: - Awaitable
  open var awaitableModel: BusyViewModel?
  
  public weak var awaitableDelegate: AwaitableDelegate?
  
  open func enterPendingState(visible: Bool, blocking: Bool) {
    self.awaitableDelegate?.didEnterPendingState(visible: visible, blocking: blocking)
    self.awaitableModel?.isBusy = true
  }
  open func exitPendingState() {
    self.awaitableDelegate?.didExitPendingState()
    self.awaitableModel?.isBusy = false
  }
}
