//
//  WelcomeEntities.swift
//  SiberianVIPER
//
//  Created by Sergey Petrachkov on 13/12/2017.
//  Copyright (c) 2017 Sergey Petrachkov. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit
import SiberianVIPER
enum Welcome {
  // MARK: - Use cases
  enum DataContext {
    struct Request {
    }
    struct Response {
      let text: String
    }
    struct ViewModel: BusyViewModel {
      var isBusy: Bool = false
      var text: String = ""
    }
  }
}
