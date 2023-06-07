

import UIKit

class EmptyView: UIView {

    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imgFriendsEmpty")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "就從加好友開始吧：）"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "與好友們一起用 KOKO 聊起來！"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "還能互相收付款、發紅包喔：）"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "幫助好友更快找到你？"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let kokoIdBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("設定 KOKO ID", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(.systemPink, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var sv: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [label3, kokoIdBtn])
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let plusFriendBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("加好友", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addWidget()
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addWidget(){
        addSubview(image)
        addSubview(labelTitle)
        addSubview(label1)
        addSubview(label2)
        addSubview(plusFriendBtn)
        addSubview(sv)
    }
    
    private func layout(){
        imageConstraint()
        labelConstraint()
        btnConstraint()
        svConstraint()
    }
    
    private func imageConstraint(){
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 30)
        ])
    }
    
    private func labelConstraint(){
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 41),
            label1.centerXAnchor.constraint(equalTo: centerXAnchor),
            label2.centerXAnchor.constraint(equalTo: centerXAnchor),
            label1.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 8),
        ])

    }
    
    private func btnConstraint(){
        NSLayoutConstraint.activate([
            plusFriendBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusFriendBtn.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 25),
            plusFriendBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            plusFriendBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func svConstraint(){
        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: centerXAnchor),
            sv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    

    
    

}
