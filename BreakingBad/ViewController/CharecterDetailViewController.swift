//
//  CharectorDetailViewController.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit
import RxSwift

class CharacterDetailViewController: UIViewController {
    @IBOutlet var userImageView: UIImageView!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var occupationLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!

    var userData: BreakingBadUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillUserDetail()
    }
    
    fileprivate func fillUserDetail() {
        guard let item = userData else { return }
        setImage(imageURL: item.imageURL, placeholderImage: UIImage(named: "avatarImage")!)
        nameLabel.text = item.name
        occupationLabel.text =  item.occupation.map{String($0)}.joined(separator: "\n ")
        statusLabel.text = item.name
        nickNameLabel.text = item.name
        seasonLabel.text = "[ " + (item.appearance?.map{String($0)}.joined(separator: ", ")  ?? "None") + " ]"
    }

    fileprivate func setImage(imageURL: String?, placeholderImage: UIImage) {
        if let artworkURLString = imageURL, let artworkURL = URL(string: artworkURLString) {
            userImageView.contentMode = .scaleAspectFit
            userImageView.kf.setImage(with: artworkURL,
                                  placeholder: placeholderImage,
                                  options: [.transition(.fade(0.7))],
                                  progressBlock: nil,
                                  completionHandler: { result in

                                      switch result {
                                      case .success:
                                          break

                                      case .failure:
                                          self.userImageView.image = placeholderImage
                                      }

            })

        } else {
            userImageView.image = placeholderImage
        }
    }
}
