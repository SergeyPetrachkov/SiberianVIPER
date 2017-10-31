//
//  SiberianCollection.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

/// Represents atomic change in a collection
public enum CollectionChange {
  case new(IndexPath?)
  case edit(IndexPath)
  case delete(IndexPath)
}

/// Protocol that is an abstraction over average datasource. Use it in ViewModels of table/collection modules
///
///
///            class SiberianBaseCollectionSource: NSObject, SiberianCollectionSource {
///              var items: [NoteViewModel] = []
///
///              var changeSet: [CollectionChange]?
///
///              func item(for indexPath: IndexPath) -> NoteViewModel {
///                return self.items[indexPath.row]
///              }
///
///              func numberOfItems(in section: Int) -> Int {
///                return self.items.count
///              }
///            }
///            struct NoteViewModel {
///              let reuseId = "NoteCell.reuseIdentifier"
///
///              let id: String
///              var text: String
///            }
///
///            extension NoteViewModel: CellViewModel {
///              func setup(cell: NoteCell) {
///                cell.textLabel?.text = self.text
///              }
///            }
///
///            class NoteCell: UITableViewCell {
///
///            }
public protocol SiberianCollectionSource: AnySiberianCollectionSource {
  associatedtype ItemType = CellViewAnyModel
  var items: [ItemType] { get }
  
  var changeSet: [CollectionChange] { get }
  
  func item(for indexPath: IndexPath) -> ItemType?
  func numberOfItems(in section: Int) -> Int
  
}
public extension SiberianCollectionSource {
  var AnyType: CellViewAnyModel.Type {
    return (ItemType.self as! CellViewAnyModel.Type).self
  }
  
  func anyItem(for indexPath: IndexPath) -> CellViewAnyModel? {
    return self.item(for: indexPath) as? CellViewAnyModel
  }
  
  func numberOfAnyItems(in section: Int) -> Int {
    return self.numberOfItems(in: section)
  }
  
}


open class SiberianCollectionDataSource<Provider: SiberianCollectionSource>: NSObject, UICollectionViewDataSource {
  var provider: Provider?
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.provider?.numberOfItems(in: section) ?? 0
  }
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let provider = self.provider else {
      fatalError("nil provider must never ever happen")
    }
    let model = provider.item(for: indexPath) as! CellViewAnyModel
    let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)
    model.setupAny(cell: cell)
    return cell
  }
}

open class SiberianTableDataSource<Provider: SiberianCollectionSource>: NSObject, UITableViewDataSource {
  var provider: Provider?
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let provider = self.provider else {
      fatalError("nil provider must never ever happen")
    }
    let model = provider.item(for: indexPath) as! CellViewAnyModel
    let cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
    model.setupAny(cell: cell)
    return cell
  }
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.provider?.numberOfItems(in: section) ?? 0
  }
}


struct NoteViewModel1 {
  let reuseId = " NoteCell.reuseIdentifier"
  let id: String
  var text: String
  
  
}

extension NoteViewModel1: CellViewModel {
  static var cellAnyType: UIView.Type {
    return UITableViewCell.self
  }
  
  func setup(cell: UITableViewCell) {
    cell.textLabel?.text = self.text
  }
}

public protocol AnySiberianCollectionSource {
  static var AnyType: CellViewAnyModel.Type { get }
  
  func anyItem(for indexPath: IndexPath) -> CellViewAnyModel?
  func numberOfAnyItems(in section: Int) -> Int
}


open class SiberianTableSource: NSObject, UITableViewDataSource {
  public var ds: AnySiberianCollectionSource!
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ds.numberOfAnyItems(in: section)
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let model = self.ds.anyItem(for: indexPath) {
      let cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
      model.setupAny(cell: cell)
      return cell
    } else {
      fatalError("adf")
    }
  }
}
