
import UIKit

class SwitchCollectionViewCell: UICollectionViewCell {
    static let identify = "SwitchCollectionViewCell"

    public var presentView:UIView = FriendsTableView()
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(presentView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        presentView.frame = contentView.bounds
    }
}
