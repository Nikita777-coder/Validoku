import UIKit

class WelcomeViewController: UIViewController{
    
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 0.02 * view.bounds.height,
                                      weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "Validoku"
        self.view.addSubview(valueLabel)
        valueLabel.pinTop(to: self.view, 90)
        valueLabel.pinCenterX(to: self.view)
    }
    
    let colorPaletteView = ColorPaletteView()
    let notesView = NotesViewController()
    
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        commentView.isHidden = true
        colorPaletteView.isHidden = true
       
        setupValueLabel()
        setupMenuButtons()
        //setupColorControlSV()
    }
    
    var commentView = UIView()
    
    /*func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to:
                            self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0,
                                        weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left:
                                            16, .bottom: 16, .right: 16])
        return commentView
    }*/
    
    /*private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0,
                                              weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo:
                                        button.widthAnchor).isActive = true
        return button
    }*/
    
    private func getStackViewsOnHorizontal(arr: Array<UIView>) -> UIStackView {
        let firstTwoModes = UIStackView(arrangedSubviews:arr);
        firstTwoModes.spacing = 0.025 * view.bounds.width;
        firstTwoModes.axis = .horizontal;
        
        return firstTwoModes;
    }
    
    private func setupMenuButtons() {
        let titleMenuButton = Button.builder().title(title: "Select game mode").type(type: ButtonTypes.MenuTitle).view(parent: view).build().makeButton();
        let firstMenuButtonFromFF = Button.builder().title(title: "Rare").description(description: "30-40 known digits").view(parent: view).build().makeButton();
        let secondMenuButtonFromFF = Button.builder().title(title: "Medium").description(description: "25-29 known digits").view(parent: view).build().makeButton();
        let thirdMenuButtonFromFF = Button.builder().title(title: "Well-done").description(description: "19-24 known digits").view(parent: view).build().makeButton();
        let fourthMenuButtonFromFF = Button.builder().title(title: "Burned").description(description: "15-18 known digits").view(parent: view).build().makeButton();
        
        self.view.addSubview(titleMenuButton);
        titleMenuButton.pinTop(to: view, Int(0.18 * view.bounds.height))
        titleMenuButton.pin(to: self.view, [.left: 24, .right:
                                                24])
        
        let firstFourViews = UIStackView(arrangedSubviews: [getStackViewsOnHorizontal(arr: [firstMenuButtonFromFF, secondMenuButtonFromFF]), getStackViewsOnHorizontal(arr: [thirdMenuButtonFromFF, fourthMenuButtonFromFF])]);
        
        firstFourViews.spacing = 0.01 * view.bounds.height;
        firstFourViews.axis = .vertical
        firstFourViews.distribution = .fillEqually
        self.view.addSubview(firstFourViews)
        firstFourViews.pin(to: view, [.left: Int(0.1 * view.bounds.width), .right: Int(0.1 * view.bounds.width)]);
        firstFourViews.pinTop(to: view, Int(0.2 * view.bounds.height) + Int(0.075 * view.bounds.height));
    }
    
    /*private func setupColorControlSV() {
        colorPaletteView.isHidden = true
         view.addSubview(colorPaletteView)

        colorPaletteView.translatesAutoresizingMaskIntoConstraints =
        false
         NSLayoutConstraint.activate([
         colorPaletteView.topAnchor.constraint(equalTo:
                                                self.view.bottomAnchor, constant: 8),
         colorPaletteView.leadingAnchor.constraint(equalTo:
        view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
         colorPaletteView.trailingAnchor.constraint(equalTo:
        view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
         colorPaletteView.bottomAnchor.constraint(equalTo:
        buttonsSV.topAnchor, constant: -8)
         ])
        colorPaletteView.addTarget(self, action:
                                    #selector(changeColor(_:)), for: .touchDragInside)
    }*/
    
    @objc
     private func paletteButtonPressed() {
         colorPaletteView.isHidden.toggle()
         let generator = UIImpactFeedbackGenerator(style: .medium)
         generator.impactOccurred()
     }
    
    @objc
     func changeColor(_ slider: ColorPaletteView) {
         UIView.animate(withDuration: 0.5) {
             self.view.backgroundColor = slider.chosenColor
          }
     }
    
    
    @objc
     private func notesButtonPressed() {
         self.present(UINavigationController(rootViewController: notesView), animated: true, completion: nil)
         
     }
    
    @objc
    private func newsButtonPressed() {
        let newsListController = NewsListViewController()
        navigationController?.pushViewController(newsListController, animated: true)
    }
}

