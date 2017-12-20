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
public protocol ViewModel {
  var isBusy: Bool { get set }
}
public protocol CollectionViewModel: ViewModel {
  var items: [CollectionModel] { get set }
  var changeSet: [CollectionChange] { get set }
}
public protocol Presenter {
  var view: View! { get set }
  var output: PresenterOutput? { get set }
  var router: Router? { get set }
  var interactor: Interactor? { get set }
  var moduleOutput: ModuleOutput? { get set }
  var viewModel: ViewModel! { get set }
}

public protocol Awaitable {
  func enterPendingState(blocking: Bool)
  func exitPendingState()
}
public protocol AwaitableOutput {
  func didEnterPendingState(blocking: Bool)
  func didExitPendingState()
}

public protocol SiberianPresenterOutput: PresenterOutput {
  
}
open class SiberianPresenter: Presenter, Startable, CloseableModule {
  // MARK: - Presenter
  public var view: View!
  
  public var viewModel: ViewModel!
  
  public var router: Router?
  
  public var interactor: Interactor?
  
  weak public var moduleOutput: ModuleOutput?
  
  weak public var output: PresenterOutput?
  
  // MARK: - Startable
  public func start() {
    
  }
  
  public func stop() {
    
  }
  // MARK: - Closeable module
  public func requestClose() {
    if self.view is Closeable {
      (self.router as? CloseableRouter)?.close(module: self.view as! Closeable)
    }
  }
}

extension SiberianPresenter: Awaitable {
  // MARK: - Awaitable input
  public func enterPendingState(blocking: Bool) {
    self.viewModel.isBusy = true
    (self.output as? AwaitableOutput)?.didEnterPendingState(blocking: blocking)
  }
  
  public func exitPendingState() {
    self.viewModel.isBusy = false
    (self.output as? AwaitableOutput)?.didExitPendingState()
  }
}
