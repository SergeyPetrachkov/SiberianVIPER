//
//  SiberianCollection.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit

public protocol SiberianCollectionSource: AnySiberianCollectionSource {
  associatedtype ItemType = CollectionItemPresenter
  var items: [ItemType] { get }
  
  var changeSet: [CollectionChange] { get }
  
  func item(for indexPath: IndexPath) -> ItemType?
  func numberOfItems(in section: Int) -> Int
  func numberOfSections() -> Int
}

public extension SiberianCollectionSource {
  var AnyType: CollectionItemPresenter.Type {
    return (ItemType.self as! CollectionItemPresenter.Type).self
  }
  
  func anyItem(for indexPath: IndexPath) -> CollectionItemPresenter? {
    return self.item(for: indexPath) as? CollectionItemPresenter
  }
  
  func numberOfAnyItems(in section: Int) -> Int {
    return self.numberOfItems(in: section)
  }
}

public protocol AnySiberianCollectionSource {
  var AnyType: CollectionItemPresenter.Type { get }
  // MARK: - Sections
  func numberOfSections() -> Int
  
  func modelForSectionHeader(at index: Int) -> CollectionItemPresenter?
  func heightForSectionHeader(at index: Int) -> CGFloat
  
  func modelForSectionFooter(at index: Int) -> CollectionItemPresenter?
  func heightForSectionFooter(at index: Int) -> CGFloat
  // MARK: - Items
  func anyItem(for indexPath: IndexPath) -> CollectionItemPresenter?
  func numberOfAnyItems(in section: Int) -> Int
}

open class SiberianTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {

  open private(set) var provider: AnySiberianCollectionSource
  open weak var delegate: SiberianCollectionDelegate?
  open weak var fetchDelegate: CollectionPresenterInput?

  public init(provider: AnySiberianCollectionSource,
              delegate: SiberianCollectionDelegate? = nil,
              fetchDelegate: CollectionPresenterInput? = nil) {
    self.provider = provider
    super.init()
    self.delegate = delegate
    self.fetchDelegate = fetchDelegate
  }
  
  open func numberOfSections(in tableView: UITableView) -> Int {
    return self.provider.numberOfSections()
  }
  
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.provider.numberOfAnyItems(in: section)
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let model = self.provider.anyItem(for: indexPath) {
      let cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
      model.setupAny(view: cell)
      return cell
    } else {
      fatalError("An error occured while trying to access SiberianTableSource item at indexPath:\(indexPath)")
    }
  }
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let model = self.provider.anyItem(for: indexPath) {
      self.delegate?.didSelect(item: model,
                               at: indexPath)
    }
    
    tableView.deselectRow(at: indexPath,
                          animated: true)
  }
  
  open func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let bottomEdge = targetContentOffset.pointee.y + scrollView.frame.size.height
    if bottomEdge >= scrollView.contentSize.height {
      _ = try? self.fetchDelegate?.fetchItems(reset: false)
    }
  }
}

open class SiberianCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  private var scrollDirection: UICollectionView.ScrollDirection
  
  open private(set) var provider: AnySiberianCollectionSource
  
  open weak var delegate: SiberianCollectionDelegate?
  open weak var fetchDelegate: CollectionPresenterInput?

  open var defaultCellHeight: CGFloat {
    return 44
  }
  
  public init(provider: AnySiberianCollectionSource,
              scrollDirection: UICollectionView.ScrollDirection = .vertical) {
    self.provider = provider
    self.scrollDirection = scrollDirection
    super.init()
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             numberOfItemsInSection section: Int) -> Int {
    return self.provider.numberOfAnyItems(in: section)
  }
  
  open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = self.provider.anyItem(for: indexPath) else {
      return
    }
    self.delegate?.didSelect(item: item, at: indexPath)
    collectionView.deselectItem(at: indexPath, animated: true)
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let model = self.provider.anyItem(for: indexPath) {
      let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)
      model.setupAny(view: cell)
      return cell
    } else {
      fatalError("An error occured while trying to access SiberianTableSource item at indexPath:\(indexPath)")
    }
  }
  
  open func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: self.defaultCellHeight)
  }
  
  open func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                      withVelocity velocity: CGPoint,
                                      targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let edge = self.scrollDirection == .horizontal
      ? targetContentOffset.pointee.x + scrollView.frame.size.width
      : targetContentOffset.pointee.y + scrollView.frame.size.height
    let contentDimension = self.scrollDirection == .horizontal
      ? scrollView.contentSize.width
      : scrollView.contentSize.height
    if edge >= contentDimension {
      _ = try? self.fetchDelegate?.fetchItems(reset: false)
    }
  }
}
