//
//  HighlightView.swift
//  KingBurguer
//
//  Created by Natã Romão on 03/03/23.
//

import UIKit

protocol HighlightViewDelegate {
    func highlightSelected(productId: Int)
}

class HighlightView: UIView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        
        return iv
    }()
    
    var productId: Int!
    
    var delegate: HighlightViewDelegate?
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton(configuration: .plain())
        btn.setTitle("Resgatar Cupom", for: .normal)
        btn.setTitleColor(.systemBackground, for: .normal)
        btn.layer.borderColor = UIColor.systemBackground.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func buttonTapped() {
        delegate?.highlightSelected(productId: productId)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        addGradient()
        
        addSubview(moreButton)
        applyConstraints()
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor, // 33%
            UIColor.clear.cgColor, // 33%
            UIColor.black.cgColor  // 33%
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints() {
        let moreButtonConstraints = [
            moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(moreButtonConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
