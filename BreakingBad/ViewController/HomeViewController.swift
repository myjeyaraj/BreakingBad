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
    @IBOutlet var homeButton: Button!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        bindbutton()
    }
    
    private func confgiUI() {
        homeButton.setTitle("home_open_list_page_title".localized, for: .normal)
    }
    
    private func bindbutton() {
        homeButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {[unowned self] _ in
                self.navigationController?.pushViewController(ViewControllerIndex.charactorListView, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
