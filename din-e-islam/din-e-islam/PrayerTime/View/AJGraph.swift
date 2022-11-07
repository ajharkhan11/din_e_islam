//
//  CircleGraphView.swift
//  ChartDemo
//
//  Created by Ajharudeen Khan on 25/02/19.
//  Copyright © 2019 CrownWits. All rights reserved.
//

import UIKit


@IBDesignable class AJGraph: UIView {
    
    @IBInspectable var arcWidth: Double = 10.0
    
    @IBInspectable var arcColor : UIColor = UIColor.yellow
    
    @IBInspectable var arcBackgroundColor : UIColor = UIColor.black
    
    //define start angle and end angle
    var parentEndArc = 360.deg2rad// CGFloat(180 * Double.pi / 180)
    
    var start = 0.deg2rad
    
    var childEndArc:CGFloat = 359.deg2rad{   // in range of 0.0 to 1.0
        didSet{
            setNeedsDisplay()
        }
    }
    
    //animation
    public var duration : CFTimeInterval = 3.0
    
    public var repeatCount : Float = 0
    
    private var autoreverses = false
    
    private var fromValue = NSNumber.init(value: 0.0)
    
    private var toValue = NSNumber.init(value: 1.0)
    
    public override func draw(_ rect: CGRect) {
        //find the centerpoint of the rect
        let bgLayer = getBackgroundLayer()
        self.layer.addSublayer(bgLayer)
        
        let foreLayer = getForeGroundLayer()
        self.layer.addSublayer(foreLayer)
        
        let pathAnimation = self.getAnimation()
        foreLayer.add(pathAnimation, forKey: "strokeEnd")
    }
    
    private func getCenterPoint() -> CGPoint {
        return CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.width/2)
    }
    
    private func getRadius() -> CGFloat {
        var radius:CGFloat = 0.0
        if self.frame.width > self.frame.height {
            radius = (self.frame.width - arcWidth) / 2.0
        }else{
            radius = (self.frame.height - arcWidth) / 2.0
        }
        return radius
    }
    
    private func getBackgroundLayer() -> CAShapeLayer{
        let centerPoint = getCenterPoint()
        let radius = getRadius()
        
        let path = UIBezierPath.init(arcCenter:  CGPoint.init(x: centerPoint.x, y: centerPoint.y), radius: radius, startAngle: start, endAngle: parentEndArc, clockwise: true)
        
        let bgLayer = CAShapeLayer()
        bgLayer.path = path.cgPath
        bgLayer.fillColor = UIColor.clear.cgColor
        bgLayer.strokeColor = arcBackgroundColor.cgColor
        bgLayer.lineWidth = arcWidth
        bgLayer.lineCap = .round
        return bgLayer
    }
    
    private func getForeGroundLayer() -> CAShapeLayer {
        let centerPoint = getCenterPoint()
        let radius = getRadius()
        
        let colorPath = UIBezierPath.init(arcCenter:  CGPoint.init(x: centerPoint.x, y: centerPoint.y), radius: radius, startAngle: start, endAngle: childEndArc, clockwise: true)
        
        let colorLayer = CAShapeLayer()
        colorLayer.path = colorPath.cgPath
        colorLayer.fillColor = UIColor.clear.cgColor
        colorLayer.strokeColor = arcColor.cgColor
        colorLayer.lineWidth = arcWidth
        colorLayer.lineCap = .round
        return colorLayer
    }
    
    private func getAnimation() -> CABasicAnimation {
        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = duration
        pathAnimation.fromValue = fromValue
        pathAnimation.toValue = toValue
        pathAnimation.repeatCount = repeatCount
        pathAnimation.autoreverses = autoreverses
        return pathAnimation
    }
}

extension Int{
    var deg2rad:  CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
