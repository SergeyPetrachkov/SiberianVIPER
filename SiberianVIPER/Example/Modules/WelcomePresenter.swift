//
//  WelcomePresenter.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 13/12/2017.
//  Copyright (c) 2017 Sergey Petrachkov. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit
import SiberianVIPER

protocol WelcomePresenterInput: Awaitable, Startable, CloseableModule {
  var view: UIViewController! { get set }
  var output: WelcomePresenterOutput? { get set }
  var router : WelcomeRoutingLogic? { get set }
  var interactor : WelcomeInteractorInput? { get set }
  func presentSomething()
}
protocol WelcomePresenterOutput: AwaitableDelegate {
  func didChangeState(viewModel : Welcome.DataContext.ViewModel)
}

class WelcomePresenter: SiberianPresenter, WelcomePresenterInput {
  // MARK: - Essentials
  weak var view: UIViewController!
  weak var output : WelcomePresenterOutput?
  var router : WelcomeRoutingLogic?
  var interactor : WelcomeInteractorInput?
  var viewModel: Welcome.DataContext.ViewModel! {
    didSet{
      self.awaitableModel = self.viewModel
    }
  }
  // MARK: - Initializers
  override init() {
    super.init()
    self.viewModel = Welcome.DataContext.ViewModel()
  }
  deinit {
    print("WelcomePresenter deinit is called")
  }
  // MARK: - Presenter Input
  func presentSomething() {
    if self.viewModel.isBusy {
      return
    }
    self.enterPendingState(visible: true, blocking: true)
    self.interactor?.doSomething(request: Welcome.DataContext.Request())
  }
  
  // MARK: - Startable
  override func start() {
    super.start()
    self.awaitableDelegate = self.output
    self.awaitableModel = self.viewModel
  }
}
extension WelcomePresenter : WelcomeInteractorOutput {
  // MARK: - Interactor output
  func didReceive(response: Welcome.DataContext.Response) {
    viewModel.text = response.text
    self.output?.didChangeState(viewModel: viewModel)
    self.exitPendingState()
  }
  func didFail(with error: Error) {
    self.exitPendingState()
  }
}
