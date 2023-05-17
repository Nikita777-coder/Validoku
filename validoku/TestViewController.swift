//
//  TestViewController.swift
//  Validoku
//
//  Created by Xiaomi on 17.05.2023.
//

import UIKit

final class TestViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        let t = ValidokuTable(parent: view, gameMode: .Rare)
        view.addSubview(t)
        t.pinCenter(to: view)
    }
}
