//
//  NetworkService.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 17.05.2021.
//

import UIKit

protocol NetworkServiceProtocol {
    func getAccessToken(success: EmptyBlock?, failure: ErrorBlock?)
}

class NetworkService: NetworkServiceProtocol {
    func getAccessToken(success: EmptyBlock?, failure: ErrorBlock?) {
        
    }
}
