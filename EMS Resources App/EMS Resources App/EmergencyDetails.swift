//
//  EmergencyDetails.swift
//  EMS Resources App
//
//  Created by Vatsal Baherwani on 1/29/22.
//

import UIKit
import SwiftUI
import NotificationBannerSwift

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
        
        
        
        
        addSubview(createLabel(
            y: 0,
            height: 50,
            font: .boldSystemFont(ofSize: 24),
            text: "Ambulance Request"))
        
        addSubview(createLabel(
            y: 45,
            height: 25,
            font: .boldSystemFont(ofSize: 16),
            text: "East Rutherford Volunteer EMS"))
        
        addSubview(createLabel(
            y: 70,
            height: 50,
            font: .systemFont(ofSize: 16),
            text: "Special requests: Female (pregnancy)"))
        
        addSubview(createLabel(
            y: 100,
            height: 75,
            font: .systemFont(ofSize: 16),
            text: "Patient address: 450 Hackensack Ave, Hackensack, NJ 07601"))
        
        let accept = UIButton(frame: CGRect(x: 20, y: 170, width: 120, height: 40))
        accept.backgroundColor = .systemGreen
        accept.layer.cornerRadius = 10
        accept.setTitle("Accept", for: .normal)
        accept.showsTouchWhenHighlighted = true
        accept.addTarget(self, action: #selector(onAccept), for: .touchUpInside)
        addSubview(accept)
        
        let decline = UIButton(frame: CGRect(x: 160, y: 170, width: 120, height: 40))
        decline.backgroundColor = .systemRed
        decline.layer.cornerRadius = 10
        decline.setTitle("Decline", for: .normal)
        decline.showsTouchWhenHighlighted = true
        decline.addTarget(self, action: #selector(onDecline), for: .touchUpInside)
        addSubview(decline)
    }
    
    @objc private func onAccept() {
        let banner = FloatingNotificationBanner(
            title: "Dispatching ambulance",
            subtitle: "ETA: 6min",
            style: .success
        )
        
        banner.haptic = .heavy
        banner.show()
        
        self.removeFromSuperview()
    }
    
    @objc private func onDecline() {
        self.removeFromSuperview()
    }
    
    private func createLabel(y: CGFloat!, height: CGFloat!, font: UIFont!, text: String!) -> UILabel {
        let label = UILabel(frame: CGRect(x: 20, y: y, width: self.frame.width - 40, height: height))
        
        label.center = CGPoint(x: self.frame.width / 2, y: y + height / 2)
        label.font = font
        label.textAlignment = .center
        label.textColor = .white
        label.text = text
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }
}
