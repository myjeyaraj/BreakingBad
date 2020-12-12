//
//  CharectorListViewModel.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import RxCocoa
import RxSwift

enum ViewLoadStatus {
    case loading
    case loaded
    case empty
    case noResults(String)
}

protocol CharectProtocol {
    func fetchCharectors()
    var errors: Driver<Error?> { get }
    var loadingStatus: Driver<ViewLoadStatus> { get }
    var items: Driver<[SectionViewModel]> { get }

    func detailItems()
}

class CharectorListViewModel: ViewControllerFeedbackProtocol {
    var pageTitle: String?
    var notification: Driver<String?>
    var errors: Driver<Error?>
    var loadingStatus: Driver<ViewLoadStatus>
    var dataSource: Driver<[SectionViewModel]>

    fileprivate let _dataSource = ReplaySubject<[SectionViewModel]>.create(bufferSize: 1)
    fileprivate let _loadingStatus = ReplaySubject<ViewLoadStatus>.create(bufferSize: 1)
    fileprivate let _notification = ReplaySubject<String?>.create(bufferSize: 1)
    fileprivate let _errors = ReplaySubject<Error?>.create(bufferSize: 1)

    fileprivate var disposeBag = DisposeBag()
    fileprivate var _users: [BreakingBadUser]
    
    init() {
        pageTitle = "Breaking Bad"
        loadingStatus = _loadingStatus.asDriver(onErrorJustReturn: .empty)
        notification = _notification.asDriver(onErrorJustReturn: nil)
        errors = _errors.asDriver(onErrorJustReturn: nil)

        disposeBag = DisposeBag()
        dataSource = _dataSource.asDriver(onErrorJustReturn: [])
        _users = []
    }

    func loadCharectors() {
        _loadingStatus.onNext(.loading)

        Request.breakingBadCharectors { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case let .success(response):
                guard let response = response else {
                    return
                }

                let section = SectionViewModel(header: "Characters from BreakingBad", items: response)
                self._users = response
                self._loadingStatus.onNext(.loaded)
                self._dataSource.onNext([section])

            case .failure:
                break
            }
        }
    }
    
    func search(by name: String?) {
        _dataSource
        .subscribe(onNext: { section in
            var section = section.first!
            guard let name = name, name != "" else {
                section.items = self._users
                self._dataSource.onNext([section])
                return
            }
            let d = self._users.map{$0 as BreakingBadUser}.filter{$0.name.contains(name) == true}
            section.items = d as [SectionViewModel.Item]
            self._dataSource.onNext([section])
        })
        .dispose()
    }

}
