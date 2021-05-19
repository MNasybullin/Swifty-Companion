//
//  ViewController.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 17.05.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARk: - Private Properties
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var searchButton: UIButton!
    @IBOutlet private var networkActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureNotificationCenter()
        screenConfigure()
    }
    
    func screenConfigure() {
        networkActivityIndicator.isHidden = true
        
        searchButton.layer.cornerRadius = 5
        searchButton.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.65)
        searchButton.isEnabled = false
    }

    // MARK: - Actions

    @IBAction func loginTextFieldAction(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }

        searchButton.isEnabled = !text.isEmpty
        if searchButton.isEnabled {
            searchButton.backgroundColor = UIColor(red: 0.25, green: 1, blue: 0.25, alpha: 0.65)
        } else {
            searchButton.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.65)
        }
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        print("pressed")
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
            scrollView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 0,
                                                   bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom,
                                                   right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
}

