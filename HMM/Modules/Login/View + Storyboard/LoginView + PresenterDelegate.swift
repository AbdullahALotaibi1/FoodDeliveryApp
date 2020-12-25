//
//  LoginView + PresenterDelegate.swift
//  HMM
//
//  Created by Abdullah on 10/05/1442 AH.
//

import UIKit
import PhoneNumberKit
import Loady
extension LoginView: LoginViewPresenter {
    
    func showIndicator() {
        loginButton.setAnimation(LoadyAnimationType.topLine())
        loginButton.isEnabled = false
        loginButton.startLoading()
        self.view.endEditing(true)
    }
    
    func hideIndicator() {
        loginButton.isEnabled = true
        loginButton.stopLoading()
        phoneTextField.becomeFirstResponder()
    }
    
    func showError(message: String) {
        Vibration.error.vibrate()
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        self.containerViewTextField.layer.borderColor = UIColor(named: "Danger Color")?.cgColor
        self.containerViewTextField.backgroundColor = UIColor(named: "Danger Color")?.withAlphaComponent(0.05)
        self.phoneTextField.textColor = UIColor(named: "Danger Color")
    }
    
    func isValidNumber() -> Bool {
        return self.phoneTextField.isValidNumber
    }
    
    func getPhoneNumber() -> String {
        return self.phoneTextField.text!
    }
    
    func navigateToVerificationCodeScreen(verificationID: String, phoneNumber: String) {
        let storyboard = UIStoryboard(name: "VerificationCode", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VerificationCodeView") as! VerificationCodeView
        vc.modalPresentationStyle = .fullScreen
        vc.phoneNumber = phoneNumber
        vc.verificationID = verificationID
        self.present(vc, animated: true, completion: nil)
    }
    
    func navigateToWelcomeScreen() {
        self.dismiss(animated: true, completion: nil)
    }

}
