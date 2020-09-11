//
//  CellViewModel.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit

public protocol SelfSizingModel {
  func getSize() -> CGSize
}

@available(*, deprecated, message: "Stick to more VIPERish CollectionItemPresenter")
public typealias CollectionModel = CollectionItemPresenter
public protocol CollectionItemPresenter {
  static var anyViewType: UIView.Type { get }
  func setupAny(view: UIView)
}

@available(*, deprecated, message: "Stick to more VIPERish GenericCollectionItemPresenter")
public typealias CollectionModelGeneric = GenericCollectionItemPresenter
public protocol GenericCollectionItemPresenter: CollectionItemPresenter {
  associatedtype ViewType: UIView
  func setup(view: ViewType)
}

public extension GenericCollectionItemPresenter {
  var viewAnyType: UIView.Type {
    return ViewType.self
  }
  func setupAny(view: UIView) {
    setup(view: view as! ViewType)
  }
}
