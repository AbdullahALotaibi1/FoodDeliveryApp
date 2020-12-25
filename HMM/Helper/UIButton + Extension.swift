//
//  UIButton + Extension.swift
//  HMM
//
//  Created by Abdullah on 08/05/1442 AH.
//

import UIKit

class CustomSocialMediaButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            self.backgroundColor = UIColor(hex: "#F8F8F8")
            self.setTitleColor(UIColor(hex: "#162328"), for: .normal)
            self.layer.cornerRadius = 5
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}


extension CALayer {

    func animateBorderColor(from startColor: UIColor, to endColor: UIColor, withDuration duration: Double) {
        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = startColor.cgColor
        colorAnimation.toValue = endColor.cgColor
        colorAnimation.duration = duration
        self.borderColor = endColor.cgColor
        self.add(colorAnimation, forKey: "borderColor")
    }
}

 
