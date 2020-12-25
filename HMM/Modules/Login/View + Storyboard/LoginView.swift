//
//  Login.swift
//  HMM
//
//  Created by Abdullah on 07/05/1442 AH.
//

import UIKit
import PhoneNumberKit
import Hero
import IQKeyboardManagerSwift
import Loady
import ContactsUI


class LoginView: UIViewController, CNContactPickerDelegate {
    
    // MARK: - OutLet
    @IBOutlet weak var containerViewTextField: UIView!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    @IBOutlet weak var bottomConstraintButtonLogin: NSLayoutConstraint!
    @IBOutlet weak var loginButton: LoadyButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Connect View by Presenter
    var presenter: LoginPresenter!
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
        
        IQKeyboardManager.shared.enableAutoToolbar = false
        phoneTextField.addTarget(self, action: #selector(self.textFieldEditing(_:)), for: .editingChanged)
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
        // register hero id to Text Field
        containerViewTextField.heroID = "containerViewTextField"
        phoneTextField.delegate = self
        setPhoneNumberOptions()
        customContainerViewTextField()
        customLoginButton()
        
        // Notification On Show Keyboard to get hieght And Hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Set Phone Number Options
    fileprivate func setPhoneNumberOptions() {
        phoneTextField.withFlag = true
        phoneTextField.withPrefix = true
        phoneTextField.withExamplePlaceholder = true
        phoneTextField.withDefaultPickerUI = true
        phoneTextField.countryCodePlaceholderColor = UIColor(hex: "#6F6F6F")
        phoneTextField.numberPlaceholderColor = UIColor(hex: "#BBBBBB")
    }
    
    // MARK: - Customize Container View Text Field
    fileprivate func customContainerViewTextField() {
        containerViewTextField.layer.cornerRadius = 5
        containerViewTextField.layer.borderWidth = 1.5
        containerViewTextField.layer.borderColor = UIColor(hex: "#F6F6F6").cgColor
    }
    
    // MARK: - Customize Login Button
    fileprivate func customLoginButton() {
        loginButton.layer.cornerRadius = 5
    }
    
    // MARK: - Keyboard Will Show
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.2) { [self] in
                self.bottomConstraintButtonLogin.constant = keyboardHeight + 16
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Keyboard Will Show
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2) { [self] in
            self.bottomConstraintButtonLogin.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Dismiss To back to welocme screen
    @IBAction func dismissAction(_ sender: Any) {
        presenter.backToWelcomeScreen()
    }
    
    // MARK: - Login Action
    @IBAction func loginAction(_ sender: UIButton) { presenter.loginAction() }
    
    // MARK: - Remove Effect An Show Error Message
    fileprivate func removeEffectErrorMessage() {
        errorMessageLabel.isHidden = true
        self.containerViewTextField.layer.borderColor = UIColor(named: "Primary Color")?.cgColor
        self.containerViewTextField.backgroundColor = UIColor(named: "Primary Color")?.withAlphaComponent(0.05)
        self.phoneTextField.textColor = UIColor(named: "Secondary Color")
    }

}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        self.phoneTextField.becomeFirstResponder()
    }
    
    
    // MARK: - Func Text Field  Editing
    @objc func textFieldEditing(_ textField: PhoneNumberTextField) {
        loginButton.isEnabled = textField.text!.isEmpty ? false : true
        loginButton.alpha = textField.text!.isEmpty ? 0.5 : 1
        removeEffectErrorMessage()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerViewTextField.layer.animateBorderColor(from: UIColor(hex: "#F6F6F6"), to: UIColor(hex: "#3FC060"), withDuration: 0.2)
        UIView.animate(withDuration: 0.2) { [self] in
            containerViewTextField.backgroundColor = UIColor(hex: "#3FC060").withAlphaComponent(0.05)
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerViewTextField.layer.animateBorderColor(from: UIColor(hex: "#3FC060"), to: UIColor(hex: "#F6F6F6"), withDuration: 0.2)
        UIView.animate(withDuration: 0.2) { [self] in
            containerViewTextField.backgroundColor = UIColor(hex: "#FDFDFD").withAlphaComponent(0.1)
            self.view.layoutIfNeeded()
        }
    }
    
}
