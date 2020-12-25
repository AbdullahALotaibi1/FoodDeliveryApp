//
//  Toast.swift
//  HMM
//
//  Created by Abdullah on 10/05/1442 AH.
//

import UIKit

class Toast {
    
    enum Showin {
        case top
    }
    

    static func show(message:String, showIn:Showin = .top, controller:UIViewController)
    {
        for item in controller.view.subviews
        {
            if item.tag == 12212121212121
            {
                item.removeFromSuperview()
            }
        }
        
        let toastView = UIView(frame: CGRect())
        toastView.backgroundColor = UIColor(hex: "#FFFBE6")
        toastView.layer.borderWidth = 1
        toastView.layer.borderColor = UIColor(hex: "#FFE58F").cgColor
        toastView.alpha = 0.0
        toastView.layer.cornerRadius = 5
        toastView.clipsToBounds = true
        self.addShadow(view: toastView)
        
        let toastIcon = UIImageView(frame: CGRect())
        toastIcon.image = UIImage(named: "waring-icon")
        toastIcon.contentMode = .scaleAspectFit
        toastView.addSubview(toastIcon)
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor(hex: "#41403E")
        toastLabel.textAlignment = .right
        toastLabel.text = message
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0
        toastLabel.font = UIFont(name:"DINNextLTArabic-Regular",size: 15)
        toastView.tag = 12212121212121
        toastView.addSubview(toastLabel)
        controller.view.addSubview(toastView)
        
        
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastIcon.translatesAutoresizingMaskIntoConstraints = false
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconConstraint1 = NSLayoutConstraint(item: toastIcon, attribute: .trailing, relatedBy: .equal, toItem: toastView, attribute: .trailing, multiplier: 1, constant: -16)
        let iconConstraint2 = NSLayoutConstraint(item: toastIcon, attribute: .top, relatedBy: .equal, toItem: toastView, attribute: .top, multiplier: 1, constant: 16)
        let iconConstraint3 = NSLayoutConstraint(item: toastIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 18)
        let iconConstraint4 = NSLayoutConstraint(item: toastIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 18)
        
        let lblConstraint1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastView, attribute: .leading, multiplier: 1, constant: 10)
        let lblConstraint2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastIcon, attribute: .leading, multiplier: 1, constant: -10)
        let lblConstraint3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastView, attribute: .bottom, multiplier: 1, constant: -16)
        let lblConstraint4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastView, attribute: .top, multiplier: 1, constant: 12)
        
        toastView.addConstraints([iconConstraint1,iconConstraint2,iconConstraint3,iconConstraint4])
        toastView.addConstraints([lblConstraint1,lblConstraint2,lblConstraint3,lblConstraint4])
        
        let toastView_c1 = NSLayoutConstraint(item: toastView, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 16)
        
        let toastView_c2 = NSLayoutConstraint(item: toastView, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -16)
        
        let toastView_c3 = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: controller.view.safeAreaLayoutGuide, attribute: .topMargin, multiplier: 1, constant: 10)
        
        controller.view.addConstraints([toastView_c1,toastView_c2,toastView_c3])
        
       

        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            toastView.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseOut, animations: {
                toastView.alpha = 0
            }) { (result) in
                toastView.removeFromSuperview()
            }
        }
    }
    
    // OUTPUT 1
    static func addShadow(scale: Bool = true, view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowPath = UIBezierPath(rect: view.layer.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
