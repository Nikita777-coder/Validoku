//
//  TimeCounter.swift
//  Validoku
//
//  Created by Xiaomi on 11.05.2023.
//
import UIKit

class TimeCounter: UIView {
    private let button: ButtonWithImage
    private var secondsCounter: Int
    private let countDownLabel: UILabel
    
    private func setupLabel() {
        countDownLabel.setWidth(50)
        countDownLabel.setHeight(20)
        countDownLabel.textColor = .gray
        countDownLabel.text = "00:00"
        countDownLabel.font = .systemFont(ofSize: 15, weight: .bold)
        addSubview(countDownLabel)
        countDownLabel.pinLeft(to: self)
        countDownLabel.pinCenterY(to: self)
    }
    
    private func setupButton() {
        button.setWidth(35)
        button.setHeight(35)
        addSubview(button)
        button.pinRight(to: self)
    }
    
    private func setupView() {
        setWidth(86)
        setHeight(36)
    }
    
    private func makeDesign() {
        setupView()
        setupButton()
        setupLabel()
    }
    
    init() {
        button = ButtonWithImage(url: "https://cdn-icons-png.flaticon.com/512/2055/2055568.png")
        secondsCounter = 0
        countDownLabel = UILabel()
        
        super.init(frame: .zero)
        
        makeDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startTick() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        secondsCounter += 1
        let minutes = secondsCounter / 60
        let seconds = secondsCounter % 60
        countDownLabel.text = String(format: "%02d:%02d", minutes, seconds)
        reloadInputViews()
    }
    
    public func getSecondsCounter() -> Int {
        return secondsCounter
    }
}
