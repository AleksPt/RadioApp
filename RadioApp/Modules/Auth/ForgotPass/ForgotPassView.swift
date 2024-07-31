//
//  ForgotPassView.swift
//  RadioApp
//
//  Created by Алексей on 31.07.2024.
//

import UIKit
import SnapKit

final class ForgotPassView: UIView {
    
    // MARK: - UI
    private let customBackgroundView = CustomBackgroundView()
    
    private lazy var backButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.back.withRenderingMode(.alwaysOriginal), for: .normal)
        return element
    }()
    
    private let titleView = TitleView(typeTytle: .forgotPass)
    
    let emailView = TextFieldWithTitleView(
        titleLabel: "Email",
        isPassword: false
    )
    
    let passwordView = TextFieldWithTitleView(
        titleLabel: "Password",
        isPassword: true
    )
    
    let confirmPasswordView = TextFieldWithTitleView(
        titleLabel: "Confirm password",
        isPassword: true
    )
    
    let sentButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .blueLight
        element.titleLabel?.font = Font.getFont(.displayRegular, size: 30)
        element.setTitleColor(.white, for: .normal)
        element.setTitle("Sent", for: .normal)
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setupConstraints()
        
        passwordView.alpha = 0
        confirmPasswordView.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    func setDelegates(controller: ForgotPassViewController) {
        [emailView, passwordView, confirmPasswordView].forEach {
            $0.textField.delegate = controller
        }
    }
    
    func setTargetForButton(controller: ForgotPassViewController) {
        backButton.addTarget(
            controller,
            action: #selector(controller.didTapBackButton),
            for: .touchUpInside
        )
        sentButton.addTarget(
            controller,
            action: #selector(controller.didTapSentButton(_:)),
            for: .touchUpInside
        )
    }
    
    func updateView() {
        UIView.animate(
            withDuration: 0.25) { [weak self] in
                guard let self else { return }
                emailView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.25) { [weak self] in
                    guard let self else { return }
                    passwordView.alpha = 1
                    confirmPasswordView.alpha = 1
                    
                    sentButton.frame = sentButton.frame.offsetBy(dx: 0, dy: 92)
                } completion: { [weak self] _ in
                    guard let self else { return }
                    sentButton.snp.makeConstraints { [weak self] make in
                        guard let self else { return }
                        make.top.equalTo(passwordView.snp.bottom).offset(160)
                        make.width.equalTo(emailView.snp.width)
                        make.height.equalTo(73)
                        make.centerX.equalToSuperview()
                    }
                }
            }
    }
    
    // MARK: - Private methods
    private func setViews() {
        [
            customBackgroundView,
            backButton,
            titleView,
            emailView,
            passwordView,
            confirmPasswordView,
            sentButton,
        ].forEach {
            addSubview($0)
        }
    }
    
}

private extension ForgotPassView {
    func setupConstraints() {
        customBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(27)
            make.top.equalToSuperview().offset(112)
            make.leading.equalToSuperview().offset(43)
        }
        
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(35.43)
            make.leading.equalTo(backButton)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(21.51)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(21.51)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
        }
        
        confirmPasswordView.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(21.51)
            make.leading.trailing.equalTo(passwordView)
        }
        
        sentButton.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(70)
            make.width.equalTo(emailView.snp.width)
            make.height.equalTo(73)
            make.centerX.equalToSuperview()
        }
    }
}