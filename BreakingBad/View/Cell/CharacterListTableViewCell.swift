//
//  CharectorListTableViewCell.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit
import Kingfisher

protocol ImageProtocol {
    var placeHolderImage: UIImage? { get }
    var imageURL: String? { get }
}
 

protocol PrimaryDetailProtocol {
    var primaryTitle: String { get }
    var secondaryTitle: String { get }

}

struct CharacterCellDetail: PrimaryDetailProtocol, ImageProtocol {
    var primaryTitle: String
    var secondaryTitle: String
    var imageURL: String?
}

extension CharacterCellDetail {
    var placeHolderImage: UIImage? { return UIImage(named: "avatarImage")!}

}

class CharacterListTableViewCell: UITableViewCell {
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var primaryLabel: UILabel!

    var rowItem: PrimaryDetailProtocol? {
        didSet{
            fillDetails()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func fillDetails() {
        primaryLabel.text = rowItem?.primaryTitle

        if let item = rowItem as? ImageProtocol {
            setImage(imageURL: item.imageURL, placeholderImage: item.placeHolderImage ?? UIImage(named: "avatarImage")!)
         }
    }
    
    fileprivate func setImage(imageURL: String?, placeholderImage: UIImage) {
        if let artworkURLString = imageURL, let artworkURL = URL(string: artworkURLString) {
            itemImageView.contentMode = .scaleAspectFit
            itemImageView.kf.setImage(with: artworkURL,
                                  placeholder: placeholderImage,
                                  options: [.transition(.fade(0.7))],
                                  progressBlock: nil,
                                  completionHandler: { result in

                                      switch result {
                                      case .success:
                                          break

                                      case .failure:
                                          self.itemImageView.image = placeholderImage
                                      }

            })

        } else {
            itemImageView.image = placeholderImage
        }
    }
    
    
    override func prepareForReuse() {
        itemImageView.image = nil
        primaryLabel.text = ""
    }
}
