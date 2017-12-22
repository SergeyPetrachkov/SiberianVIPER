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
public protocol BusyViewModel {
  var isBusy: Bool { get set }
}
public protocol CollectionViewModel: BusyViewModel {
  var items: [CollectionModel] { get set }
  var changeSet: [CollectionChange] { get set }
}
public protocol Presenter {
}

public protocol AwaitablePresenter: class, Awaitable {
  var awaitableOutput: AwaitableOutput? { get set }
}
extension AwaitablePresenter {
  public func enterPendingState(visible: Bool, blocking: Bool) {
    self.awaitableOutput?.didEnterPendingState(visible: visible, blocking: blocking)
  }
  public func exitPendingState() {
    self.awaitableOutput?.didExitPendingState()
  }
}


public protocol Awaitable {
  func enterPendingState(visible: Bool, blocking: Bool)
  func exitPendingState()
}
public protocol AwaitableOutput: class {
  func didEnterPendingState(visible: Bool, blocking: Bool)
  func didExitPendingState()
}

public protocol SiberianPresenterOutput: PresenterOutput {
  
}
open class SiberianPresenter: AwaitablePresenter, Startable, CloseableModule {
  // MARK: - Awaitable presenter
  public weak var awaitableOutput: AwaitableOutput?
  
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
}
