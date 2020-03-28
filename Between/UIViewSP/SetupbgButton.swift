//
//  SetupbgButton.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/2/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class SetupbgButton: UIView {

        private let repeatAnimationKey = "RepeatAnimationKey"
        private let repeatAnimation = CAAnimationGroup()
        
        private let replicatorLayer = CAReplicatorLayer()
        private let circleLayer = CALayer()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setUp()
        }
        
        func setUp() {
            isUserInteractionEnabled = false
            
            //set circle load
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 8, height: 8)
            circleLayer.position = CGPoint(x: 4, y: 5)
            circleLayer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            circleLayer.cornerRadius = 4
            circleLayer.opacity = 3 // độ mờ
            //?
            circleLayer.transform = CATransform3DMakeTranslation(0, 6, 0)
            replicatorLayer.addSublayer(circleLayer)
            //so hinh tron
            replicatorLayer.instanceCount = 3
            //?
            let transform = CATransform3DMakeTranslation(14, 0, 0)
            replicatorLayer.instanceTransform = transform
            replicatorLayer.instanceDelay = 0.1
            layer.addSublayer(replicatorLayer)
            
            // do tre
            repeatAnimation.duration = 0.5
            //?
            repeatAnimation.autoreverses = true
            // so lan lap lai
            repeatAnimation.repeatCount = .infinity
            //?
            repeatAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            //?
            let height = CABasicAnimation(keyPath: "bounds")
            height.toValue = CGRect(x: 0, y: 0, width: 8, height: 10)
            
            let opacity = CABasicAnimation(keyPath: "opacity")
            opacity.toValue = 1
            
            repeatAnimation.animations = [height, opacity]
            
        }
        
        override func layoutSubviews() {
            replicatorLayer.bounds = CGRect(x: 0, y: 0, width: 38, height: 10)
            //?
            replicatorLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        }
        
        func startAnimating() {
            //?
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.2)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn))
            circleLayer.transform = CATransform3DIdentity
            circleLayer.opacity = 0.5
            CATransaction.setCompletionBlock { [weak self] in
                guard let s = self else { return }
                s.circleLayer.add(s.repeatAnimation, forKey: s.repeatAnimationKey)
            }
            CATransaction.commit()
        }
        
        func stopAnimating(_ complition: (() -> Void)? = nil) {
            CATransaction.begin()
            circleLayer.removeAnimation(forKey: repeatAnimationKey)
            CATransaction.setAnimationDuration(0.2)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn))
            circleLayer.transform = CATransform3DMakeTranslation(0, 6, 0)
            circleLayer.opacity = 0
            
            if let c = complition {
                let additional = replicatorLayer.instanceDelay * CFTimeInterval(replicatorLayer.repeatCount)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + additional, execute: c)
            }
            
            CATransaction.commit()
        }

}
