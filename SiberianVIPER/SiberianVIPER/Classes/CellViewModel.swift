//
//  CellViewModel.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit

public protocol CellViewAnyModel {
  static var cellAnyType: UIView.Type { get }
  func setupAny(cell: UIView)
}
/// Use this protocol to represent UICollectionViewCell or UITableViewCell data context
///
///       struct NoteViewModel {
///         let reuseId = NoteCell.reuseIdentifier
///
///         let id: String
///         var text: String
///
///         var participants: [UserViewModel]
///       }
///
///       extension NoteViewModel: CellViewModel {
///         func setup(cell: NoteCell) {
///           cell.textLabel?.text = self.text
///         }
///       }
///
///       // Then somewhere in your datasource/display manager
///
///       let viewModel = self.items[indexPath.row]
///       let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseId) as! NoteCell
///       viewModel.setupAny(cell: cell)
///
/// So you control and configure your cells through their view models
/// This is encouraged by one of CocoaHeads meetups
public protocol CellViewModel: CellViewAnyModel {
  associatedtype CellType: UIView
  func setup(cell: CellType)
}

public extension CellViewModel {
  var cellAnyType: UIView.Type {
    return CellType.self
  }
  func setupAny(cell: UIView) {
    setup(cell: cell as! CellType)
  }
}

public extension UITableView {
  func dequeueReusableCell<T: CellViewModel>(withModel model: T, for indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: T.CellType.self)
    let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    if let cell = cell as? T.CellType {
      model.setup(cell: cell)
    }
    return cell
  }
  
  func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: type(of: model).cellAnyType)
    let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    model.setupAny(cell: cell)
    return cell
  }
}

public extension UICollectionView {
  
  func dequeueReusableCell<T: CellViewModel>(withModel model: T, for indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: T.CellType.self)
    let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    if let cell = cell as? T.CellType {
      model.setup(cell: cell)
    }
    return cell
  }
  
  public func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: type(of: model).cellAnyType)
    let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    model.setupAny(cell: cell)
    return cell
  }
}
