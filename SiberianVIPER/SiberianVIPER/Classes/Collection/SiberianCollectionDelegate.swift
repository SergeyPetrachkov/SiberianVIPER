//
//  SiberianCollectionDelegate.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 11/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

public protocol SiberianCollectionDelegate: AnyObject {
  func didSelect(item: CollectionModel, at indexPath: IndexPath)
}
