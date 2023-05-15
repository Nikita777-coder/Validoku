//
//  ValidokuDigitCell.swift
//  Validoku
//
//  Created by Xiaomi on 13.05.2023.
//

import UIKit

struct ValidokuDigit {
    var digit: Int
}

class ValidokuDigitCell : UITableViewCell {
    static let reuseIdentifier = "AddDigitCell"
    private var text = UILabel()
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    public func addDigit(digit: Int) {
        text.text = String(digit)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupView() {
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.textColor = .tertiaryLabel
        text.backgroundColor = .clear
        text.setHeight(20)
        addSubview(text)
    }
}
