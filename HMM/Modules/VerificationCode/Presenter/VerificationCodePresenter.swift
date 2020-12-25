//
//  VerificationCodePresenter.swift
//  HMM
//
//  Created by Abdullah on 10/05/1442 AH.
//

import Foundation
import FirebaseAuth

protocol VerificationCodeViewPresenter: class {
    func showIndicator()
    func hideIndicator()
    func showError(message: String)
    func getVerificationCode() -> String
    func successfullyVerified()
    func getVerificationID() -> String
    func navigateToWelcomeScreen()
    func navigateToHomeScreen()
}

class VerificationCodePresenter {
    
    private weak var view: VerificationCodeViewPresenter?
    
    init(view: VerificationCodeViewPresenter) {
        self.view = view
    }
    
    func checkVerificationCode() {
        self.view?.showIndicator()
        // check validation code
        if self.view?.getVerificationCode().count == 6 {
            if !(self.view?.getVerificationID().isEmpty)! {
                guard let verificationID = self.view?.getVerificationID() else { return }
                guard let verificationCode = self.view?.getVerificationCode() else { return }
                FirebaseAuth.provider.phoneAuthCredential(verificationID: verificationID, verificationCode: verificationCode) { (userID, error) in
                    if let error = error {
                        self.view?.showError(message: "رمز التفعيل المدخل غير صحيح")
                        self.view?.hideIndicator()
                        return
                    }
                    // successfully Verified
                    self.view?.successfullyVerified()
                }
            }else{
                // we don't have verificationID to continue login
                self.view?.navigateToWelcomeScreen()
            }
        }else{
            self.view?.showError(message: "يوجد خطأ في كتابة رمز التحقق")
        }
    }

    func backToWelcomeScreen() {
        self.view!.navigateToWelcomeScreen()
    }
}
