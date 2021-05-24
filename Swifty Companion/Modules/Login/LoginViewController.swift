//
//  LoginViewController.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 17.05.2021.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Private Properties

    private var output: LoginViewOutputProtocol!

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var searchButton: UIButton!
    @IBOutlet private var historyButton: UIButton!
    @IBOutlet private var networkActivityIndicator: UIActivityIndicatorView!

    private var login: String!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output = LoginViewPresenter(input: self, navigationController: navigationController)
        self.hideKeyboardWhenTappedAround()
        configureNotificationCenter()
        screenConfigure()
    }
    
    func screenConfigure() {
        networkActivityIndicator.hidesWhenStopped = true
        
        searchButton.layer.cornerRadius = 5
        searchButton.setBackgroundColor(color: UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.65), forState: .disabled)
        searchButton.setBackgroundColor(color: UIColor(red: 0.25, green: 1, blue: 0.25, alpha: 0.65), forState: .normal)
        searchButton.isEnabled = false
    }

    // MARK: - Actions

    @IBAction func historyButtonAction(_ sender: UIButton) {
    }

    @IBAction func loginTextFieldAction(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        login = text
        searchButton.isEnabled = !text.isEmpty
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        if networkActivityIndicator.isAnimating == false {
            output.searchProfile(login)
        }
    }

    // MARK: - Keyboard Notifications

    func configureNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            let scrollConstant: CGFloat = 50
            var scrollHeight = keyboardViewEndFrame.minY - searchButton.frame.maxY
            if keyboardViewEndFrame.minY < searchButton.frame.maxY {
                scrollHeight = (scrollHeight * -1) + scrollConstant
            } else {
                scrollHeight = scrollConstant
            }
            scrollView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 0,
                                                   bottom: scrollHeight,
                                                   right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
}

// MARK: - Input Protocol

extension LoginViewController: LoginViewInputProtocol {
    func activityIndicator(status: Bool) {
        DispatchQueue.main.async { [weak self] in
            if status == true {
                self?.networkActivityIndicator.startAnimating()
            } else {
                self?.networkActivityIndicator.stopAnimating()
            }
        }
    }

    func showErrorAlert(with message: String) {
        activityIndicator(status: false)

        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Error",
                                                    message: message,
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK",
                                            style: .cancel,
                                            handler: nil)
            alertController.addAction(alertAction)
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

