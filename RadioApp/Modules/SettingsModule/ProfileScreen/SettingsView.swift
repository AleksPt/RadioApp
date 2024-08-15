//
//  SettingsView.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    private let colorBack = UIColor(red: 37/255, green: 40/255, blue: 54/255, alpha: 1.0)
    private let colorImage = UIColor(red: 146/255, green: 146/255, blue: 157/255, alpha: 1.0)
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = .background
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        
        
        return image
    }()
    
    //MARK: - Profile Rectangle
    
    lazy var rectangleProfile: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        image.clipsToBounds = true
        image.layer.cornerRadius = 27
        return image
    }()
    
    lazy var nameProfile: UILabel = {
        let label = UILabel()
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var emailProfile: UILabel = {
        let label = UILabel()
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var stackNameWithEmail: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        
        stack.addArrangedSubview(nameProfile)
        stack.addArrangedSubview(emailProfile)
        
        return stack
    }()
    
    lazy var renameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .blueLight
        
        return button
    }()
    
    //MARK: - Rectangle Setting 1
    
    lazy var firstSettingRectangle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var titleFirstSettingRectangle: UILabel = {
        let label = UILabel()
        label.text = "General"
        label.font = Font.getFont(.displayBold, size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Notification
    
    lazy var backNotificationImage: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var notificationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bell.fill")
        image.tintColor = colorImage
        return image
    }()
    
    lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification"
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var switchNotification: UISwitch = {
        let switchIs = UISwitch()
        switchIs.onTintColor = .blueLight
        switchIs.thumbTintColor = .darkGray
        return switchIs
    }()
    
    lazy var stackNotification: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        stack.addArrangedSubview(backNotificationImage)
        stack.addArrangedSubview(notificationLabel)
        stack.addArrangedSubview(switchNotification)
        
        return stack
    }()
    
    lazy var rectangleDivider: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    //MARK: - Language
    
    lazy var buttonLanguage: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(getSet), for: .touchUpInside)
        return button
    }()
    
    lazy var backLanguageView: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var languageImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "globe")
        image.tintColor = colorImage
        return image
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var segueImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right.circle")
        image.tintColor = .blueLight
        image.layer.cornerRadius = 15
        return image
    }()
    
    lazy var stackLanguage: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        stack.addArrangedSubview(backLanguageView)
        stack.addArrangedSubview(languageLabel)
        stack.addArrangedSubview(segueImage)
        
        return stack
    }()
    
    //MARK: - Rectangle Setting 2
    
    lazy var secondSettingRectangle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var moreTitle: UILabel = {
        let label = UILabel()
        label.text = "More"
        label.font = Font.getFont(.displayBold, size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Legal and Policies
    
    lazy var buttonLegal: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    @objc func getSet() {
        
    }
    
    lazy var backLegalView: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var shieldImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "shield.fill")
        image.tintColor = colorImage
        return image
    }()
    
    lazy var shieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Legal and Policies"
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var chevronImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right.circle")
        image.tintColor = .blueLight
        image.layer.cornerRadius = 15
        return image
    }()
    
    lazy var stackShield: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        stack.addArrangedSubview(backLegalView)
        stack.addArrangedSubview(shieldLabel)
        stack.addArrangedSubview(chevronImage)
        return stack
    }()
    
    lazy var dividerRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var buttonAbout: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(goToAboutViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var infoBackView: UIView = {
        let view = UIView()
        view.backgroundColor = colorBack
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var infoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "info.circle")
        image.tintColor = colorImage
        return image
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.font = Font.getFont(.displayMedium, size: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var chevronImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right.circle")
        image.tintColor = .blueLight
        return image
    }()
    
    lazy var stackAbout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        stack.addArrangedSubview(infoBackView)
        stack.addArrangedSubview(infoLabel)
        stack.addArrangedSubview(chevronImage2)
        
        return stack
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = Font.getFont(.displayBold, size: 16)
        
        button.backgroundColor = UIColor(red: 5/255, green: 216/255, blue: 232/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        constraintsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - @objc function
    
    @objc func goToAboutViewController() {
        
    }
    
}

extension SettingsView {
    func setupUI(){
        addSubview(backView)
        backView.addSubview(backgroundImage)
        
        backgroundImage.addSubview(rectangleProfile)
        backgroundImage.addSubview(firstSettingRectangle)
        backgroundImage.addSubview(secondSettingRectangle)
        backgroundImage.addSubview(exitButton)
        
        rectangleProfile.addSubview(profileImage)
        rectangleProfile.addSubview(stackNameWithEmail)
        rectangleProfile.addSubview(renameButton)
        
        firstSettingRectangle.addSubview(titleFirstSettingRectangle)
        firstSettingRectangle.addSubview(stackNotification)
        firstSettingRectangle.addSubview(rectangleDivider)
        firstSettingRectangle.addSubview(stackLanguage)
        
        stackLanguage.addSubview(buttonLanguage)
        backLanguageView.addSubview(languageImage)
        backNotificationImage.addSubview(notificationImage)
        
        secondSettingRectangle.addSubview(moreTitle)
        secondSettingRectangle.addSubview(stackShield)
        secondSettingRectangle.addSubview(dividerRectangle)
        secondSettingRectangle.addSubview(stackAbout)
        
        stackShield.addSubview(buttonLegal)
        backLegalView.addSubview(shieldImage)
        infoBackView.addSubview(infoImage)
        stackAbout.addSubview(buttonAbout)
    }
    
    func constraintsUI() {
        
        backView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
            make.top.equalTo(self.snp.top)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading)
            make.trailing.equalTo(backView.snp.trailing)
            make.bottom.equalTo(backView.snp.bottom)
            make.top.equalTo(backView.snp.top)
        }
        
        //MARK: - Rectangle Profile Setup UI
        
        rectangleProfile.snp.makeConstraints { make in
            make.leading.equalTo(backgroundImage.snp.leading).inset(30)
            make.trailing.equalTo(backgroundImage.snp.trailing).inset(30)
            make.top.equalTo(backgroundImage.safeAreaLayoutGuide.snp.top).inset(35)
            make.height.equalTo(90)
        }
        
        profileImage.snp.makeConstraints { make in
            make.leading.equalTo(rectangleProfile.snp.leading).inset(10)
            make.centerY.equalTo(rectangleProfile.snp.centerY)
            make.height.width.equalTo(54)
        }
        
        stackNameWithEmail.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(15)
            make.centerY.equalTo(rectangleProfile.snp.centerY)
        }
        
        renameButton.snp.makeConstraints { make in
            make.trailing.equalTo(rectangleProfile.snp.trailing).inset(15)
            make.centerY.equalTo(rectangleProfile.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        //MARK: - Setup Rectangle First Setting
        
        firstSettingRectangle.snp.makeConstraints { make in
            make.top.equalTo(rectangleProfile.snp.bottom).offset(30)
            make.leading.equalTo(backgroundImage.snp.leading).inset(30)
            make.trailing.equalTo(backgroundImage.snp.trailing).inset(30)
            make.height.equalTo(200)
        }
        
        titleFirstSettingRectangle.snp.makeConstraints { make in
            make.top.equalTo(firstSettingRectangle.snp.top).inset(15)
            make.leading.equalTo(firstSettingRectangle.snp.leading).inset(15)
        }
        
        //MARK: - Stack Notification
        
        backNotificationImage.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        notificationImage.snp.makeConstraints { make in
            make.centerX.equalTo(backNotificationImage.snp.centerX)
            make.centerY.equalTo(backNotificationImage.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        stackNotification.snp.makeConstraints { make in
            make.leading.equalTo(firstSettingRectangle.snp.leading).inset(15)
            make.trailing.equalTo(firstSettingRectangle.snp.trailing).inset(15)
            make.top.equalTo(titleFirstSettingRectangle.snp.bottom).offset(25)
            make.height.equalTo(40)
        }
        
        rectangleDivider.snp.makeConstraints { make in
            make.top.equalTo(stackNotification.snp.bottom).offset(15)
            make.leading.equalTo(firstSettingRectangle.snp.leading).inset(15)
            make.trailing.equalTo(firstSettingRectangle.snp.trailing).inset(15)
            make.height.equalTo(1)
        }
        
        //MARK: - Stack Language
        
        buttonLanguage.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        stackLanguage.snp.makeConstraints { make in
            make.leading.equalTo(firstSettingRectangle.snp.leading).inset(15)
            make.trailing.equalTo(firstSettingRectangle.snp.trailing).inset(15)
            make.top.equalTo(rectangleDivider.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        
        backLanguageView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        languageImage.snp.makeConstraints { make in
            make.centerX.equalTo(backLanguageView.snp.centerX)
            make.centerY.equalTo(backLanguageView.snp.centerY)
            make.height.width.equalTo(20)
        }
        
        segueImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        //MARK: - Setup Rectangle Second Setting
        
        secondSettingRectangle.snp.makeConstraints { make in
            make.top.equalTo(firstSettingRectangle.snp.bottom).offset(30)
            make.leading.equalTo(backgroundImage.snp.leading).inset(30)
            make.trailing.equalTo(backgroundImage.snp.trailing).inset(30)
            make.height.equalTo(200)
        }
        
        moreTitle.snp.makeConstraints { make in
            make.top.equalTo(secondSettingRectangle.snp.top).inset(15)
            make.leading.equalTo(secondSettingRectangle.snp.leading).inset(15)
        }
        
        //MARK: - Rules Stack
        
        buttonLegal.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        stackShield.snp.makeConstraints { make in
            make.leading.equalTo(secondSettingRectangle.snp.leading).inset(15)
            make.trailing.equalTo(secondSettingRectangle.snp.trailing).inset(15)
            make.top.equalTo(moreTitle.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        
        backLegalView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        shieldImage.snp.makeConstraints { make in
            make.centerX.equalTo(backLegalView.snp.centerX)
            make.centerY.equalTo(backLegalView.snp.centerY)
            make.height.width.equalTo(20)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        dividerRectangle.snp.makeConstraints { make in
            make.leading.equalTo(secondSettingRectangle.snp.leading).inset(15)
            make.trailing.equalTo(secondSettingRectangle.snp.trailing).inset(15)
            make.top.equalTo(stackShield.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        //MARK: - About Stack
        
        buttonAbout.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        stackAbout.snp.makeConstraints { make in
            make.leading.equalTo(secondSettingRectangle.snp.leading).inset(15)
            make.trailing.equalTo(secondSettingRectangle.snp.trailing).inset(15)
            make.top.equalTo(dividerRectangle.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        
        infoBackView.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        infoImage.snp.makeConstraints { make in
            make.centerX.equalTo(infoBackView.snp.centerX)
            make.centerY.equalTo(infoBackView.snp.centerY)
            make.height.width.equalTo(20)
        }
        
        chevronImage2.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        exitButton.snp.makeConstraints { make in
            make.leading.equalTo(backView.snp.leading).inset(30)
            make.trailing.equalTo(backView.snp.trailing).inset(30)
            make.height.equalTo(50)
            make.bottom.equalTo(backView.safeAreaLayoutGuide.snp.bottom).inset(25)
        }
        
        
    }
}
