//
//  FriendsTableViewCell.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/6.
//

import UIKit

class InvitedTableViewCell: UITableViewCell {
    static let identify = "InvitedTableViewCell"
    
    public var profileImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "imgFriendsFemaleDefault")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let promptLabel: UILabel = {
        var label = UILabel()
        label.text = "邀請你成為好友：）"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let noBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "btnFriendsAgree")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    public let yesBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "btnFriendsDelet")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var hstackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [yesBtn,noBtn])
        sv.axis = .horizontal
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var vstackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [nameLabel,promptLabel])
        sv.axis = .vertical
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FriendsTableViewCell.identify)
        addWidget()
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addWidget(){
        contentView.addSubview(profileImage)
        contentView.addSubview(hstackView)
        contentView.addSubview(vstackView)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
            vstackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vstackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 15),
            hstackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hstackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)
        ])
    }
    
    
}

