//
//  RenameVC.swift
//  RadioApp
//
//  Created by Drolllted on 05.08.2024.
//

import UIKit

final class RenameVC: UIViewController {
    
    var completionHandlerAvatar: ((UIImage?) -> ())?
    var completionHandlerName: ((String?) -> ())?
    var completionHandlerEmail: ((String?) -> ())?
    var avatar: UIImage?
    var name: String?
    var email: String?
    
    private var renameView: RenameView!
    private let imagePicker = ImagePicker()
    private let auth = FirebaseService.shared
    
    override func loadView() {
        renameView = RenameView()
        view = renameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        addTapGestureToHideKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if auth.isAuthorizedWithGoogle {
            [
                renameView.textFieldEmail,
                renameView.textFieldEmailLabel,
                renameView.backViewEmailTextField,
                renameView.passwordTextField,
                renameView.confirmPasswordTextField
            ].forEach {
                $0.isHidden = true
            }
            
            renameView.saveButton.snp.remakeConstraints { make in
                make.top.equalTo(renameView.backViewNameTextField.snp.bottom).offset(46.56)
                make.leading.equalTo(renameView.backView.snp.leading).inset(30)
                make.trailing.equalTo(renameView.backView.snp.trailing).inset(30)
                make.height.equalTo(55)
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Rename"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Font.getFont(.displayBold, size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(goBackToSettings)
        )
    }
    
    private func setupView() {
        renameView.avatarImage.image = avatar ?? UIImage(systemName: "person.circle")
        renameView.nameLabel.text = name
        renameView.emailLabel.text = email
        renameView.textFieldName.placeholder = name
        renameView.textFieldEmail.placeholder = email
        
        renameView.reinstallImageButton.addTarget(
            self,
            action: #selector(addImage),
            for: .touchUpInside
        )
        renameView.saveButton.addTarget(
            self,
            action: #selector(saveInfo),
            for: .touchUpInside
        )
    }
    
    @objc func goBackToSettings() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addImage() {
        let alertController = UIAlertController(title: "Add Image?", message: "How do you want to add a picture?", preferredStyle: .actionSheet)
        
        let alertAddWithGallery = UIAlertAction(title: "Gallery", style: .default) { alert in
            self.imagePicker.showImagePicker(for: self, sourseType: .photoLibrary, renameView: self.renameView)
        }
        let alertAddWithPhotoes = UIAlertAction(title: "Photo", style: .default) { alert in
            self.imagePicker.showImagePicker(for: self, sourseType: .camera, renameView: self.renameView)

        }
        let canselButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertAddWithGallery)
        alertController.addAction(alertAddWithPhotoes)
        alertController.addAction(canselButton)
        
        present(alertController, animated: true)
        
    }
    
    @objc func saveInfo() {
        updateUserData() { [weak self] updateEmail in
            guard let self else { return } 
            if updateEmail {
                showAlert(updateEmail: true)
            } else {
                showAlert(updateEmail: false)
            }
        }
    }
}

// MARK: - Update User Data
private extension RenameVC {
    func updateUserData(completion: @escaping (Bool)->()) {
        var alertLoadingIsPresented = false
        let name = renameView.textFieldName.text
        let email = renameView.textFieldEmail.text
        let password = renameView.passwordTextField.textFieldPassword.text
        let confirmPassword = renameView.confirmPasswordTextField.textFieldPassword.text
        
        // устанавливаем аватар
        completionHandlerAvatar?(renameView.avatarImage.image)
        
        // проверка - такое имя уже есть?
        guard renameView.textFieldName.text?.lowercased() != User.shared.name?.lowercased() else {
            showErrorView(.nameExist)
            return
        }
        
        // устанавливаем имя
        if let name, !name.isEmpty {
            auth.updateUserName(name)
            completionHandlerName?(renameView.textFieldName.text)
        }
        
        // проверка - такая почта уже есть?
        guard email?.lowercased() != User.shared.email?.lowercased() else {
            showErrorView(.emailExist)
            return
        }
        
        // обновляем почту
        if let email, !email.isEmpty {
            // проверяем почту на валидность
            guard auth.isValidEmail(email) else {
                showErrorView(.incorrectEmail)
                return
            }
            completionHandlerEmail?(renameView.textFieldEmail.text)
            AlertLoading.shared.isPresented(true, from: self)
            alertLoadingIsPresented = true
            auth.updateEmail(email) { [weak self] result in
                guard let self else { return }
                AlertLoading.shared.isPresented(false, from: self)
                switch result {
                case .success(_):
                    completion(true)
                case .failure(_):
                    showErrorView(.failUpdateEmailOrPassword)
                }
            }
        }
        
        // обновляем пароль
        if let password, !password.isEmpty {
            // проверяем пароль на количество символов
            guard password.count >= 6 else {
                showErrorView(.incorrectPassword)
                return
            }
            // проверяем поля паролей на совпадение
            guard password == confirmPassword else {
                showErrorView(.passwordNotConfirm)
                return
            }
            alertLoadingIsPresented ? () : AlertLoading.shared.isPresented(true, from: self)
            auth.updatePassword(password) { [weak self] result in
                guard let self else { return }
                AlertLoading.shared.isPresented(false, from: self)
                switch result {
                case .success(_):
                    completion(false)
                case .failure(_):
                    showErrorView(.failUpdateEmailOrPassword)
                }
            }
        }
        completion(false)
    }
}

// MARK: - Alert
private extension RenameVC {
    /// Alert с просьбой подтвердить свою почту по ссылке
    func showAlert(updateEmail: Bool) {
        let alert = UIAlertController(
            title: "Fine 😊",
            message: updateEmail ? "Follow the link in the email to confirm the mail change" : "You have successfully updated your profile details",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
