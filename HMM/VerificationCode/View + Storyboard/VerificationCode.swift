//
//  VerificationCode.swift
//  HMM
//
//  Created by Abdullah on 09/05/1442 AH.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAuth

class VerificationCodeView: UIViewController {
    
    // MARK: - PhoneNumber + TextField Array + Connect to presenter
    var phoneNumber: String?
    var verificationID: String?
    var OPTTextFieldArray : [UITextField] = []
    var presenter: VerificationCodePresenter!
    
    // MARK: - OutLet
    @IBOutlet weak var firstCodeTextField: CustomTextField!
    @IBOutlet weak var secondCodeTextField: CustomTextField!
    @IBOutlet weak var thirdCodeTextField: CustomTextField!
    @IBOutlet weak var fourthCodeTextField: CustomTextField!
    @IBOutlet weak var fifthCodeTextField: CustomTextField!
    @IBOutlet weak var sixthCodeTextField: CustomTextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var reSendTimerLabel: UILabel!
    @IBOutlet weak var reSendCodeButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var checkVerificationCodeView: UIView! {didSet{checkVerificationCodeView.isHidden = true}}
    @IBOutlet weak var labelAnimatedCheckCodeView: UILabel!
    @IBOutlet weak var phoneNumberLabelAnimatedCheckCodeView: UILabel!
    @IBOutlet weak var successImageHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var successImage: UIView! {didSet{successImage.isHidden = true}}
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = VerificationCodePresenter(view: self)
        
        // set real number
        if let phoneNumber = phoneNumber {
            phoneNumberLabel.text = phoneNumber.removeWhitespace()
            phoneNumberLabelAnimatedCheckCodeView.text = phoneNumber.removeWhitespace()
        }
        
        // Set TextFields in array
        OPTTextFieldArray = [firstCodeTextField, secondCodeTextField, thirdCodeTextField, fourthCodeTextField, fifthCodeTextField, sixthCodeTextField]
        customDesignTextField()
        setupCodeTextField()
    }
    
    
    // MARK: - Customize Text Field Design
    func customDesignTextField()  {
        for textField in OPTTextFieldArray {
            textField.placeholderColor(color: UIColor(hex: "#C7C7C7"))
        }
    }
    
    // MARK: - Active Text Field
    func activeTextField(code: Int) {
        OPTTextFieldArray[code-1].layer.animateBorderColor(from: UIColor(hex: "#F6F6F6"), to: UIColor(hex: "#3FC060"), withDuration: 0.2)
        UIView.animate(withDuration: 0.2) { [self] in
            OPTTextFieldArray[code-1].backgroundColor = UIColor(hex: "#3FC060").withAlphaComponent(0.1)
            OPTTextFieldArray[code-1].textColor = UIColor(hex: "#3FC060")
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Remove Active Text Field
    func removeActiveTextField(code: Int) {
        if (code < OPTTextFieldArray.count) {
            OPTTextFieldArray[code].text = ""
            OPTTextFieldArray[code].layer.animateBorderColor(from: UIColor(hex: "#F6F6F6"), to: UIColor(hex: "#F6F6F6"), withDuration: 0.2)
            UIView.animate(withDuration: 0.2) { [self] in
                OPTTextFieldArray[code].backgroundColor = UIColor(hex: "#FDFDFD").withAlphaComponent(0.1)
                OPTTextFieldArray[code].textColor = UIColor(hex: "#162328")
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Func Text Field Editing
    /* DESC: - Through this function, I enter the sms code for each field through a loop
     that takes the value from a hidden field and distributes the code to the fields
     shown to the user and adds a custom design to the field */
    @objc func textFieldEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            firstCodeTextField.text = ""
            removeActiveTextField(code: 0)
        }else{
            for code in 1...textField.text!.count {
                if code == textField.text?.count {
                    activeTextField(code: code)
                    removeActiveTextField(code: code)
                }
                if let text = textField.text {
                    let codeChar = text[text.index(text.startIndex, offsetBy: code - 1)]
                    OPTTextFieldArray[code-1].text = String(codeChar)
                    
                    // Check Verification Code
                    if code == OPTTextFieldArray.count {
                        self.presenter.checkVerificationCode()
                    }
                }
            }
        }
    }
    
    // MARK: - Dismiss To back to welocme screen
    @IBAction func dismissAction(_ sender: Any) {
        presenter.backToWelcomeScreen()
    }
    
}



extension VerificationCodeView: UITextFieldDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        self.codeTextField.becomeFirstResponder()
    }
    
    func setupCodeTextField() {
        codeTextField.addTarget(self, action: #selector(self.textFieldEditing(_:)), for: .editingChanged)
        codeTextField.delegate = self
    }
    
    // MARK: - count char of code OTP
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text!.count < OPTTextFieldArray.count || string == ""
    }
}
