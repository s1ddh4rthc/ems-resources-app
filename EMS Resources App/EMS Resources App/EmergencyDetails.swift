//
//  EmergencyDetails.swift
//  EMS Resources App
//
//  Created by Vatsal Baherwani on 1/29/22.
//

import UIKit

class EmergencyDetailView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .darkGray
        self.layer.cornerRadius = 20
    }
}
