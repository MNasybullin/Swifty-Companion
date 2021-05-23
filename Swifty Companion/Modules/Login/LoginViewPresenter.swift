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
    private let service: NetworkService
    
    init(input: LoginViewInputProtocol) {
        self.input = input
        self.service = NetworkService()
    }

    // MARK: - LoginViewOutputProtocol

    func searchProfile(_ login: String) {
        getAccessToken()
    }

    private func getAccessToken() {
        input?.activityIndicator(status: true)

        service.getAccessToken { [weak self] in
            self?.input?.activityIndicator(status: false)
        } failure: { [weak self] error in
            var message: String
            if let nsError = error as NSError? {
                message = nsError.domain
            } else {
                message = "Unknown error"
            }
            self?.input?.showErrorAlert(with: message)
        }
    }
}
    
