//
//  CollectionPresenter.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 25/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
public protocol CollectionPresenterInput {
  @discardableResult func fetchItems(reset: Bool) -> (skip: Int, take: Int)
}

open class CollectionPresenter: SiberianPresenter, CollectionPresenterInput, SiberianCollectionSource {
  
  public var collectionModel: CollectionViewModel!
  @discardableResult open func fetchItems(reset: Bool) -> (skip: Int, take: Int) {
    if let busy = self.awaitableModel?.isBusy, busy {
      return (skip: 0, take: 0)
    }
    self.enterPendingState(visible: reset, blocking: reset)
    return self.performPrefetch(reset: reset)
  }
  @discardableResult open func performPrefetch(reset: Bool) -> (skip: Int, take: Int) {
    var skip: Int = self.collectionModel.items.count
    if reset {
      skip = 0
      self.collectionModel.changeSet = []
      self.collectionModel.items.enumerated().forEach({ (offset, _) in
        self.collectionModel.changeSet.append(.delete(IndexPath(row: offset,
                                                                section: 0)))
      })
    }
    return (skip: skip, take: self.collectionModel.batchSize)
  }
  open func modelForSectionHeader(at index: Int) -> CollectionModel? {
    return nil
  }
  
  open func heightForSectionHeader(at index: Int) -> CGFloat {
    return 0
  }
  
  open func modelForSectionFooter(at index: Int) -> CollectionModel? {
    return nil
  }
  
  open func heightForSectionFooter(at index: Int) -> CGFloat {
    return 0
  }
  
  open func modelForSection(at index: Int) -> CollectionModel? {
    return nil
  }
  
  open func numberOfSections() -> Int {
    return 1
  }
  
  open var items: [CollectionModel] {
    return self.collectionModel.items
  }
  
  open var changeSet: [CollectionChange] {
    return self.collectionModel.changeSet
  }
  
  open func item(for indexPath: IndexPath) -> CollectionModel? {
    if indexPath.row >= self.items.count {
      return nil
    }
    return self.items[indexPath.row]
  }
  
  open func numberOfItems(in section: Int) -> Int {
    return self.items.count
  }
}
