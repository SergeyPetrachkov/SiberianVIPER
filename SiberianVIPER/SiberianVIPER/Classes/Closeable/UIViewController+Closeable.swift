//
//  UIViewController+Closeable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation

extension UIViewController: Closeable {
  public func close(animated: Bool, completion: (() -> Void)?) {
    if let navigationController = self.navigationController {
      navigationController.popViewController(animated: animated)
    } else {
      self.dismiss(animated: animated, completion: completion)
    }
  }
}
