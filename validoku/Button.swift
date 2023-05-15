//
//  Button.swift
//  Validoku
//
//  Created by Xiaomi on 04.03.2023.
//

import UIKit

public class Button {
    private let button = UIButton();
    private var title = "";
    private var description = "";
    private var type = ButtonTypes.MenuFirstFour;
    private var parent = UIView();
    private var height = 0.0, width = 0.0;
    
    public class ButtonBuilder {
        private let button = Button();
        
        public func title(title: String) -> ButtonBuilder {
            guard title != "" else {
                Logger.addError(errorType: NSError(domain: "button title can't be empty or null", code: 1), classError: "ButtonBuilder", methodName: "title");
                return self;
            }
            button.title = title;
            return self;
        }
        
        public func view(parent: UIView) -> ButtonBuilder {
            button.parent = parent;
            return self;
        }
        
        public func description(description: String) -> ButtonBuilder {
            button.description = description;
            return self;
        }
        
        public func type(type: ButtonTypes) -> ButtonBuilder {
            button.type = type;
            return self;
        }
        
        public func build() -> Button {
            return button;
        }
    }
    
    init() {
    }
    
    private func addDescription() {
        if (description != "") {
            let desc = UILabel();
            desc.text = description;
            
            switch type {
            case ButtonTypes.MenuFirstFour:
                desc.textColor = UIColor(red: CGFloat(217.0 / 255.0),
                                         green: CGFloat(217.0 / 255.0),
                                         blue: CGFloat(217.0 / 255.0),
                                         alpha: CGFloat(1.0));
                desc.font = .systemFont(ofSize: parent.bounds.height * 0.01,
                                              weight: .bold);
                break;
            default:
                break;
            }
            
            button.addSubview(desc)
            
            switch type {
            case ButtonTypes.MenuFirstFour:
                desc.pinLeft(to: button, 15);
                desc.pinBottom(to: button, Int(height * 0.2));
            default:
                break;
            }
        }
    }
    
    private func addTitle() {
        let title = UILabel();
        title.text = self.title;
        title.textColor = .white;
        
        switch type {
        case ButtonTypes.MenuTitle:
            title.font = .systemFont(ofSize: parent.bounds.height * 0.03,
                                          weight: .bold);
            title.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            title.layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
            title.layer.shadowOpacity = 4.0
            title.layer.shadowRadius = 0.0
            title.layer.masksToBounds = false
            break;
        case ButtonTypes.MenuFirstFour:
            title.font = .systemFont(ofSize: parent.bounds.height * 0.025,
                                          weight: .bold);
            break;
        default:
            break;
        }
        
        button.addSubview(title);
        
        switch type {
        case ButtonTypes.MenuTitle:
            title.pinCenter(to: button);
            break;
        case ButtonTypes.MenuFirstFour:
            title.pinLeft(to: button, 15);
            title.pinTop(to: button, Int(height * 0.23));
            break;
        default:
            break;
        }
    }
    
    private func addShadow() {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
        button.layer.shadowOpacity = 4.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
    private func makeButtonStyle() {
        switch type {
        case ButtonTypes.MenuTitle:
            button.backgroundColor = UIColor(red: CGFloat(32.0 / 255.0),
                                             green: CGFloat(73.0 / 255.0),
                                             blue: CGFloat(105.0 / 255.0),
                                             alpha: CGFloat(1.0)
            );
            
            button.layer.cornerRadius = 12;
            
            height = 0.075 * parent.bounds.height
            button.setHeight(Int(height));
            width = 0.2 * parent.bounds.width
            button.setWidth(Int(width));
            
            addShadow();
            button.heightAnchor.constraint(equalTo:
                                            button.widthAnchor).isActive = true
            break;
        case ButtonTypes.MenuFirstFour:
            button.backgroundColor = UIColor(red: CGFloat(72.0 / 255.0),
                                             green: CGFloat(125.0 / 255.0),
                                             blue: CGFloat(167.0 / 255.0),
                                             alpha: CGFloat(1.0)
            );
            
            button.layer.cornerRadius = 8;
            
            button.titleLabel?.font = .systemFont(ofSize: 24.0,
                                                  weight: .medium)
            
            height = 0.075 * parent.bounds.height
            button.setHeight(Int(height));
            button.setWidth(Int(parent.bounds.width * 0.41));
            
            button.heightAnchor.constraint(equalTo:
                                            button.widthAnchor).isActive = true
            break;
        default:
            break;
        }
    }
    
    public static func builder() -> ButtonBuilder {
        return Button.ButtonBuilder();
    }
    
    public func makeButton() -> UIButton {
        makeButtonStyle();
        addTitle();
        addDescription();
        return button;
    }
}
