//
//  OnboardingPage1VC.swift
//  RadioApp
//
//  Created by Andrew Linkov on 03.08.2024.
//

import UIKit
import SnapKit

final class OnboardingPage2VC: UIPageViewController {
    
    var pages = [UIViewController]()

    
    // MARK: - UI Properties
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = .background
        element.contentMode = .scaleAspectFill
        return element
    }()
    
    private lazy var skipButton: UIButton = {
        let element = UIButton()
        element.setTitle("Skip", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        element.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return element
    }()
    
    private lazy var continueButton: UIButton = {
        let element = UIButton()
        element.setTitle("Continue", for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        element.backgroundColor = UIColor(named: "pinkBase")
        element.layer.cornerRadius = 25
        element.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
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
        element.backgroundColor = UIColor(red: 0.98, green: 0.61, blue: 0.69, alpha: 1.00)
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var secondProgressView: UIView = {
        let element = UIView()
        element.backgroundColor = .lightGray
        element.layer.cornerRadius = 5
        return element
    }()
    
    private lazy var mainLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 55, weight: .bold)
        element.textColor = .white
        element.numberOfLines = 0
        let fullString = "LET'S GET STARTED"
        return element
    }()

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(skipButton)
        view.addSubview(continueButton)
        view.addSubview(progressStackView)
        view.addSubview(mainLabel)
        
        
        progressStackView.addArrangedSubview(firstProgressView)
        progressStackView.addArrangedSubview(secondProgressView)
    }
    
    // MARK: - Selector methods
    @objc private func continueButtonTapped() {
        print("continueButtonTapped")
        navigationController?.pushViewController(OnboardingPage3VC(),animated: true)
    }
    
    @objc private func skipButtonTapped() {
        print("skipButtonTapped")
    }
}

// MARK: - Setup Constraints
extension OnboardingPage2VC {
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(skipButton).inset(50)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width / 1.8)
        }
        
        progressStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(continueButton).inset(90)
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
            make.centerX.equalToSuperview()
            make.bottom.equalTo(progressStackView).inset(40)
        }
    }
}

