//
//  UIKit+Siberia.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 11/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
  func dequeueReusableCell<T: CollectionModelGeneric>(withModel model: T, for indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: T.ViewType.self)
    let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    if let cell = cell as? T.ViewType {
      model.setup(view: cell)
    }
    return cell
  }
  
  func dequeueReusableCell(withModel model: CollectionModel, for indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: type(of: model).anyViewType)
    let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    model.setupAny(view: cell)
    return cell
  }
  
}

public extension UICollectionView {
  
  func dequeueReusableCell<T: CollectionModelGeneric>(withModel model: T, for indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: T.ViewType.self)
    let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    if let cell = cell as? T.ViewType {
      model.setup(view: cell)
    }
    return cell
  }
  
  func dequeueReusableCell(withModel model: CollectionModel, for indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: type(of: model).anyViewType)
    let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    model.setupAny(view: cell)
    return cell
  }
}
