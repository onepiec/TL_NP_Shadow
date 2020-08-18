//
//  TLShadow.swift
//  shadowDemo
//
//  Created by TL on 2020/2/28.
//  Copyright © 2020 TL. All rights reserved.
//

import UIKit

enum SideType : Int {
    case outSide    // 阴影朝外
    case inSide     // 阴影朝里
}

enum DirectionType : Int {
    case rightTopDirection      // 重阴影色在右上
    case rightBottomDirection   // 重阴影色在右下
    case leftTopDirection       // 重阴影色在左上
    case leftBottomDirection    // 重阴影色在左下
}

func RGBColor(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
let WeightColor = RGBColor(r: 203, g: 214, b: 226)
let LightColor  = RGBColor(r: 243, g: 246, b: 253)

class TLShadowConfiguration: NSObject {
    
    var sideType:SideType = .outSide
    var directionType:DirectionType = .rightBottomDirection
    
}

class TLShadow: NSObject {

    class func tl_initShadow(view:UIView) {
        self.tl_initShadow(view: view, configuration: TLShadowConfiguration())
    }
    class func tl_initShadow(view:UIView ,configuration:TLShadowConfiguration) {
        view.layer.masksToBounds = true
        if configuration.sideType == .outSide{
            self.tl_initOutSideShadow(view: view, direction: configuration.directionType)
        }else {
            self.tl_initInSideShadow(view: view, direction: configuration.directionType)
        }
    }
    
    class private func tl_initOutSideShadow(view:UIView ,direction:DirectionType) {
        
        var weightSize = CGSize.zero
        var lightSize = CGSize.zero
        
        if (direction == .rightTopDirection) {
            weightSize = CGSize.init(width: 3, height: -3)
            lightSize  = CGSize.init(width: -3, height: 3)
        }else if (direction == .rightBottomDirection){
            weightSize = CGSize.init(width: 3, height: 3)
            lightSize  = CGSize.init(width: -3, height: -3)
        }else if (direction == .leftTopDirection){
            weightSize = CGSize.init(width: -3, height: -3)
            lightSize  = CGSize.init(width: 3, height: 3)
        }else{
            weightSize = CGSize.init(width: -3, height: 3)
            lightSize  = CGSize.init(width: 3, height: -3)
        }
        
        for index in 0...1 {
            
            let layer = CALayer()
            
            layer.frame = view.frame
            layer.backgroundColor = view.backgroundColor?.cgColor
            layer.cornerRadius = view.layer.cornerRadius
            if (index == 0) {
                layer.shadowOffset = weightSize
                layer.shadowColor = WeightColor.cgColor
            }else{
                layer.shadowOffset = lightSize
                layer.shadowColor = LightColor.cgColor
            }
            layer.shadowOpacity = 1
            view.superview?.layer.insertSublayer(layer, below: view.layer)
        }
    }
    
    class private func tl_initInSideShadow(view:UIView ,direction:DirectionType) {
        
        var weightSize = CGSize.zero
        var lightSize = CGSize.zero
        
        if (direction == .rightTopDirection) {
            weightSize = CGSize.init(width: -3, height: 3)
            lightSize  = CGSize.init(width: 3, height: -3)
        }else if (direction == .rightBottomDirection){
            weightSize = CGSize.init(width: -3, height: -3)
            lightSize  = CGSize.init(width: 3, height: 3)
        }else if (direction == .leftTopDirection){
            weightSize = CGSize.init(width: 3, height: 3)
            lightSize  = CGSize.init(width: -3, height: -3)
        }else{
            weightSize = CGSize.init(width: 3, height: -3)
            lightSize  = CGSize.init(width: -3, height: 3)
        }
        
        let shadowLayer0 = CAShapeLayer()
        let shadowLayer1 = CAShapeLayer()
        let shadowLayerArr = [shadowLayer0 ,shadowLayer1]
        
        for (index, shadowLayer) in shadowLayerArr.enumerated() {
            
            shadowLayer.frame = view.bounds
            if (0 == index) {
                shadowLayer.shadowOffset = weightSize
                shadowLayer.shadowColor = WeightColor.cgColor
            }else{
                shadowLayer.shadowOffset = lightSize
                shadowLayer.shadowColor = LightColor.cgColor
            }
            shadowLayer.shadowOpacity = 1
            shadowLayer.fillRule = .evenOdd;
        }
        
        let path = CGMutablePath()
        path.addRect(view.bounds.insetBy(dx: -5, dy: -5))
        
        let someInnerPath = UIBezierPath.init(roundedRect: CGRect.init(x: -0.5, y: -0.5, width: view.bounds.size.width + 1, height: view.bounds.size.height + 1), cornerRadius: view.layer.cornerRadius).cgPath
        
        path.addPath(someInnerPath)
        path.closeSubpath()
        
        shadowLayer0.path = path
        shadowLayer1.path = path
                
        for (_, shadowLayer) in shadowLayerArr.enumerated() {
            
            view.layer.addSublayer(shadowLayer)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = someInnerPath
            
            shadowLayer.mask = maskLayer
        }
    }
}
