//
//  FriendsTableView.swift
//  國泰IOS應徵者林造文作品
//
//  Created by Jef2un_628 on 2023/6/6.
//

import UIKit

class FriendsTableView: UIView, UISearchBarDelegate {
    
    
    var friendsData: [Response] = []
    var currentFriendsData: [Response] = []

    private let refreshControl = UIRefreshControl()
    
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

        fetchData()
        setDelegate()
        addWidget()
        layout()
        endEditing()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func endEditing(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        let group = DispatchGroup()

        group.enter()
        APICaller.shared.getFriends1 { result in
            switch result {
            case .success(let success):
                self.friendsData = success
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }

        group.enter()
        APICaller.shared.getFriends2 { result in
            switch result {
            case .success(let success):
                self.friendsData.append(contentsOf: success)
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.currentFriendsData = self.cleanData()
            self.currentFriendsData.sort { $0.status ?? 0 > $1.status ?? 0 }
            self.tableView.reloadData()
            sender.endRefreshing()
        }
    }
    
    private func setDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func fetchData(){
        let group = DispatchGroup()

        group.enter()
        APICaller.shared.getFriends1 { result in
            switch result {
            case .success(let success):
                self.friendsData = success
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }

        group.enter()
        APICaller.shared.getFriends2 { result in
            switch result {
            case .success(let success):
                self.friendsData.append(contentsOf: success)
            case .failure(let failure):
                print(failure)
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.currentFriendsData = self.cleanData()
            self.currentFriendsData.sort { $0.status ?? 0 > $1.status ?? 0 }
            self.tableView.reloadData()
        }
    }
    
    private func cleanData() -> [Response]{
        let dateFormatter = DateFormatter()

        var friendsDict: [String: Response] = [:]

        for friend in friendsData {
            if let fid = friend.fid {
                if let existingFriend = friendsDict[fid] {
                    if let existingDateStr = existingFriend.updateDate, let newDateStr = friend.updateDate,
                       let existingDate = dateFormatter.dateFromMultipleFormats(from: existingDateStr),
                       let newDate = dateFormatter.dateFromMultipleFormats(from: newDateStr) {
                        if newDate > existingDate {
                            friendsDict[fid] = friend
                        }
                    }
                } else {
                    friendsDict[fid] = friend
                }
            }
        }

        return Array(friendsDict.values)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currentFriendsData = cleanData()
        } else {
            // Update currentFriendsData with filtered result
            currentFriendsData = currentFriendsData.filter { $0.name.contains(searchText) }
        }

            // Then, reload data in table view
            tableView.reloadData()
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
        return currentFriendsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identify, for: indexPath) as? FriendsTableViewCell else {
            return UITableViewCell()
        }
        let friend = currentFriendsData[indexPath.row]
        cell.nameLabel.text = friend.name
        if friend.isTop == "1" {
            cell.star.isHidden = false
        }else {
            cell.star.isHidden = true
        }
        if friend.status == 1 {
            cell.invitedBtn.isHidden = true
            cell.moreBtn.isHidden = false
        }else{
            cell.invitedBtn.isHidden = false
            cell.moreBtn.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}


extension DateFormatter {
    func dateFromMultipleFormats(from string: String) -> Date? {
        let formats = ["yyyyMMdd", "yyyy/MM/dd"]
        
        for format in formats {
            self.dateFormat = format
            if let date = self.date(from: string) {
                return date
            }
        }
        
        return nil
    }
}
