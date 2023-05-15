//
//  SudokuTable.swift
//  Validoku
//
//  Created by Xiaomi on 18.04.2023.
//

import UIKit

class ValidokuGenerator {
    class Checker {
        weak var parent: ValidokuGenerator! = nil
        private final var VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9];
        
        private func areRowsCorrect() -> Bool {
            for i in 0...8 {
                var row = parent.solution[i];
                row = row.sorted();

                for j in 0...8 {
                    if VALUES[j] != row[j] {
                        return false;
                    }
                }
            }

            return true;
        }

        private func areColumnsCorrect() -> Bool {
            for j in 0...8 {
                var column: [Int] = [];

                for i in 0...8 {
                    let el = parent.solution[i][j];
                    column.append(el);
                }

                column = column.sorted();

                for k in 0...8 {
                    if VALUES[k] != column[k] {
                        return false;
                    }
                }
            }

            return true;
        }

        private func areAreasCorrect() -> Bool {
            for i in 0...2 {
                for j in 0...2 {
                    var curVal: [Int] = [];

                    for k: Int in (i % 3) * 3...(i % 3) * 3 + 2 {
                        for l: Int in (j % 3) * 3...(j % 3) * 3 + 2 {
                            let el = parent.solution[k][l];
                            curVal.append(el);
                        }
                    }

                    curVal = curVal.sorted();

                    for k in 0...8 {
                        if VALUES[k] != curVal[k] {
                            return false;
                        }
                    }
                }
            }

            return true;
        }
        
        public func isValidokuCorrect() -> Bool {
            if !areRowsCorrect() {
                return false;
            }

            if !areColumnsCorrect() {
                return false;
            }

            return areAreasCorrect();
        }
    }
    
    private var solution: [[Int]];
    private var workValues: [Int];
    private final let checker: Checker;
    
    private func fillRowWithRandomValuesAndFillWorkValues() {
        workValues = [];

        while (workValues.count != 9) {
            let val = Int.random(in: 1...9);

            if (!workValues.contains(val)) {
                workValues.append(val);
            }
        }
    }

    private func getStartInd(rowInd: Int) -> Int {
        return (rowInd % 3) * 3 + rowInd / 3;
    }
    
    private func insertRow(rowInd: Int) {
        let start = getStartInd(rowInd: rowInd);
        var curInd = start;
        var row: [Int] = [];
        row.append(workValues[curInd % 9]);
        curInd = (curInd + 1) % 9;

        while (curInd != start) {
            row.append(workValues[curInd % 9]);
            curInd = (curInd + 1) % 9;
        }
        
        solution.append(row)
    }
    
    private func generate() {
        var errorCounter = 0;
        
        fillRowWithRandomValuesAndFillWorkValues();
        
        for i in 0...8 {
            insertRow(rowInd: i);
        }
        
        while !checker.isValidokuCorrect() && errorCounter < 6 {
            solution = [[]];
            fillRowWithRandomValuesAndFillWorkValues();
            
            for i in 0...8 {
                insertRow(rowInd: i);
            }
            
            errorCounter += 1;
        }
        
        if errorCounter == 6 {
            //Logger.addError(errorType: ValidokuGenerationErrors(message: "errorCounter == 6"), classError: SudokuGenerator.self, methodName: "generate");
            
            /*let alert = UIAlertController(title: "Alert", message: "Oops... Sorry, but system couldn't generate sudoku", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
            
            alert.addAction(okAction);
            
            self.present(alert, animated: true, completion: nil);*/
        }
    }

    init() {
        checker = Checker();
        solution = [[Int]]()
        workValues = [];
        checker.parent = self;
        generate();
    }

    public func getSolution() -> [[Int]] {
        return solution;
    }
}


class ValidokuTable: UIView {
    private var count = 0
    private let solution: [[Int]];
    private var userValidokuTable: [[ValidokuCell]]
    private var parent: UIView
    private let gameMode: Modes
    private static var collectionView: UIStackView = UIStackView()
    
    private func userSudokuTableToUiViewCollection() {
        setWidth(360)
        setHeight(360)
        var rowCounter = 0
        var stackStack: [UIStackView] = []
        
        for arrCells in userValidokuTable {
            var coun = 0
            
            for cell in arrCells {
                /*collectionView.addSubview(cell)
                cell.pinLeft(to: collectionView, Double(coun * 40))
                cell.pinTop(to: collectionView, Double(rowCounter * 40))*/
                coun += 1
                
                if rowCounter % 3 == 0 {
                    cell.changeBorderWidth(border: .Top)
                }
                
                if coun % 3 == 0 {
                    cell.changeBorderWidth(border: .Right)
                }
                
                if coun == 1 {
                    cell.changeBorderWidth(border: .Left)
                }
                
                if rowCounter == 8 {
                    cell.changeBorderWidth(border: .Bottom)
                }
            }
            
            let stackView = UIStackView(arrangedSubviews: arrCells)
            stackView.axis = .horizontal
            stackView.distribution = .fill
    
            stackStack.append(stackView)
            
            rowCounter += 1
        }
        
        ValidokuTable.collectionView = UIStackView(arrangedSubviews: stackStack)
        ValidokuTable.collectionView.axis = .vertical
        ValidokuTable.collectionView.distribution = .fill
        
        addSubview(ValidokuTable.collectionView)
        ValidokuTable.collectionView.pin(to: self)
    }
    
    private func generatePare() -> (Int, Int) {
        let row = Int.random(in: 0...8)
        var column = Int.random(in: 0...8);
        
        while column == row {
            column = Int.random(in: 0...8);
        }
        
        let pair = (row, column);
        return pair;
    }
    
    private func generatePositions() -> [(Int, Int)] {
        var count = 0;
        
        switch gameMode {
        case .Rare:
            count = Int.random(in: 30...40)
        case .Medium:
            count = Int.random(in: 25...29)
        case .WellDone:
            count = Int.random(in: 19...24)
        case .Burned:
            count = Int.random(in: 15...19)
        case .PVP:
            count = Int.random(in: 15...40)
        case .Shable:
            count = Int.random(in: 15...40)
        case .Custom:
            count = self.count
        }
        
        var pairs: [(Int, Int)] = [];
        
        for _ in 0...(count - 1) {
            var pair = generatePare()
            
            while pairs.contains(pair: pair) {
                pair = generatePare()
            }
            
            pairs.append(pair)
        }
        
        return pairs;
    }
    
    private func setupUserTable() {
        let positions = generatePositions();
        
        for _ in 0...8 {
            var arr = [ValidokuCell]();
            
            for _ in 0...8 {
                arr.append(ValidokuCell(parent: parent));
            }
            
            userValidokuTable.append(arr)
        }
        
        for pair in positions {
            userValidokuTable[pair.0][pair.1].digit(digit: solution[pair.0][pair.1], mode: .System)
        }
    }
    
    private func addSudokuTable() {
        if userValidokuTable.isEmpty {
            /*collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(ValidokuCell.self, forCellWithReuseIdentifier: ValidokuCell.identifier)*/
            
            setupUserTable();
        }
        
        userSudokuTableToUiViewCollection();
    }
    
    private func setupElements() {
        addSudokuTable()
    }
    
    init(parent: UIView, gameMode: Modes, count: Int = 0) {
        self.count = count
        userValidokuTable = []
        self.parent = parent
        self.gameMode = gameMode
        solution = ValidokuGenerator().getSolution()
        ///collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        super.init(frame: .zero)
        
        setupElements()
    }
    
    init(table: ValidokuTable) {
        self.userValidokuTable = table.userValidokuTable
        self.parent = table.parent
        self.gameMode = table.gameMode
        self.solution = table.solution
        
        super.init(frame: .zero)
        
        addSudokuTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeParent(parent: UIView) {
        self.parent = parent
    }
}

extension Array<(Int, Int)> {
    public func contains(pair: (Int, Int)) -> Bool {
        for p in self {
            if p.0 == pair.0 && p.1 == pair.1 {
                return true
            }
        }
        
        return false
    }
}

/*extension ValidokuTable: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userValidokuTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ValidokuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ValidokuCell
        
        let column = indexPath.item % 9
        let row = indexPath.item / 9
        cell = userValidokuTable[row][column]
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)

        cell.addSubview(button)
        
        return cell
    }
    
    @objc func buttonTaped(collectionView: UICollectionView, cell: ValidokuCell) {
        cell.changeMode(mode: .Selected)
        
        
    }
}

extension ValidokuTable: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ValidokuCell
        
        cell.changeMode(mode: .Selected)
    }
}*/

