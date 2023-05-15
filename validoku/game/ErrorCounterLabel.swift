//
//  ErrorCounterLabel.swift
//  Validoku
//
//  Created by Xiaomi on 11.05.2023.
//

import UIKit

class ErrorCounterLabel : UIView {
    private let label: UILabel
    private var counter: Int
    
    private func updateText() {
        label.text = String(format: "%d/%d mistakes", counter, 3)
        reloadInputViews()
    }
    
    private func setupLabel()  {
        label.setWidth(120)
        label.setHeight(20)
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        addSubview(label)
        
        updateText()
    }
    
    init() {
        self.label = UILabel()
        self.counter = 0
        
        super.init(frame: .zero)
        
        setupLabel()
    }
    
    init(label: ErrorCounterLabel) {
        self.label = label.label
        self.counter = label.counter
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func increaseCounter() {
        counter += 1
        updateText()
    }
    
    public func getCounter() -> Int {
        return counter
    }
}
