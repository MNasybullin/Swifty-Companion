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
        let accessTokenOperation = AccessTokenOperation()

        accessTokenOperation.success = { credential in
            print("credential = ", credential)
        }
        accessTokenOperation.failure = { error in
            print("error = ", error)
        }

        let operationQueue = OperationQueue()
        operationQueue.addOperation(accessTokenOperation)
    }
}
