//
//  LoginViewPresenter.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 22.05.2021.
//

import UIKit

final class LoginViewPresenter: LoginViewOutputProtocol {
    // MARK: - Public Properties

    weak var input: LoginViewInputProtocol?
    weak var navigationController: UINavigationController?
    private let service: NetworkService
    
    init(input: LoginViewInputProtocol, navigationController: UINavigationController?) {
        self.input = input
        self.navigationController = navigationController
        self.service = NetworkService()
    }

    // MARK: - LoginViewOutputProtocol

    func searchProfile(_ login: String) {
        input?.activityIndicator(status: true)

        service.getProfile(login: login) { [weak self] profileData in
            self?.input?.activityIndicator(status: false)
            self?.showProfileScreen(data: profileData)
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

    private func showProfileScreen(data: ProfileData) {
        DispatchQueue.main.async { [weak self] in
            if let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
                viewController.profileData = data
                self?.navigationController?.pushViewController(viewController, animated: true)
               }
        }
    }
}
    
