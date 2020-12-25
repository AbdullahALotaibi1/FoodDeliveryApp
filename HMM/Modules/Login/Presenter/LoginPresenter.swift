//
//  LoginPresenter.swift
//  HMM
//
//  Created by Abdullah on 10/05/1442 AH.
//

import Foundation
import PhoneNumberKit
import FirebaseAuth

protocol LoginViewPresenter: class {
    func showIndicator()
    func hideIndicator()
    func showError(message: String)
    func isValidNumber() -> Bool
    func getPhoneNumber() -> String
    func navigateToVerificationCodeScreen(verificationID: String, phoneNumber: String)
    func navigateToWelcomeScreen()
}

class LoginPresenter {
    
    private weak var view: LoginViewPresenter?
    
    init(view: LoginViewPresenter){
        self.view = view
    }
    
    func loginAction() {
        // check valid number
        if self.view!.isValidNumber() {
            self.view?.showIndicator()
            
            // here code send sms code
            guard let phoneNumber = self.view?.getPhoneNumber() else { return }
            
            // Firebase Provider Phone Auth
            FirebaseAuth.provider.verifyPhoneNumber(phoneNumber: phoneNumber) { (verificationID, error) in
                if let error = error {
                    self.view?.showError(message: error.localizedDescription)
                    return
                }
                guard let verificationID = verificationID else { return }
                self.view?.navigateToVerificationCodeScreen(verificationID: verificationID, phoneNumber: phoneNumber)
            }
        }else{
            self.view?.showError(message: " الرجاء التاكد من صغية الرقم المدخل")
            self.view?.hideIndicator()
        }
    }
    
    func backToWelcomeScreen() {
        self.view?.navigateToWelcomeScreen()
    }
}
