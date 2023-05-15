import UIKit

public class Menu : UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        setupeView();
    }
    
    private func addNewGameButton() {
        let button = TitleButton(title: .NewGame, parent: view)
        button.setColor(color: UIColor(red: 1.0, green: 57.0 / 255.0, blue: 0.0, alpha: 1.0))
        button.setWidth(width: 0.6 * view.bounds.width)
        button.setHeight(height: 0.075 * view.bounds.height)
        button.addAction(action: newGameButtonPressed)
        button.makeDesign()
        
        self.view.addSubview(button);
        button.pinCenter(to: view)
        /*button.pinCenterX(to: view);
        button.pinTop(to: view, 380)*/
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
    
    /*private func addContinueButton() {
        let button = TitleButton(title: .Continue, parent: view)
        button.setColor(color: UIColor(red: 1.0, green: 57.0 / 255.0, blue: 0.0, alpha: 1.0))
        button.setWidth(width: 0.6 * view.bounds.width)
        button.setHeight(height: 0.075 * view.bounds.height)
        button.addAction(action: newGameButtonPressed)
        button.makeDesign()
        
        self.view.addSubview(button);
        button.pinCenterX(to: view);
        button.pinBottom(to: view, 380)
        /*let button = ContinueButton(description: (currentGame?.getTimeAndMode())!, parent: view);
        button.addTarget(target: self, action: #selector(continueGameButtonPressed), for: .touchUpInside)
        let uiButton = button.getUIButton();
        
        self.view.addSubview(uiButton);
        uiButton.pinCenterX(to: view);
        uiButton.pinTop(to: view, 40);*/
    }*/
    
    private func setupeView() {
        view.backgroundColor = .systemGray6
        setupValueLabel()
        /*if currentGame != nil {
            addContinueButton();
        }*/
        
        addNewGameButton();
        //addContinueButton()
    }
    
    /*public func setCurrentGame() {
        
    }*/
    
    @objc
    private func newGameButtonPressed() {
        let mode = ModeSelection();
        navigationController?.pushViewController(mode, animated: true);
    }
    
    /*@objc
    private func continueGameButtonPressed() {
        
    }*/
}
