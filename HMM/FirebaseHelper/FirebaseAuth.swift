//
//  FirebaseAuth.swift
//  HMM
//
//  Created by Abdullah on 10/05/1442 AH.
//

import Foundation
import FirebaseAuth




class FirebaseAuth {
    
    static var provider = FirebaseAuth()

    func verifyPhoneNumber(phoneNumber: String, complation: @escaping (_ verificationID: String?, Error?) -> Void)  {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                complation("", error)
            }
            guard let verificationID = verificationID else { return }
            complation(verificationID, nil)
        }
    }
    
    func phoneAuthCredential(verificationID: String, verificationCode: String, complation: @escaping (_ userID: String?, Error?) -> Void) {
        // create Auth Credential
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        // SignIn User
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                complation(nil, error)
            }else {
                complation(user?.additionalUserInfo?.providerID, nil)
                print("User ID =>>> \(user?.additionalUserInfo?.providerID)")
                print("Logged")
            }
        }
    }
}
