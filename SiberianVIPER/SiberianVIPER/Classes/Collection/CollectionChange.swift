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

extension CollectionChange: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.equalsTo(rhs)
  }
}

public extension CollectionChange {
  func equalsTo(_ other: CollectionChange) -> Bool {
    switch other {

    case .new(let otherIP):
      switch self {
      case .new(let selfIP):
        return otherIP == selfIP
      case .edit:
        return false
      case .delete:
        return false
      }
    case .edit(let otherIP):
      switch self {
      case .new:
        return false
      case .edit(let selfIP):
        return otherIP == selfIP
      case .delete:
        return false
      }
    case .delete(let otherIP):
      switch self {
      case .new:
        return false
      case .edit:
        return false
      case .delete(let selfIP):
        return otherIP == selfIP
      }
    }
  }
}
