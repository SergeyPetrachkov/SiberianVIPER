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
public protocol SiberianCollectionSource {
  associatedtype ItemType = CellViewModel.Type
  var items: [ItemType] { get set }
  
  var changeSet: [CollectionChange]? { get set }
  
  func item(for indexPath: IndexPath) -> ItemType
  func numberOfItems(in section: Int) -> Int
}
