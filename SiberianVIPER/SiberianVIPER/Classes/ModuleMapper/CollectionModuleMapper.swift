//
//  CollectionModuleMapper.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 22/03/2018.
//  Copyright © 2018 Sergey Petrachkov. All rights reserved.
//

import Foundation

public protocol CollectionModuleMapper {
  associatedtype EntityType
  associatedtype ViewModelType
  func map(items: [EntityType]) -> [ViewModelType]
}
