//
//  WelcomeView.swift
//  HMM
//
//  Created by Abdullah on 06/05/1442 AH.
//

import UIKit
import PhoneNumberKit
import Hero


class WelcomeView: UIViewController {
    
    // MARK: - OutLet
    @IBOutlet weak var loginViewCard: UIView!
    @IBOutlet weak var loginScoialMediaViewCard: UIView!
    @IBOutlet weak var bottomConstraintLoginViewCard: NSLayoutConstraint!
    @IBOutlet weak var heigthConstraintLoginViewCard: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintSafeAreaView: NSLayoutConstraint! 
    @IBOutlet weak var bottomConstraintLoginScoialMediaCard: NSLayoutConstraint!
    @IBOutlet weak var containerViewTextField: UIView!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    @IBOutlet weak var labelTerms: UILabel!
    @IBOutlet weak var labelTerms2: UILabel!
    let textOfTerms = "استخدامك لهذا التطبيق يعني موافقتك على سياسة وشروط الإستخدام"
    
 
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // register hero id to Text Field
        containerViewTextField.heroID = "containerViewTextField"
        
        // call functions
        loginViewCard.addShadow()
        loginScoialMediaViewCard.addShadow()
        customContainerViewTextField()
        setPhoneNumberOptions()
        addLinkToLabelTerms()
        setAnimateLoginViewCard()
    }
    
    // MARK: - Customize Container View Text Field
    fileprivate func customContainerViewTextField() {
        containerViewTextField.layer.cornerRadius = 5
        containerViewTextField.layer.borderWidth = 1.5
        containerViewTextField.layer.borderColor = UIColor(hex: "#F6F6F6").cgColor
    }
    
    // MARK: - Set Phone Number Options
    fileprivate func setPhoneNumberOptions() {
        phoneTextField.withFlag = true
        phoneTextField.withPrefix = true
        phoneTextField.withExamplePlaceholder = true
        phoneTextField.countryCodePlaceholderColor = UIColor(hex: "#6F6F6F")
        phoneTextField.numberPlaceholderColor = UIColor(hex: "#BBBBBB")
    }
    
    // MARK:- Add Link To Label Terms
    fileprivate func addLinkToLabelTerms() {
        // label 1
        labelTerms.text = textOfTerms
        let underlineAttriString = NSMutableAttributedString(string: textOfTerms)
        let range1 = (textOfTerms as NSString).range(of: "سياسة وشروط الإستخدام")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "#3FC060"), range: range1)
        labelTerms.attributedText = underlineAttriString
        labelTerms.isUserInteractionEnabled = true
        labelTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabelTerms(gesture:))))
        
        // label 2
        labelTerms2.text = textOfTerms
        let underlineAttriString2 = NSMutableAttributedString(string: textOfTerms)
        let range12 = (textOfTerms as NSString).range(of: "سياسة وشروط الإستخدام")
        underlineAttriString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "#3FC060"), range: range12)
        labelTerms2.attributedText = underlineAttriString2
        labelTerms2.isUserInteractionEnabled = true
        labelTerms2.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabelTerms(gesture:))))
    }
    
    // MARK: - Set Animate Login View Card in View Did Load
    fileprivate func setAnimateLoginViewCard() {
        UIView.animate(withDuration: 0.4) { [self] in
            bottomConstraintLoginViewCard.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Move To Login Screen
    @IBAction func MoveToLoginScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginView") as! LoginView
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
    
    // On Tap Text Terms inside label open terms screen
    @IBAction func tapLabelTerms(gesture: UITapGestureRecognizer) {
       let termsRange = (textOfTerms as NSString).range(of: "سياسة وشروط الإستخدام")
        if gesture.didTapAttributedTextInLabel(label: self.labelTerms, inRange: termsRange)  {
            print("Move to Terms Screen")
        }
    }
    
    
    
    // MARK: - Open Login ScoialMedia Card
    @IBAction func openLoginScoialMediaCard(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4) { [self] in
            bottomConstraintLoginScoialMediaCard.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Close Login ScoialMedia Card
    @IBAction func closeLoginScoialMediaCard(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4) { [self] in
            bottomConstraintLoginScoialMediaCard.constant = -400
            self.view.layoutIfNeeded()
        }
    }
    
}
