//
//  AmmoView.swift
//  Kamikaze War
//
//  Created by jose manuel carreiro galicia on 09/4/21.
//  Copyright © 2021 Jose Carreiro. All rights reserved.
//

import UIKit

class AmmoView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    // MARK: Constants
    let viewModel: AmmoViewModel
    
    // MARK: Variables
    var onSelectBullet: ((_ bullet: Bullet) -> Void)?
    
    // MARK: LifeCycle
    init(viewModel: AmmoViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        commonInit()
        loadViewModelData()
        addGestures()
        
        viewModel.viewDelegate = self
        viewModel.viewWasLoaded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Functions
    private func commonInit() {
        let bundle = Bundle.init(for: AmmoView.self)
        if let bundleViews = bundle.loadNibNamed("AmmoView", owner: self, options: nil),
            let contentView = bundleViews.first as? UIView {
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leftAnchor.constraint(equalTo: leftAnchor),
                contentView.rightAnchor.constraint(equalTo: rightAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    private func loadViewModelData() {
        label.text = viewModel.countText
        imageView.image = viewModel.icon
        layer.borderColor = viewModel.color.cgColor
        
        changeSelection()
    }
    
    private func changeSelection() {
        layer.borderWidth = viewModel.isSelected ? 2 : 0
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectThisBullets))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func selectThisBullets() {
        if !viewModel.isSelected {
            onSelectBullet?(viewModel.bullet)
        }
    }
}

// MARK: AmmoViewDelegate
extension AmmoView: AmmoViewDelegate {
    
    func bulletUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.label.text = self?.viewModel.countText
            self?.changeSelection()
            
            self?.setNeedsLayout()
            self?.layoutIfNeeded()
        }
    }
}
