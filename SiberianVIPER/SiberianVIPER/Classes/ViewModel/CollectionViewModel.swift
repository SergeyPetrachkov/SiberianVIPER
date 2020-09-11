//
//  CollectionViewModel.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 22/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

public protocol CollectionViewModel: BusyViewModel {
  var batchSize: Int { get set }
  var items: [CollectionItemPresenter] { get set }
  var changeSet: [CollectionChange] { get set }
}
