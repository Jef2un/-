
import UIKit

class FriendsTableViewCell: UITableViewCell {
    static let identify = "FriendsTableViewCell"
    

    public var star: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icFriendsStar")
        image.isHidden = true 
        return image
    }()
    
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
    
    private let transferBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle(" 轉帳 ", for: .normal)
        btn.setTitleColor(.systemPink, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemPink.cgColor
        return btn
    }()
    
    public let invitedBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle(" 邀請中 ", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        return btn
    }()
    
    public let moreBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "icFriendsMore"), for: .normal)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [transferBtn,invitedBtn,moreBtn])
        sv.axis = .horizontal
        sv.spacing = 10
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
        contentView.addSubview(star)
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            star.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            star.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: star.trailingAnchor,constant: 6),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 15),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)
        ])
    }
    
    
}
