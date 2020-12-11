//
//  CharectorsListViewController.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import UIKit
import RxSwift
import MBProgressHUD
import RxDataSources

class CharactersListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    fileprivate var dataSource: RxTableViewSectionedReloadDataSource<SectionViewModel>?

    private let viewModel = CharectorListViewModel()
    private let disposeBag = DisposeBag()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        bindFeedback()
        displayCharectors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadCharectors()

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        MBProgressHUD.hide(for: self.view, animated: true)

    }

    fileprivate func configUI() {
        MBProgressHUD.showAdded(to: self.view, animated: true)


        title = viewModel.pageTitle

        tableView.delegate = self
        tableView.register(UINib(nibName: "CharacterListTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterListTableViewCell")
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
                MBProgressHUD.hide(for: self.view, animated: true)

                guard let error = error as? BadError else { return }
                CharactersListViewController.showAlert(selfVC: self, title: "".localized, message: error.message)
            })
            .disposed(by: disposeBag)

        let view = self.view
        viewModel.loadingStatus.asObservable()
            .subscribe(onNext: { [weak self] status in
                guard let `self` = self else { return }

                MBProgressHUD.showAdded(to: self.view, animated: true)

                switch status {
                case .loading:
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                case .empty, .noResults, .loaded:
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    fileprivate func displayCharectors() {
        dataSource = RxTableViewSectionedReloadDataSource<SectionViewModel>(configureCell: { [unowned self] (_, tv, indexPath, model) -> CharacterListTableViewCell in
            guard let cell: CharacterListTableViewCell = tv.dequeueReusableCell(withIdentifier: "CharacterListTableViewCell", for: indexPath) as? CharacterListTableViewCell else { return CharacterListTableViewCell() }

            let user = model as? BreakingBadUser
            cell.rowItem = CharacterCellDetail(primaryTitle: user?.name ?? "",
                                               secondaryTitle: user?.nickname ?? "",
                                               imageURL: user?.imageURL ?? "")
            
            

            return cell

        })

        viewModel.dataSource
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }



}


extension CharactersListViewController: UITableViewDelegate {
    
}
