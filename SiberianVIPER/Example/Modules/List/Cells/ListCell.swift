//
//  ListCell.swift
//  Example
//
//  Created by Sergey Petrachkov on 25/12/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit
import SiberianVIPER

struct Item {
  let textContent: String
  let number: Int
}

struct ListItemModel: CollectionModelGeneric {
  static var anyViewType: UIView.Type {
    return ListCell.self
  }
  
  let currentModel: Item
  
  func setup(view: ListCell) {
    view.textContentLabel.text = self.currentModel.textContent
    view.numberLabel.text = "\(self.currentModel.number)"
  }
}
class ListCell: UITableViewCell {
  @IBOutlet weak var textContentLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
}
