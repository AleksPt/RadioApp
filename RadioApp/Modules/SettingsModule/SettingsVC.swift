//
//  SettingsVC.swift
//  RadioApp
//
//  Created by dsm 5e on 30.07.2024.
//

import WebKit
import UIKit
import RxSwift
import RxCocoa

final class SettingsVC: UIViewController {

    private var settingView: SettingsView!
    private let disposeBag = DisposeBag()
    private let auth = FirebaseService.shared
    
    var onLogout: (() -> Void)?

    override func loadView() {
        settingView = SettingsView()
        view = settingView
    }

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
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : Font.getFont(.displayBold, size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(goBack))
        
        settingView.buttonLegal.addTarget(self, action: #selector(goToPrivacyVC), for: .touchUpInside)
        settingView.renameButton.addTarget(self, action: #selector(goToRenameVC), for: .touchUpInside)
        settingView.buttonAbout.addTarget(self, action: #selector(goToAboutVC), for: .touchUpInside)
        settingView.exitButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        setupBindings()
        getUserData()
    }

    @objc func goToPrivacyVC(){
        let vc = PrivacyVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func goToRenameVC() {
        let vc = RenameVC()
        vc.completionHandlerAvatar = { [weak self] img in
            self?.settingView.profileImage.image = img
        }
        vc.completionHandlerName = { [weak self] name in
            self?.settingView.nameProfile.text = name
        }
        vc.completionHandlerEmail = { [weak self] email in
            self?.settingView.emailProfile.text = email
        }
        vc.avatar = settingView.profileImage.image
        vc.name = settingView.nameProfile.text
        vc.email = settingView.emailProfile.text
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func goToAboutVC() {
        let vc = WebViewController()
        vc.urlString = "https://dino.zone/ru/"
        guard let _ = URL(string: vc.urlString) else {fatalError("Problems with URL")}

        navigationController?.present(vc, animated: true)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func logOut() {
        auth.signOut { [unowned self] in
            onLogout?()
        }
    }
    
}

extension SettingsVC {
    func setupBindings() {
        settingView.switchNotification.rx
            .isOn
            .bind(onNext: { [unowned self] isOn in
                if isOn {
                    requestNotificationAuthorization()
                } else {
                    // Хз че делать когда отключаем нотификации
                }
            })
            .disposed(by: disposeBag)
    }

    private func requestNotificationAuthorization() {
        UserNotificationService.shared.requestAuthorization { [weak self] granted, error in
            if granted {
                self?.showTimePickerVC()
            } else if let error = error {
                self?.showAuthorizationErrorAlert(error: error)
            } else {
                self?.showNotificationDisabledAlert()
            }
        }
    }
    
    // MARK: - Показываем пикер
    private func showTimePickerVC() {
        DispatchQueue.main.async {
            let timePickerVC = TimePickerVC()
            self.navigationController?.present(timePickerVC, animated: true)
        }
    }

    // MARK: - Алерт когда возникла ошибка при разрешении доступа
    private func showAuthorizationErrorAlert(error: Error) {
        print("Ошибка при запросе разрешения на уведомления: \(error.localizedDescription)")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось получить разрешение на уведомления", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Алерт когда уведомления отключены и переходим в настройки
    private func showNotificationDisabledAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Уведомления отключены", message: "Пожалуйста, включите уведомления в настройках приложения", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SettingsVC {
    fileprivate func getUserData() {
        auth.getCurrentUser { [weak self] in
            guard let self else { return }
            if let _ = User.shared.avatarUrl {
                settingView.profileImage.getImage(from: User.shared.avatarUrl)
            }
            settingView.nameProfile.text = User.shared.name
            settingView.emailProfile.text = User.shared.email
        }
    }
}
