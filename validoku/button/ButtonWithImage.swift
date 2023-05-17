import UIKit
import Kingfisher

final public class ButtonWithImage : UIView, Button {
    private var url: String
    private var action: (() -> Void)?
    var button: UIButton
    var hintLabel: UILabel?
    var hintCounter = 3

    init(url: String) {
        self.url = url
        self.button = UIButton(type: .system)
        
        super.init(frame: .zero)
        
        makeDesign()
    }
    
    init(url: String, action: (() -> Void)?) {
        self.url = url
        self.action = action
        self.button = UIButton(type: .system)
        
        super.init(frame: .zero)
        
        makeDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImage() {
        KingfisherManager.shared.retrieveImage(with: URL(string: url)!) { [weak self] result in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.button.setImage(value.image.withRenderingMode(.alwaysOriginal), for: .normal)
                }
            default:
                break
            }
        }
    }
    
    private func setButton() {
        button.tintColor = .clear
        button.setWidth(50);
        button.setHeight(50);
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        button.kf.setImage(with: URL(string: url), for: .normal)
        addSubview(button)
        button.pinCenterY(to: self)
    }
    
    public func makeDesign() {
        setButton()
        setImage()
    }
    
    @objc private func someAction(){
        action?()
    }
}

extension ButtonWithImage {
    public func decreaseHintCounter() {
        if hintCounter > -1 {
            hintLabel?.text = String(hintCounter)
            hintCounter -= 1
        }
        
    }
    
    public func addHintCounter() {
        hintLabel = UILabel()
        hintLabel?.textColor = .black
        hintLabel?.setWidth(10)
        hintLabel?.setHeight(10)
        hintLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        addSubview(hintLabel!)
        hintLabel?.pinTop(to: self, 15)
        hintLabel?.pinRight(to: self, 5)
        decreaseHintCounter()
    }
    
    public func addBottomTitle(title: String) {
        setWidth(65)
        setHeight(85)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.setWidth(60)
        titleLabel.setHeight(15)
        addSubview(titleLabel)
        titleLabel.pinBottom(to: self)
        titleLabel.pinLeft(to: self, 11)
    }
}
