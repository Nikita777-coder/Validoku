//
//  SudokuButton.swift
//  Validoku
//
//  Created by Xiaomi on 30.04.2023.
//
import UIKit

enum ValidokuCellMode {
    case None
    case Neighbour
    case Selected
}

enum MainNumberMode {
    case System
    case User
    case Incorrect
}

enum BorderSide {
    case Top
    case Right
    case Bottom
    case Left
}

/**
 if cell has correct digit then the note mode would be unvailable for cell
 If there was erase button pressed in cell then all notes will erase
 */

final class ValidokuCell : UICollectionViewCell {
    private let parent: UIView
    private let title: UILabel
    private let label: UILabel
    private var count = 0
    private var number =  ""
    private var mode = MainNumberMode.User
    private var isNoteMode = false
    private var rightBorder: UIView?
    private var leftBorder: UIView?
    private var bottomBorder: UIView?
    private var topBorder: UIView?
    private var cellMode: ValidokuCellMode = .None
    
    private func makeBackgroundColor(mode: ValidokuCellMode) {
        switch mode {
        case .None:
            self.backgroundColor = .systemGray6;
        case .Neighbour:
            self.backgroundColor = UIColor(red: 224.0 / 255.0, green: 224.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
        case .Selected:
            self.backgroundColor = UIColor(red: 153.0 / 255.0, green: 195.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
        }
    }
    
    private func makeMainNumberColor(mode: MainNumberMode) {
        switch mode {
        case .System:
            title.textColor = .black
        case .User:
            title.textColor = .blue
        case .Incorrect:
            title.textColor = .red
        }
        
        reloadInputViews()
    }
    
    private func addNumber() {
        title.text = String(describing: number);
        title.font = .systemFont(ofSize: parent.bounds.height * 0.02,
                                      weight: .bold);
        makeMainNumberColor(mode: .System)
        
        addSubview(title);
        title.pinCenter(to: self);
    }
    
    private func labelNotesSetting() {
        label.font = .systemFont(ofSize: parent.bounds.height * 0.01,
                                 weight: .bold);
        label.textColor = .gray
        label.numberOfLines = 0
        
        addSubview(label)
        label.pinCenterX(to: self)
        label.pinTop(to: self, 4)
    }
    
    private func digitsSetting() {
        if mode != .System {
            if isNoteMode {
                label.isHidden = false
                title.isHidden = true
            } else {
                label.isHidden = true
                title.isHidden = false
            }
        }
        
        reloadInputViews()
    }
    
    /*private func setupAction() {
        let button = UIButton()
        button.addTarget(self, action: #selector(cellTaped), for: .touchUpInside)
        addSubview(button)
        button.pin(to: self)
    }*/
    
    private func makeDesign() {
        setWidth(40)
        setHeight(40)
        
        makeBackgroundColor(mode: .None);
        
        setHeight(40)
        setWidth(40)
        
        layer.borderWidth = 1.0
        layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        addNumber()
        labelNotesSetting()
        digitsSetting()
        //setupAction()
    }
    
    private func setupBorder(border: BorderSide) {
        switch border {
        case .Bottom:
            bottomBorder = UIView()
            bottomBorder!.setWidth(40)
            bottomBorder!.setHeight(3)
            bottomBorder!.layer.borderWidth = 4.0
            addSubview(bottomBorder!)
            bottomBorder!.pinBottom(to: self)
        case .Top:
            topBorder = UIView()
            topBorder!.setWidth(40)
            topBorder!.setHeight(3)
            topBorder!.layer.borderWidth = 4.0
            addSubview(topBorder!)
            topBorder!.pinTop(to: self)
        case .Right:
            rightBorder = UIView()
            rightBorder!.setWidth(3)
            rightBorder!.setHeight(40)
            rightBorder!.layer.borderWidth = 4.0
            addSubview(rightBorder!)
            rightBorder!.pinRight(to: self)
        case .Left:
            leftBorder = UIView()
            leftBorder!.setWidth(5)
            leftBorder!.setHeight(40)
            leftBorder!.layer.borderWidth = 4.0
            addSubview(leftBorder!)
            leftBorder!.pinLeft(to: self)
        }
    }
    
    override init(frame: CGRect) {
        parent = UIView()
        title = UILabel()
        label = UILabel()
        super.init(frame: .zero)
        
        makeDesign()
    }
    
    init(parent: UIView) {
        self.parent = parent
        title = UILabel()
        label = UILabel()
        super.init(frame: .zero)
        makeDesign()
    }
    
    init(digit: Int, parent: UIView) {
        self.parent = parent
        title = UILabel()
        number = String(digit)
        label = UILabel()
        super.init(frame: .zero)
        makeDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func removeNumber(number: Int) {
        var num = String(number)
        
        if label.text != nil {
            let ind = label.text!.firstIndex(of: num.first!)
            
            if (ind != label.text!.startIndex) {
                num.insert(label.text![label.text!.index(before: ind!)], at: num.startIndex)
            }
            
            label.text = label.text?.replacingOccurrences(of: num, with: "")
            count -= 1
            // SudokuCellLogger.info(SudokuCell successful removing of number-note)
        } else {
            // SudokuCellLogger.warn(SudokuCell <id> can't remove number-note because it's nil)
        }
    }
    
    /**
        If there wasn't entered digit-note in self.cell then it will be added to the list of digits-notes. Otherwize it will be removed from list of digits-notes.
     */
    public func addOrDeleteNoteNumber(number: Int) {
        let num = String(number)
        
        if label.text == nil {
            label.text = num
            count += 1
            return;
        }
        
        if (!label.text!.contains(num)) {
            if count % 3 == 0 {
                label.text! += num
            } else {
                label.text! += " " + num
            }
            
            if count % 3 == 2 {
                label.text! += "\n"
            }
            
            count += 1
        } else {
            removeNumber(number: number)
            // logger warning with already contains digit message
        }
        
        reloadInputViews()
    }
    
    public func digit(digit: Int, mode: MainNumberMode) {
        title.text = String(digit)
        makeMainNumberColor(mode: mode)
    }
    
    public func changeMode(mode: ValidokuCellMode) {
        cellMode = mode
        makeBackgroundColor(mode: mode);
    }
    
    public func updateDigitsMode(isNoteMode: Bool) {
        self.isNoteMode = isNoteMode
        digitsSetting()
    }
    
    public func changeBorderWidth(border: BorderSide) {
        setupBorder(border: border)
    }
    
    public func getMode() -> ValidokuCellMode {
        return cellMode
    }
    
    /*@objc func cellTaped() {
        changeMode(mode: .Selected)
    }*/
}

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension ValidokuCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
