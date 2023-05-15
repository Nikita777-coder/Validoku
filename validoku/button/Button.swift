//
//  BaseButton.swift
//  Validoku
//
//  Created by Xiaomi on 04.05.2023.
//

import UIKit

protocol Button : UIView {
    var button: UIButton { get set }
    
    func makeDesign();
}
