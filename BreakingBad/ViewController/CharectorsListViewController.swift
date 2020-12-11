//
//  CharectorsListViewController.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit
import RxSwift

import SVProgressHUD
import RxDataSources

class CharectorsListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    fileprivate var dataSource: RxTableViewSectionedReloadDataSource<SectionViewModel>?

    private let viewModel = CharectorListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        SVProgressHUD.show()
    }

    fileprivate func configUI() {
        SVProgressHUD.show()

        title = viewModel.pageTitle

        tableView.delegate = self
        tableView.register(UINib(nibName: "CharectorListTableViewCell", bundle: nil), forCellReuseIdentifier: "CharectorListTableViewCell")
        tableView.register(UINib(nibName: "ListTableViewHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ListTableViewHeaderCell")

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: -1))

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(BreakingBadConstant.cellRowHeight)
        tableView.separatorColor = .clear
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.cellLayoutMarginsFollowReadableWidth = false
    }

    fileprivate func bindFeedback() {
        viewModel.errors.asObservable()
            .subscribe(onNext: { [weak self] error in
                guard let `self` = self else { return }
                SVProgressHUD.dismiss()

                guard let error = error as? BadError else { return }
                CharectorsListViewController.showAlert(selfVC: self, title: "".localized, message: error.message)
            })
            .disposed(by: disposeBag)

        viewModel.loadingStatus.asObservable()
            .subscribe(onNext: { [weak self] status in
                SVProgressHUD.dismiss()

                switch status {
                case .loading:
                    SVProgressHUD.show()
                case .empty, .noResults:
                    SVProgressHUD.dismiss()
                case .loaded:
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: disposeBag)
    }

    fileprivate func manageSources() {
        dataSource = RxTableViewSectionedReloadDataSource<SectionViewModel>(configureCell: { [unowned self] (_, tv, indexPath, model) -> CharectorListTableViewCell in
            guard let cell: CharectorListTableViewCell = tv.dequeueReusableCell(withIdentifier: "CharectorListTableViewCell", for: indexPath) as? CharectorListTableViewCell else { return CharectorListTableViewCell() }

//            cell.rowItem = CharectorCellDetail(primaryTitle: <#T##String#>,
//                                               secondaryTitle: <#T##String#>,
//                                               imageURL: <#T##String?#>)

            return cell

        })

//        viewModel.dataSource
//            .asObservable()
//            .map { sources in
//                SVProgressHUD.dismiss()
//                return sources
//            }
//            .bind(to: tableView.rx.items(dataSource: dataSource!))
//            .disposed(by: disposeBag)
    }



}


extension CharectorsListViewController: UITableViewDelegate {
    
}
