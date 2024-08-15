//
//  TimerPickerVC.swift
//  RadioApp
//
//  Created by dsm 5e on 06.08.2024.
//

import UIKit
import SnapKit

final class TimePickerVC: UIViewController {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()

    let scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Запланировать уведомление", for: .normal)
        button.addTarget(TimePickerVC.self, action: #selector(scheduleNotification), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        title = "Выбор времени"
        view.addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(datePicker)
        containerView.addSubview(scheduleButton)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        scheduleButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    @objc func scheduleNotification() {
        let selectedTime = datePicker.date
        UserNotificationService.shared.scheduleDailyNotification(at: selectedTime)
        navigationController?.dismiss(animated: true)
    }
}


