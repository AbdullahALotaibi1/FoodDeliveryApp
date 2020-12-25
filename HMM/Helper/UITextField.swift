//
//  CustomTextField.swift
//  HMM
//
//  Created by Abdullah on 06/05/1442 AH.
//

import UIKit


// MARK: - CustomTextField
class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 5
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(hex: "#F6F6F6").cgColor
        layer.masksToBounds = true
    }
    
}



// MARK: - CustomPhoneTextField
class CustomPhoneTextField: CustomTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButtonSelectFlag()
      
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addButtonSelectFlag()
    }
    
   
    func addButtonSelectFlag() {
        
        // Container View
        // But insied the container button have flag country + label of code the country
        let containerFlagView = UIView(frame: CGRect(x: 0, y: 0, width: layer.bounds.width * 0.30, height: layer.bounds.height))
        containerFlagView.backgroundColor = .clear
        let buttonFlag = UIButton(frame: CGRect(x: 0, y: 0, width: containerFlagView.frame.width, height: containerFlagView.frame.height))
        buttonFlag.setImage(UIImage(named: "Flag-SA"), for: .normal)
        buttonFlag.setTitle(" +966", for: .normal)
        buttonFlag.titleLabel?.font =  UIFont(name: "DINNextLTArabic-Medium", size: 15)
        buttonFlag.setTitleColor(UIColor(hex: "#6F6F6F"), for: .normal)
        containerFlagView.addSubview(buttonFlag)
        self.leftView = containerFlagView
        self.leftViewMode = .always
    }
}


extension UITextField {
    
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
        ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
    
}
