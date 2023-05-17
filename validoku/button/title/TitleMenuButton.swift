import UIKit

public class TitleButton : UIView, Button {
    private let title: TitleType;
    private var menuColor: UIColor?
    private var action: (() -> Void)?
    private var digitAction: ((TitleButton) -> Void)?
    var button: UIButton
    var parent: UIView;
    private var tit: UILabel?
    
    init(title: TitleType, parent: UIView) {
        self.title = title
        self.parent = parent
        button = UIButton(type: .system)
        super.init(frame: .zero)
        makeDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        button.backgroundColor = menuColor;
        button.layer.cornerRadius = 8;
        
        addSubview(button)
        button.pin(to: self)
    }
    
    private func setTitle(_ text: String = "") {
        tit = UILabel()
        
        if text.isEmpty {
            tit!.text = String(describing: self.title)
        } else {
            tit!.text = text
        }
        
        tit!.font = .systemFont(ofSize: parent.bounds.height * 0.03,
                                      weight: .bold)
        
        if self.title != .ValidokuDigit {
            tit!.textColor = .white
        } else {
            tit!.textColor = UIColor(red: 72 / 255, green: 125 / 255, blue: 167 / 255, alpha: 1.0)
        }
        
        button.addSubview(tit!)
        
        tit!.pinCenter(to: button)
    }
    
    public func makeDesign() {
        setButton()
        setTitle()
    }
    
    public func setWidth(width: Double) {
        button.setWidth(width)
    }
    
    public func setHeight(height: Double) {
        button.setHeight(height)
    }
    
    public func setColor(color: UIColor) {
        menuColor = color
    }
    
    @objc private func someAction() {
        if action == nil {
            digitAction?(self)
        } else {
            action?()
        }
    }
}

extension TitleButton {
    public func addShadow() {
        button.layer.cornerRadius = 12;
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
        button.layer.shadowOpacity = 4.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
    public func addAction(action: (() -> Void)?) {
        self.action = action
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        reloadInputViews()
    }
    
    public func addAction(digitAction: ((TitleButton) -> Void)?) {
        self.digitAction = digitAction
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        reloadInputViews()
    }
    
    public func setText(text: String) {
        tit!.text = text
        reloadInputViews()
    }
    
    public func changeTextColor(color: UIColor) {
        tit!.textColor = color
        reloadInputViews()
    }
    
    public func getDigit() -> Int {
        let num = Int(tit!.text!)
        return num!
    }
}
