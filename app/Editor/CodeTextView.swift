//
//  CodeTextView.swift
//  iCode
//
//  Created by morinoyu8 on 06/14/23.
//

import UIKit

import Runestone
import TreeSitterCRunestone

class CodeTextView: TextView {
    
    init() {
        super.init(frame: CGRect())
        setCustomization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setConstraint(parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let leading = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0)
        let trailing = self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0)
        let top = self.topAnchor.constraint(equalTo:  parent.topAnchor, constant: 0)
        let bottom = self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
    private func setCustomization() {
        self.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        self.showLineNumbers = true
        self.lineHeightMultiplier = 1.2
        self.isLineWrappingEnabled = false
        self.showPageGuide = true
        self.pageGuideColumn = 80
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.smartQuotesType = .no
        self.smartDashesType = .no
    }
}
