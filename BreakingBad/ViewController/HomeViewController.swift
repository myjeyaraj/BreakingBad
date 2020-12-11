//
//  HomeViewController.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet var homeButton: UIButton!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        openCharectorsListPage()
    }
    
    private func confgiUI() {
        homeButton.setTitle("home_open_list_page_title".localized, for: .normal)
    }
    
    private func openCharectorsListPage() {
        homeButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {[unowned self] _ in
                let controller = UINavigationController(rootViewController: ViewControllerIndex.charectorListView)
                self.navigationController?.pushViewController(controller, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
