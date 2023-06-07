//
//  MenuBar.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/5.
//

import UIKit

protocol MenuBarDelegate: AnyObject{
    func didSelectedItem(index: Int)
}

class MenuBar: UIView {
    
    weak var delegate: MenuBarDelegate?

    
    private let friendBtn: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("好友", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        return btn
    }()
    private let chatBtn: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("聊天", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imgFriendsFemaleDefault")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let labelName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let kokoIdBtn: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor(named: "greyishBrown"), for: .normal)
        
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    
    private var buttons: [UIButton]!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        friendBtn.addTarget(self, action: #selector(friendBtnTapped), for: .primaryActionTriggered)
        chatBtn.addTarget(self, action: #selector(chatBtnTapped), for: .primaryActionTriggered)
        buttons = [friendBtn,chatBtn]
        addBadgeToButton(button: chatBtn, value: 99)

        addWidget()
        
        layout()
        
        setData()

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addWidget(){
        addSubview(friendBtn)
        addSubview(chatBtn)
        addSubview(labelName)
        addSubview(image)
        addSubview(kokoIdBtn)
    }
    
    private func layout(){
        switchBtnConstraint()
        profileWidgetConstraint()
    }
    
    private func switchBtnConstraint(){
        NSLayoutConstraint.activate([
            friendBtn.topAnchor.constraint(equalTo: kokoIdBtn.bottomAnchor,constant: 30),
            friendBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            chatBtn.leadingAnchor.constraint(equalTo: friendBtn.trailingAnchor, constant: 36),
            chatBtn.topAnchor.constraint(equalTo: kokoIdBtn.bottomAnchor,constant: 30)
        ])
    }
    
    private func profileWidgetConstraint(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor,constant: 30),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            labelName.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            kokoIdBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            kokoIdBtn.topAnchor.constraint(equalTo: labelName.bottomAnchor,constant: 8)
        
        ])
    }
    
    private func setData(){
        APICaller.shared.getUser { results in
            switch results{
            case .success(let result):
                DispatchQueue.main.async {
                    self.labelName.text = result[0].name
                    if let id = result[0].kokoid {
                        self.kokoIdBtn.setTitle("KOKO ID : \(id)", for: .normal)
                    }else{
                        self.kokoIdBtn.setTitle("設定 KOKO ID >", for: .normal)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }
    
    func addBadgeToButton(button: UIButton, value: Int) {
        // 1. Create the badge label
        let badgeLabel = UILabel()
        badgeLabel.text = String(value)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .red
        badgeLabel.textAlignment = .center
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.layer.cornerRadius = 10  // Half the height
        badgeLabel.clipsToBounds = true  // Enable cornerRadius
      
        // 2. Set the frame (or use autolayout)
        badgeLabel.frame = CGRect(x: 30, y: -10, width: 20, height: 20)
      
        // 3. Add the badge to the button
        button.addSubview(badgeLabel)
    }

}

//MARK: - TARGET ACTION
extension MenuBar{
    @objc func friendBtnTapped(){
        delegate?.didSelectedItem(index: 0)
    }
    
    @objc func chatBtnTapped(){
        delegate?.didSelectedItem(index: 1)

    }
}

