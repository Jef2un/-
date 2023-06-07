//
//  FriendsTableView.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/6.
//

import UIKit

class FriendsTableView: UIView {
    
    
    var friendsData: [Response] = []

    
    private let plusBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "icBtnAddFriends")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn

    }()

    private let searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        var tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identify)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        APICaller.shared.getFriends { result in
            switch result {
            case .success(let success):
                self.friendsData = success
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        addWidget()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    
    private func layout(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor,constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 30),
            plusBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            plusBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            searchBar.trailingAnchor.constraint(equalTo: plusBtn.leadingAnchor,constant: -15),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    private func addWidget(){
        addSubview(tableView)
        addSubview(searchBar)
        addSubview(plusBtn)
    }

}
extension FriendsTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identify, for: indexPath) as? FriendsTableViewCell else {
            return UITableViewCell()
        }
        let friend = friendsData[indexPath.row]
        cell.nameLabel.text = friend.name
        if friend.isTop == "1" {
            cell.star.isHidden = false
        }else {
            cell.star.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
