

import UIKit

class FriendViewController: UIViewController {
    
    let menuBar = MenuBar()
    var list: [UIColor] = [.white,.blue]
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SwitchCollectionViewCell.self, forCellWithReuseIdentifier: SwitchCollectionViewCell.identify)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBar.delegate = self

        configureNavbar()
        
        addWidget()
        
        layout()
    }
    

    
    private func addWidget(){
        view.addSubview(menuBar)
        view.addSubview(collectionView)
    }
    
    private func layout(){
        menuBarConstraint()
        CVConstraint()
    }
    
    private func menuBarConstraint(){
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 150)

        ])
    }
    
    private func CVConstraint(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: menuBar.bottomAnchor, multiplier: 2),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 0)
            
        
        ])
    }


    
    
    
    private func configureNavbar() {
        let image = UIImage(named: "icNavPinkScan")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "icNavPinkWithdraw")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "icNavPinkTransfer")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        ]
    }
    


}

extension FriendViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwitchCollectionViewCell.identify, for: indexPath) as? SwitchCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = list[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .black
            return cell
        }

    }
}

extension FriendViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

extension FriendViewController: MenuBarDelegate{
    func didSelectedItem(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
