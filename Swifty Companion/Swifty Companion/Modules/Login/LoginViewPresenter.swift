//
//  LoginViewPresenter.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 22.05.2021.
//

import Foundation

final class LoginViewPresenter: LoginViewOutputProtocol {
    // MARK: - Public Properties

    weak var input: LoginViewInputProtocol?
    
    init(input: LoginViewInputProtocol) {
        self.input = input
    }

    // MARK: - LoginViewOutputProtocol

    func searchProfile(_ login: String) {
        input?.activityIndicator(status: true)
    }
}
    
