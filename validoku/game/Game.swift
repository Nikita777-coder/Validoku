//
//  Game.swift
//  Validoku
//
//  Created by Xiaomi on 30.04.2023.
//

import UIKit

public class Game : UIViewController {
    /*public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        } else {
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }*/

    private let validokuTable: ValidokuTable
    private let errorCounter: ErrorCounterLabel
    private let time: TimeCounter
    private let validokuDigits: ValidokuDigits
    private var hintButton: ButtonWithImage?
    private var validokuDigitsArr: [TitleButton]?
    private var isNoteMode = true
    //private let hintButton : HintButton; - start quantity depends from mode
    //private let notesButton
    //private let eraseButton
    
    private func addValidokuTable() {
        view.addSubview(validokuTable)
        validokuTable.pinCenter(to: view)
    }
    
    private func setupErrorCounterLabel() {
        view.addSubview(errorCounter)
        errorCounter.pinTop(to: view, 0.25 * view.bounds.height)
        errorCounter.pinLeft(to: view, 0.1 * view.bounds.width)
    }
    
    private func setupTimer() {
        view.addSubview(time)
        time.pinTop(to: view, 0.24 * view.bounds.height)
        time.pinRight(to: view, 0.12 * view.bounds.width)
        time.startTick()
    }
    
    private func setupStopPlayButton() {
        let stopPlayButton = ButtonWithImage(url: "https://cdn-icons-png.flaticon.com/512/3357/3357385.png", action: stopPlayButtonPressed)
        
        stopPlayButton.makeDesign()
        
        view.addSubview(stopPlayButton)
        stopPlayButton.pinTop(to: view, 0.20 * view.bounds.height)
        stopPlayButton.pinLeft(to: view, 0.45 * view.bounds.width)
    }
    
    private func setupValidokuDigits() {
        validokuDigitsArr = []
        
        for i in 1...9 {
            let button = TitleButton(title: .ValidokuDigit, parent: view)
            button.makeDesign()
            button.setText(text: String(i))
            button.addAction(action: numberButtonPressed)
            validokuDigitsArr!.append(button)
        }
        
        let validokuDigitsStack = UIStackView(arrangedSubviews: validokuDigitsArr!)
        validokuDigitsStack.axis = .horizontal
        validokuDigitsStack.spacing = 10
        validokuDigitsStack.distribution = .fill
        view.addSubview(validokuDigitsStack)
        validokuDigitsStack.pinBottom(to: view, 200)
        validokuDigitsStack.pinCenterX(to: view)
        
        /*validokuDigits.setupTableView()
        view.addSubview(validokuDigits)
        validokuDigits.pinTop(to: view)*/
    }
    
    private func setupHintButton() {
        if hintButton == nil {
            hintButton = ButtonWithImage(url: "https://cdn-icons-png.flaticon.com/512/702/702797.png", action: hintButtonPressed)
            hintButton?.addHintCounter()
            hintButton?.addBottomTitle(title: "Hint")
        }
        
        /*view.addSubview(hintButton!)
        hintButton?.pinBottom(to: view, 150)
        hintButton?.pinLeft(to: view, 32)*/
    }
    
    private func setupNoteButton() -> ButtonWithImage {
        let noteButton = ButtonWithImage(url: "https://cdn-icons-png.flaticon.com/512/3025/3025547.png", action: noteButtonPressed)
        noteButton.addBottomTitle(title: "Note")
        
        return noteButton
    }
    
    private func setupEraseButton() -> ButtonWithImage {
        let eraseButton = ButtonWithImage(url: "https://cdn-icons-png.flaticon.com/512/3471/3471416.png", action: eraseButtonPressed)
        eraseButton.addBottomTitle(title: "Erase")
        
        return eraseButton
    }
    
    private func setupBottomButtons() {
        setupHintButton()
        let stack = UIStackView(arrangedSubviews: [hintButton!, setupNoteButton(), setupEraseButton()])
        
        stack.axis = .horizontal
        stack.spacing = 40
        stack.distribution = .fill
        view.addSubview(stack)
        stack.pinBottom(to: view, 110)
        stack.pinCenterX(to: view)
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        //addTimeCounterButton();
        /*addContinueStopButton();
        addSettingsButton();*/
        addValidokuTable();
        setupSettings()
        setupErrorCounterLabel()
        setupTimer()
        setupStopPlayButton()
        setupValidokuDigits()
        setupBottomButtons()
        /*addHintButton();
        addNotesButton();
        addEraseButton();*/
    }
    
    private func setupSettings() {
        let button = ButtonWithImage(url: "https://cdn-icons-png.flaticon.com/512/561/561772.png", action: goToSettings)
        
        view.addSubview(button)
        
        button.pinRight(to: view, 0.15 * view.bounds.width);
        button.pinTop(to: view, 0.1 * view.bounds.height)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        setupView();
    }
    
    init(gameMode: Modes) {
        validokuTable = ValidokuTable(parent: UIView(), gameMode: gameMode)
        errorCounter = ErrorCounterLabel()
        time = TimeCounter()
        validokuDigits = ValidokuDigits()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(game: Game) {
        self.validokuTable = game.validokuTable
        self.errorCounter = game.errorCounter
        self.time = game.time
        self.validokuDigits = game.validokuDigits
        self.hintButton = game.hintButton
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func goToSettings() {
        // go to ValidokuSettings class implementation need
        print("")
    }
    
    @objc
    private func stopPlayButtonPressed() {
        
    }
    
    @objc
    private func hintButtonPressed() {
        hintButton?.decreaseHintCounter()
    }
    
    @objc
    private func noteButtonPressed() {
        for digit in validokuDigitsArr! {
            if isNoteMode {
                digit.changeTextColor(color: .gray)
            } else {
                digit.changeTextColor(color: UIColor(red: 72 / 255, green: 125 / 255, blue: 167 / 255, alpha: 1.0))
            }
        }
        
        if isNoteMode {
            isNoteMode = false
        } else {
            isNoteMode = true
        }
        
        let validokuDigitsStack = UIStackView(arrangedSubviews: validokuDigitsArr!)
        validokuDigitsStack.axis = .horizontal
        validokuDigitsStack.spacing = 10
        validokuDigitsStack.distribution = .fill
        view.addSubview(validokuDigitsStack)
        validokuDigitsStack.pinBottom(to: view, 200)
        validokuDigitsStack.pinCenterX(to: view)
    }
    
    @objc
    private func eraseButtonPressed() {
        
    }
    
    @objc
    private func numberButtonPressed() {
        
    }
}
