//
//  PlayerVC.swift
//  RadioApp
//
//  Created by dsm 5e on 03.08.2024.
//

import UIKit
import AVFoundation
import RxSwift
import RxGesture
import SnapKit
import MediaPlayer

final class PlayerView: UIView {

    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalSpacing
        return stack
    }()

    private let leftButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .previous)
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let playButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .player)
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let rightButton: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .next)
        image.contentMode = .scaleAspectFit
        return image
    }()

    var audioPlayer: AVPlayer?
    var timer: Timer?
    var volumeSlider: UISlider!

    private let disposeBag = DisposeBag()

    init() {
        super.init(frame: .zero)
        if let url = URL(string: "http://icecast.vgtrk.cdnvideo.ru/vestifm_mp3_192kbps") {
            audioPlayer = AVPlayer(url: url)
            print("Player initialized: \(String(describing: audioPlayer))")
            audioPlayer?.play()
        }

        setupUI()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBindings() {
        playButton.rx.tapGesture()
            .when(.recognized)
            .mapToVoid()
            .bind(onNext: { [unowned self] in
                togglePlayPause()
                animate(with: playButton)
            })
            .disposed(by: disposeBag)

        leftButton.rx.tapGesture()
            .when(.recognized)
            .mapToVoid()
            .bind(onNext: { [unowned self] in
                animate(with: leftButton)
            })
            .disposed(by: disposeBag)

        rightButton.rx.tapGesture()
            .when(.recognized)
            .mapToVoid()
            .bind(onNext: { [unowned self] in
                animate(with: rightButton)
            })
            .disposed(by: disposeBag)

        // Bind the volume slider to the volume of the audio player
        volumeSlider.rx.value
            .bind(onNext: { [unowned self] value in
                audioPlayer?.volume = Float(value)
            })
            .disposed(by: disposeBag)
    }

    private func togglePlayPause() {
         if audioPlayer?.rate == 0 {
             audioPlayer?.play()
             print("Play sound")
         } else {
             print("pause")
             audioPlayer?.pause()
         }
     }
}

// MARK: - UI
private extension PlayerView {
    func setupUI() {
        volumeSlider = UISlider()
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 1
        volumeSlider.value = 1

        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        [leftButton, playButton, rightButton]
            .forEach {
                hStack.addArrangedSubview($0)
            }

        addSubview(hStack)
        addSubview(volumeSlider)
    }

    func setupConstraints() {
        hStack.snp.makeConstraints { make in
            make
                .top.leading.trailing
                .equalToSuperview()
            make
                .height
                .equalTo(100)
        }
        playButton.snp.makeConstraints { make in
            make
                .size
                .equalTo(100)
        }
        leftButton.snp.makeConstraints { make in
            make
                .size
                .equalTo(48)
        }
        rightButton.snp.makeConstraints { make in
            make
                .size
                .equalTo(48)
        }
        volumeSlider.snp.makeConstraints { make in
            make
                .top
                .equalTo(hStack.snp.bottom)
                .offset(5)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(20)
            make
                .bottom
                .equalToSuperview()
        }
    }
}

// MARK: - Animations
private extension PlayerView {
    func animate(with viewForAnimate: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            viewForAnimate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                viewForAnimate.transform = .identity
            })
        }
    }
}
