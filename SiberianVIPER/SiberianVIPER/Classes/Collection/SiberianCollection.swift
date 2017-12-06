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
  func numberOfSections() -> Int
  
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

public protocol AnySiberianCollectionSource {
  var AnyType: CellViewAnyModel.Type { get }
  
  func anyItem(for indexPath: IndexPath) -> CellViewAnyModel?
  func numberOfAnyItems(in section: Int) -> Int
  func numberOfSections() -> Int
}


open class SiberianTableSource: NSObject, UITableViewDataSource {
  public fileprivate(set) var provider: AnySiberianCollectionSource!
  
  fileprivate override init() {
    super.init()
  }
  
  public convenience init(provider: AnySiberianCollectionSource) {
    self.init()
    self.provider = provider
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
      model.setupAny(cell: cell)
      return cell
    } else {
      fatalError("An error occured while trying to access SiberianTableSource item at indexPath:\(indexPath)")
    }
  }
}

public protocol SiberianCollectionDelegate: class {
  func didSelect(item: CellViewAnyModel, at indexPath: IndexPath)
}
