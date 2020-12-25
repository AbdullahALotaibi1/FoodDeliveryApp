//
//  VerificationCode + PresenterDelegate.swift
//  HMM
//
//  Created by Abdullah on 10/05/1442 AH.
//

import UIKit

extension VerificationCodeView: VerificationCodeViewPresenter {
    
    func showIndicator() {
        self.view.endEditing(true)
        checkVerificationCodeView.isHidden = false
        loadingIndicator.startAnimating()
        labelAnimatedCheckCodeView.layer.bottomAnimation(duration: 0.3)
        phoneNumberLabelAnimatedCheckCodeView.layer.bottomAnimation(duration: 0.3)
    }
    
    func hideIndicator() {
        self.codeTextField.becomeFirstResponder()
        self.codeTextField.text = ""
        for code in 1...OPTTextFieldArray.count {
            OPTTextFieldArray[code-1].text = ""
            self.removeActiveTextField(code: code)
        }
        self.removeActiveTextField(code: 0)
        checkVerificationCodeView.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    func showError(message: String) {
        Toast.show(message: message, controller: self)
        Vibration.error.vibrate()
    }
    
    func getVerificationCode() -> String {
        return self.codeTextField.text!
    }
    
    func successfullyVerified() {
        Vibration.success.vibrate()
        loadingIndicator.stopAnimating()
        successImage.isHidden = false
        labelAnimatedCheckCodeView.layer.topAnimation(duration: 0.5)
        labelAnimatedCheckCodeView.textColor = UIColor(named: "Primary Color")
        labelAnimatedCheckCodeView.text = "تم التحقق من رقم الجوال"
        phoneNumberLabelAnimatedCheckCodeView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            self.successImageHeightConstriant.constant = 105
            self.view.layoutIfNeeded()
        } completion: { (_) in
            UIView.animate(withDuration: 0.2) {
                self.successImageHeightConstriant.constant = 85
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func getVerificationID() -> String {
        guard let verificationID = verificationID else { return "" }
        return verificationID
    }
 
    
    func navigateToWelcomeScreen() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func navigateToHomeScreen() {
           
    }
}
