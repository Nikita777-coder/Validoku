import UIKit

public class ButtonWithStringAndAction : UIView, Button {
    private let title: Modes;
    private let descrip: String;
    private var width = 0.0, height = 0.0;
    private let isAlignmentInCenter: Bool;
    private let menuColor = UIColor(red: CGFloat(72.0 / 255.0),
                                    green: CGFloat(125.0 / 255.0),
                                    blue: CGFloat(167.0 / 255.0),
                                    alpha: CGFloat(1.0));
    private var action: (() -> Void)?
    var button: UIButton
    var parent: UIView;
    
    private func setWidth(width: Double) {
        if (height < 0) {
            //ModeButtonLogger.error(ModeButton <id> height < 0)
        }
        
        self.width = width
    }
    
    private func setHeight(height: Double) {
        if (width < 0) {
            //ModeButtonLogger.error(ModeButton <id> width < 0)
        }
        
        self.height = height
    }
    
    init(title: Modes, description: String, parent: UIView, width: Double, height: Double, isAlignmentInCenter: Bool = false) {
        self.isAlignmentInCenter = isAlignmentInCenter
        self.title = title;
        descrip = description;
        self.parent = parent;
        button = UIButton()
        
        super.init(frame: .zero)
        
        setHeight(height: height)
        setWidth(width: width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAction(action: (() -> Void)?) {
        self.action = action
    }
    
    public func getTitle() -> Modes {
        return title
    }
    
    private func setButton() {
        button.backgroundColor = menuColor;
        button.layer.cornerRadius = 8;
        
        button.setHeight(height);
        button.setWidth(width);
        
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        addSubview(button)
        button.pin(to: self)
    }
    
    private func setTitle() {
        let titleLabel = UILabel();
        titleLabel.text = String(describing: title);
        titleLabel.font = .systemFont(ofSize: parent.bounds.height * 0.025,
                                      weight: .bold);
        titleLabel.textColor = .white;
        
        button.addSubview(titleLabel);
        
        titleLabel.pinTop(to: button, height * 0.23);
        
        if !isAlignmentInCenter {
            titleLabel.pinLeft(to: button, 15);
        } else {
            titleLabel.pinCenterX(to: button)
            
        }
    }
    
    private func setDescription() {
        let desc = UILabel();
        desc.text = descrip;
        
        desc.textColor = UIColor(red: CGFloat(217.0 / 255.0),
                                 green: CGFloat(217.0 / 255.0),
                                 blue: CGFloat(217.0 / 255.0),
                                 alpha: CGFloat(1.0));
        desc.font = .systemFont(ofSize: parent.bounds.height * 0.01,
                                      weight: .bold);
        
        button.addSubview(desc);
        
        desc.pinBottom(to: button, height * 0.2);
        
        if !isAlignmentInCenter {
            desc.pinLeft(to: button, 15);
        } else {
            desc.pinCenterX(to: button)
        }
    }
    
    public func makeDesign() {
        setButton()
        setTitle()
        setDescription()
    }
    
    @objc private func someAction(){
        action?()
    }
}
