//
//  GradientView.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 21.11.21.
//

import UIKit

class GradientView: UIView {

    @IBInspectable private var startColor: UIColor? {
        didSet {
            self.setupGradientColor()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            self.setupGradientColor()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setupGradientColor() {
        guard let startColor = startColor, let endColor = endColor else { return }
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

}
