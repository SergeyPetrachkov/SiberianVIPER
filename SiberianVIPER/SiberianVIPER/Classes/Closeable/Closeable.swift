//
//  Closeable.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 31/10/2017.
//  Copyright © 2017 Sergey Petrachkov. All rights reserved.
//

import Foundation
import UIKit

public protocol Closeable {
  func close(animated: Bool, completion: (() -> Void)?)
}
