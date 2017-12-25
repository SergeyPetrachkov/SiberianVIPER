//
//  CellViewModel.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit

protocol SelfSizingModel {
  func getSize() -> CGSize
}

public protocol CollectionModel {
  static var cellAnyType: UIView.Type { get }
  func setupAny(view: UIView)
}

public protocol CollectionModelGeneric: CollectionModel {
  associatedtype ViewType: UIView
  func setup(view: ViewType)
}

public extension CollectionModelGeneric {
  var viewAnyType: UIView.Type {
    return ViewType.self
  }
  func setupAny(view: UIView) {
    setup(view: view as! ViewType)
  }
}
