//
//  ShadowView.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    let gradient = CAGradientLayer()

    var colors: [UIColor] = [UIColor.clear,
                             UIColor.black.withAlphaComponent(0.7)] {
        didSet {
            gradient.colors = colors.map { $0.cgColor }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height )
        gradient.colors = colors.map { $0.cgColor }
        layer.addSublayer(gradient)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
    }
}
