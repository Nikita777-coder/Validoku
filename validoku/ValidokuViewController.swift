//
//  ValidokuViewController.swift
//  Validoku
//
//  Created by Xiaomi on 16.05.2023.
//

import UIKit

final class ValidokuViewController: UIViewController {
    private enum Constants {
        static let bgColor: UIColor = .white
        static let radius: CGFloat = 10
        static let offset: Double = 20
        static let valColor: UIColor = .black
    }
    
    private let validokuView: UICollectionView = {
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.bgColor
        view.addSubview(validokuView)
        
        validokuView.pinCenterY(to: view)
        validokuView.pinHeight(to: validokuView.widthAnchor)
        validokuView.pinHorizontal(to: view, Constants.offset)
        
        validokuView.backgroundColor = Constants.valColor
        validokuView.layer.cornerRadius = Constants.radius
        
        validokuView.register(
            TimeCell.self,
            forCellWithReuseIdentifier: TimeCell.reuseIdentifier
        )
        
        validokuView.dataSource = self
        validokuView.delegate = self
    }
}

extension ValidokuViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 81
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimeCell.reuseIdentifier,
            for: indexPath
        ) as? TimeCell
        
        // Тут можно редачить границы клетки
        return cell ?? UICollectionViewCell()
    }
}

extension ValidokuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // здесь редачится св-ва ячейки
        print("null")
    }
}

extension ValidokuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width - 40) / 9 - 4
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

final class TimeCell: UICollectionViewCell {
    static let reuseIdentifier: String = "TimeCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        wrap.pin(to: contentView, 2)
        wrap.backgroundColor = .systemPink
    }
}

// (x + 4) * 9 = UIScene.main.frame.height - 40
// x = (UIScene.main.frame.height - 40) / 9 - 4
