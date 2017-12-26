//
//  CollectionChange.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 11/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

/// Represents atomic change in a collection
public enum CollectionChange {
  case new(IndexPath?)
  case edit(IndexPath)
  case delete(IndexPath)
}
