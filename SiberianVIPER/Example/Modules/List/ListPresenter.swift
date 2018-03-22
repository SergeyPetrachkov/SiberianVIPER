//
//  ListPresenter.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 25/12/2017.
//  Copyright (c) 2017 Sergey Petrachkov. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit
import SiberianVIPER

protocol ListPresenterInput: Awaitable, Startable, CloseableModule {
  var view: UIViewController! { get set }
  var output: ListPresenterOutput? { get set }
  var router : ListRoutingLogic? { get set }
  var interactor : ListInteractorInput? { get set }
  func refresh()
  func fetch()
}
protocol ListPresenterOutput: AwaitableDelegate {
  func didChangeState(viewModel : List.DataContext.ViewModel)
}

class ListPresenter: CollectionPresenter, ListPresenterInput {
  // MARK: - Essentials
  weak var view: UIViewController!
  weak var output : ListPresenterOutput?
  var viewModel: List.DataContext.ViewModel! {
    didSet {
      self.awaitableModel = self.viewModel
    }
  }
  var router : ListRoutingLogic?
  var interactor : ListInteractorInput?
  // MARK: - Initializers
  override init() {
    super.init()
    self.viewModel = List.DataContext.ViewModel()
  }
  deinit {
    print("ListPresenter deinit is called")
  }
  // MARK: - Presenter Input
  
  func refresh() {
    self.fetchItems(reset: true)
  }
  func fetch() {
    self.fetchItems(reset: false)
  }
  // MARK: - Startable
  override func start() {
    super.start()
    self.awaitableDelegate = self.output
    self.awaitableModel = self.viewModel
    self.collectionModel = self.viewModel
    self.fetchItems(reset: true)
  }
  // MARK: - Base overrides
  @discardableResult override func fetchItems(reset: Bool) -> (skip: Int, take: Int) {
    if self.viewModel.isBusy {
      return (0,0)
    }
    let skipTake = super.fetchItems(reset: reset)
    self.interactor?.requestItems(request: List.DataContext.Request(skip: skipTake.skip, take: skipTake.take))
    return skipTake
  }
  
  override func exitPendingState() {
    super.exitPendingState()
    self.viewModel.changeSet = []
  }
}
extension ListPresenter : ListInteractorOutput {
  // MARK: - Interactor output
  func didReceive(response: List.DataContext.Response) {
    if response.originalRequest.paginationParams.skip == 0 {
      self.viewModel.items = []
    }
    response.items.enumerated().forEach({ (offset, _) in
      self.viewModel.changeSet.append(.new(IndexPath(row: self.items.count + offset, section: 0)))
    })
    
    self.viewModel.items.append(contentsOf: response.items as [CollectionModel])
    self.output?.didChangeState(viewModel: self.viewModel)
  }
  func didFail(with error: Error) {
    self.exitPendingState()
  }
}
