//
//  Presenter+Startable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
public protocol PresenterOutput {
  
}
public protocol Presenter: Startable {
  var output: PresenterOutput? { get set }
  func requestClose()
}
public protocol AwaitablePresenterInput {
  func enterPendingState(blocking: Bool)
  func exitPendingState()
}
public protocol AwaitablePresenterOutput {
  func didEnterPendingState(blocking: Bool)
  func didExitPendingState()
}

public protocol SiberianPresenterOutput: PresenterOutput {
  
}
open class SiberianPresenter: Presenter {
  public var output: PresenterOutput?
  
  public func start() {
    
  }
  
  public func stop() {
    
  }
  
  public func requestClose() {
    
  }
}

extension SiberianPresenter: AwaitablePresenterInput {
  public func enterPendingState(blocking: Bool) {
    (self.output as? AwaitablePresenterOutput)?.didEnterPendingState(blocking: blocking)
  }
  
  public func exitPendingState() {
    (self.output as? AwaitablePresenterOutput)?.didExitPendingState()
  }
}
