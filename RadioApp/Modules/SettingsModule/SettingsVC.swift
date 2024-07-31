//
//  SettingsVC.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import UIKit

final class SettingsVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "SettingsVC"
    }
}