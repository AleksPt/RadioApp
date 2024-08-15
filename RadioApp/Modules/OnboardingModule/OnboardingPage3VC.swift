//
//  OnboardingPage2VC.swift
//  RadioApp
//
//  Created by Andrew Linkov on 03.08.2024.
//

import UIKit
import SnapKit

final class OnboardingPage3VC: UIViewController {
    
    var onComplete: (() -> Void)?
    
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .woman
        element.contentMode = .scaleAspectFill
        element.layer.opacity = 0.9
        return element
    }()
    
    private lazy var secondBackgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleAspectFill
        element.alpha = 0.9
        return element
    }()
    
    private lazy var startListeningButton: UIButton = {
        let element = UIButton()
        element.setTitle("Start Listening", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        element.backgroundColor = UIColor(named: "pinkBase")
        element.layer.cornerRadius = 10
        element.addTarget(self, action: #selector(startListening), for: .touchUpInside)
        return element
    }()
    
    private lazy var progressStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 10
        element.distribution = .fillProportionally
        return element
    }()
    
    private lazy var firstProgressView: UIView = {
        let element = UIView()
        element.backgroundColor = .lightGray
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var secondProgressView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.98, green: 0.61, blue: 0.69, alpha: 1.00)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var mainLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 40, weight: .bold)
        element.textColor = .white
        element.numberOfLines = 0
        element.text = "Enjoy now!"
        return element
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        view.backgroundColor = .blue
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(secondBackgroundImageView)
        view.addSubview(startListeningButton)
        view.addSubview(progressStackView)
        view.addSubview(mainLabel)
        
        progressStackView.addArrangedSubview(firstProgressView)
        progressStackView.addArrangedSubview(secondProgressView)
    }
    
    // MARK: - Selector methods
    @objc private func startListening() {
        onComplete?()
        
    }
}

// MARK: - Setup Constraints
extension OnboardingPage3VC {
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        secondBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startListeningButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(58)
            make.leading.trailing.equalToSuperview().inset(52)
            make.centerX.equalToSuperview()
        }
        
        progressStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(startListeningButton).inset(90)
        }
        
        firstProgressView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(50)
        }
        
        secondProgressView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(50)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(350)
        }
    }
}

