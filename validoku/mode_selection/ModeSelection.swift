import UIKit
import Kingfisher

class ModeSelection: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupValueLabel() {
        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 0.02 * view.bounds.height,
                                      weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "Validoku"
        
        view.addSubview(valueLabel)
        valueLabel.pinTop(to: view, 90)
        valueLabel.pinCenterX(to: view)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupValueLabel()
        setupModeButtons()
    }
    
    private func getStackViewsOnHorizontal(arr: Array<UIView>) -> UIStackView {
        let array = UIStackView(arrangedSubviews:arr)
        array.spacing = 0.025 * view.bounds.width
        array.axis = .horizontal
        array.distribution = .fillEqually
        
        return array;
    }
    
    private func getStackViewsOnVertical(arr: Array<UIView>) -> UIStackView {
        let array = UIStackView(arrangedSubviews:arr);
        array.spacing = 0.025 * view.bounds.width;
        array.axis = .vertical;
        array.distribution = .fillEqually
        
        return array;
    }
    
    private func getStackViewsOnVertical(array: Array<UIStackView>) -> UIStackView {
        let arr = UIStackView(arrangedSubviews:array);
        arr.spacing = 0.01 * view.bounds.height;
        arr.axis = .vertical
        arr.distribution = .fillEqually
        
        return arr;
    }
    
    private func addTitleMenuButton() {
        let title = TitleButton(title: .Selection, parent: view);
        title.addShadow()
        title.setColor(color: UIColor(red: CGFloat(32.0 / 255.0),
                                      green: CGFloat(73.0 / 255.0),
                                      blue: CGFloat(105.0 / 255.0),
                                      alpha: CGFloat(1.0)))
        title.setWidth(width: 0.2 * view.bounds.width)
        title.setHeight(height: 0.075 * view.bounds.height)
        title.makeDesign()
        
        self.view.addSubview(title);
        title.pinTop(to: view, 0.18 * view.bounds.height)
        title.pinHorizontal(to: view, 24)
    }
    
    private func addTargetToButton(button: ButtonWithStringAndAction) {
        switch button.getTitle() {
        case .Rare:
            button.setAction(action: rareButtonPressed)
            return;
        case .Medium:
            button.setAction(action: mediumButtonPressed)
            return;
        case .WellDone:
            button.setAction(action: wellDoneButtonPressed)
            return;
        case .Burned:
            button.setAction(action: burnedButtonPressed)
            return;
        case .PVP:
            button.setAction(action: pvpButtonPressed)
            return;
        case .Custom:
            button.setAction(action: customButtonPressed)
            return;
        case .Shable:
            button.setAction(action: shableButtonPressed)
            return;
        }
    }
    
    private func addFirstFourMenuButtons() {
        var arr: [UIView] = [];
        var stack: [UIStackView] = [];
        let collection: [(Modes, String)] = [(Modes.Rare, "30-40 known digits"),
                                             (Modes.Medium, "25-29 known digits"),
                                             (Modes.WellDone, "19-24 known digits"),
                                             (Modes.Burned, "15-18 known digits")];
        
        var i = 0;
        for tup in collection {
            i += 1;
            
            let button = ButtonWithStringAndAction(title: tup.0, description: tup.1, parent: view, width: 0.41 * view.bounds.width, height: 0.075 * view.bounds.height)

            addTargetToButton(button: button);
            button.makeDesign()
            arr.append(button);
            
            if i == 2 {
                i = 0;
                stack.append(getStackViewsOnHorizontal(arr: arr));
                arr = []
            }
        }
        
        let firstFourViews = getStackViewsOnVertical(array: stack);
        self.view.addSubview(firstFourViews);
        firstFourViews.pinHorizontal(to: view, 0.1 * view.bounds.width)
        firstFourViews.pinTop(to: view, 0.275 * view.bounds.height);
    }
    
    private func addOtherMenuButtons() {
        let collection: [(Modes, String)] = [(Modes.PVP, "Random quantity of known digits"),
                                              (Modes.Custom, "You can set count of hints and known digits"),
                                              (Modes.Shable, "Known digits change each 15 seconds")]
        var arr: [UIView] = [];
        
        for tup in collection {
            let button = ButtonWithStringAndAction(title: tup.0, description: tup.1, parent: view, width: 0.16 * view.bounds.width, height: 0.075 * view.bounds.height, isAlignmentInCenter: true)
        
            addTargetToButton(button: button);
            button.makeDesign()
            
            arr.append(button)
        }
        
        let array = getStackViewsOnVertical(arr: arr);
        self.view.addSubview(array);
        array.pinHorizontal(to: view, 0.1 * view.bounds.width)
        array.pinTop(to: view, 0.2 * view.bounds.height + 3.3 * 0.075 * view.bounds.height);
    }
    
    private func setupModeButtons() {
        addTitleMenuButton()
        addFirstFourMenuButtons();
        addOtherMenuButtons()
    }
    
    @objc
    private func rareButtonPressed() {
        let userScenery = Game(gameMode: .Rare)
        navigationController?.pushViewController(userScenery, animated: true)
    }
    
    @objc
    private func mediumButtonPressed() {
        let userScenery = Game(gameMode: .Medium)
        navigationController?.pushViewController(userScenery, animated: true)
    }
    
    @objc
    private func wellDoneButtonPressed() {
        let userScenery = Game(gameMode: .WellDone)
        navigationController?.pushViewController(userScenery, animated: true)
    }
    
    @objc
    private func burnedButtonPressed() {
        let userScenery = Game(gameMode: .Burned)
        navigationController?.pushViewController(userScenery, animated: true)
    }
    
    @objc
    private func customButtonPressed() {
        let userScenery = Game(gameMode: .Custom)
        navigationController?.pushViewController(userScenery, animated: true)
    }
    
    @objc
    private func shableButtonPressed() {
        let userScenery = Game(gameMode: .Shable)
        navigationController?.pushViewController(userScenery, animated: true)
    }
    
    @objc
    private func pvpButtonPressed() {
        let userScenery = Game(gameMode: .PVP)
        navigationController?.pushViewController(userScenery, animated: true)
    }
}
