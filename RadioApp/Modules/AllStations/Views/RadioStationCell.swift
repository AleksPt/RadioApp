//
//  RadioStationCell.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

class RadioStationCell: UITableViewCell {
    
    private let networkService = NetworkService.shared
    private var votes: Int?
    private var stationId: String?
    var handlerSaveRealm: ((Bool)->())?
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.borderColor = Colors.grey.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Colors.white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = Font.getFont(Font.displayRegular, size: 14)
        label.textColor = Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var likeButtons: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(likeTaped), for: .touchUpInside)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
        
        NSLayoutConstraint.activate([
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 18),
            nameLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 22),
            nameLabel.trailingAnchor.constraint(equalTo: votesLabel.leadingAnchor, constant: -22),
            
            tagLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            tagLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 22),
            tagLabel.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -46),
            
            votesLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 12),
            votesLabel.trailingAnchor.constraint(equalTo: likeButtons.leadingAnchor, constant: -4),
            
            likeButtons.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 15.61),
            likeButtons.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -13.86),
            likeButtons.widthAnchor.constraint(equalToConstant: 14.66),
            likeButtons.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        votes = nil
        stationId = nil
        likeButtons.setImage(UIImage(resource: .like).withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private func fetchVotes(completion: @escaping (Bool)->()) {
        guard let stationId else { return }
        networkService.voteForStation(from: Link.vote.url, with: stationId) { result in
            switch result {
            case .success(let success):
                success.ok ? completion(true) : completion(false)
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(false)
            }
        }
    }
    
    @objc private func likeTaped(_ sender: UIButton) {
        if sender.currentImage == UIImage(resource: .likeFilled).withRenderingMode(.alwaysOriginal) {
            handlerSaveRealm?(false)
            sender.setImage(UIImage(resource: .like).withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            fetchVotes { [weak self] result in
                guard let self else { return }
                if result {
                    guard votes != nil else { return }
                    votes! += 1
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        votesLabel.text = "votes \(votes!.description)"
                        sender.setImage(UIImage(resource: .likeFilled).withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
            }
            handlerSaveRealm?(true)
        }
    }
    
    // MARK: - Set CellView
    
    private func setView() {
        
        contentView.addSubview(conteinerView)
        
        conteinerView.addSubview(tagLabel)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(votesLabel)
        conteinerView.addSubview(likeButtons)
    }
    
    
    func configure(with viewModel: RadioStationViewModel, isSelected: Bool, _ isFavorite: Bool? = nil) {
    
        if let isFavorite {
            likeButtons.setImage(isFavorite ? UIImage(resource: .likeFilled).withRenderingMode(.alwaysOriginal) : UIImage(resource: .like).withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        tagLabel.text = viewModel.tag
        nameLabel.text = viewModel.name
        votesLabel.text = "\(K.votes) \(viewModel.votes)"
        
        stationId = viewModel.id
        votesLabel.text = "votes \(viewModel.votes.description)"
        if let vote = Int(viewModel.votes.description) {
            votes = vote
        }
        
        if isSelected {
            conteinerView.backgroundColor = Colors.pink
            conteinerView.layer.borderWidth = 0
        } else {
            conteinerView.backgroundColor = .clear
            conteinerView.layer.borderWidth = 2.0
        }
    }
}
