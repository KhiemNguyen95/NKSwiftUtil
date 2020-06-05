//
//  ViewUtils.swift
//
//  Created by Khiem on 2020-04-16.
//  Copyright © 2020 KhiemNV. All rights reserved.
//

import UIKit
extension UIView {
	func layout(using constraints: [NSLayoutConstraint]) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(constraints)
	}
	/// addShadow and make boder
	func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner = [], fillColor: UIColor = .white) {

		let shadowLayer = CAShapeLayer()
		let size = CGSize(width: cornerRadius, height: cornerRadius)
		let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
		shadowLayer.path = cgPath //2
		shadowLayer.fillColor = fillColor.cgColor //3
		shadowLayer.shadowColor = shadowColor.cgColor //4
		shadowLayer.shadowPath = cgPath
		shadowLayer.shadowOffset = offSet //5
		shadowLayer.shadowOpacity = opacity
		shadowLayer.shadowRadius = shadowRadius
		self.layer.addSublayer(shadowLayer)
	}
	/// make boder
	func round(corners: UIRectCorner, cornerRadius: Double) {
		let size = CGSize(width: cornerRadius, height: cornerRadius)
		let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
		let shapeLayer = CAShapeLayer()
		shapeLayer.frame = self.bounds
		shapeLayer.path = bezierPath.cgPath
		self.layer.mask = shapeLayer
	}

	func circle() {
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
		layer.masksToBounds = true
	}
	// Using a function since `var image` might conflict with an existing variable
	// (like on `UIImageView`)
	func asImage() -> UIImage {
		if #available(iOS 10.0, *) {
			let renderer = UIGraphicsImageRenderer(bounds: bounds)
			return renderer.image { rendererContext in
				layer.render(in: rendererContext.cgContext)
			}
		} else {
			UIGraphicsBeginImageContext(self.frame.size)
			self.layer.render(in: UIGraphicsGetCurrentContext()!)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			return UIImage(cgImage: image!.cgImage!)
		}
	}
	func copyView<T: UIView>() -> T {
		return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
	}

	func addBorders(to edges: UIRectEdge, withColor color: UIColor, heightOrWidth width: CGFloat) {

		if edges.contains(.all) {
			layer.borderColor = color.cgColor
			layer.borderWidth = width
			return
		}

		if edges.contains(.top) {
			let border = CALayer()
			border.backgroundColor = color.cgColor
			border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
			layer.addSublayer(border)
		}

		if edges.contains(.left) {
			let border = CALayer()
			border.backgroundColor = color.cgColor
			border.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
			layer.addSublayer(border)
		}

		if edges.contains(.right) {
			let border = CALayer()
			border.backgroundColor = color.cgColor
			border.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: frame.size.height)
			layer.addSublayer(border)
		}

		if edges.contains(.bottom) {
			let border = CALayer()
			border.backgroundColor = color.cgColor
			border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
			layer.addSublayer(border)
		}
	}
	/**
		 Thực hiện add tapgesture
		 - Parameter tapNumber: Số lần chạm
		 - Parameter target: context
		 - Parameter action: Event của tap
		 */
	func addTapGesture(tapNumber: Int, target: Any, action: Selector) {

		let tapGesture = UITapGestureRecognizer(target: target, action: action)
		tapGesture.numberOfTapsRequired = tapNumber
		addGestureRecognizer(tapGesture)
		isUserInteractionEnabled = true
	}

	func dropShadow(color: UIColor = UIColor.lightGray, opacity: Float = 1, radius: CGFloat = 2, offset: CGSize = CGSize(width: 0, height: 2), scale: Bool = true) {

		layer.masksToBounds = false
		layer.shadowColor = color.cgColor
		layer.shadowOpacity = opacity
		layer.shadowOffset = offset
		layer.shadowRadius = radius

		layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
		layer.shouldRasterize = true
		layer.rasterizationScale = scale ? UIScreen.main.scale : 1
	}
	class func fromNib<T : UIView>() -> T {
		return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
	}

	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}

}
//IBInspectable
extension UIView{
	// Set Corner Radius for UIView
	@IBInspectable var cornerRadius: CGFloat {
		set {
			self.layer.cornerRadius = newValue
			self.clipsToBounds = newValue > 0
		}
		get {
			return self.layer.cornerRadius
		}
	}
	// Set Border Color for UIView
	@IBInspectable var borderColor: UIColor? {
		set {
			self.layer.borderColor = newValue!.cgColor
		}
		get {
			if let color = layer.borderColor {
				return UIColor(cgColor: color)
			} else {
				return nil
			}
		}
	}
	// Set border width for UIView
	@IBInspectable var borderWidth: CGFloat {
		set {
			self.layer.borderWidth = newValue
		}
		get {
			return layer.borderWidth
		}
	}

	// Set Shadow Color for UIView
	@IBInspectable var shadowColor: UIColor? {
		set {
			self.layer.shadowColor = newValue!.cgColor
		}
		get {
			if let shadowColor = layer.shadowColor {
				return UIColor(cgColor: shadowColor)
			} else {
				return nil
			}
		}
	}
	// Set Shadow Opacity
	@IBInspectable var shadowOpacity: Float {
		set {
			self.layer.shadowOpacity = newValue
		}
		get {
			return layer.shadowOpacity
		}
	}
	// Set Shadow Radius for UIView
	@IBInspectable var shadowRadius: CGFloat {
		set {
			self.layer.shadowRadius = newValue
		}
		get {
			return layer.shadowRadius
		}
	}

	// Set Shadow Offset for UIview
	@IBInspectable var shadowOffset: CGSize {
		set {
			self.layer.shadowOffset = newValue
		}
		get {
			return layer.shadowOffset
		}
	}
	@IBInspectable var maskToBounds: Bool {
		set {
			self.layer.masksToBounds = newValue
		}
		get {
			return layer.masksToBounds
		}
	}

}
