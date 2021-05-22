//
//  LoginViewProtocols.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 22.05.2021.
//

import Foundation

protocol LoginViewInputProtocol: AnyObject {
    func activityIndicator(status: Bool)
}

protocol LoginViewOutputProtocol: AnyObject {
    func searchProfile(_ login: String)
}
