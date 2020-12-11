//
//  CharectorListViewModel.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import RxSwift
import RxCocoa

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
        var items: Driver<[BreakingBadUser]> { get }

        func detailItems()
}

class CharectorListViewModel: ViewControllerFeedbackProtocol {
    var pageTitle: String?
    var notification: Driver<String?>
    var errors: Driver<Error?>
    var loadingStatus: Driver<ViewLoadStatus>
    var dataSource: Driver<[BreakingBadUser]>

    fileprivate let _dataSource = ReplaySubject<[BreakingBadUser]>.create(bufferSize: 1)
    fileprivate let _loadingStatus = ReplaySubject<ViewLoadStatus>.create(bufferSize: 1)
    fileprivate let _notification = ReplaySubject<String?>.create(bufferSize: 1)
    fileprivate let _errors = ReplaySubject<Error?>.create(bufferSize: 1)

    fileprivate var disposeBag = DisposeBag()

    init() {
        pageTitle = "Test".localized
        loadingStatus = _loadingStatus.asDriver(onErrorJustReturn: .empty)
        notification = _notification.asDriver(onErrorJustReturn: nil)
        errors = _errors.asDriver(onErrorJustReturn: nil)

        disposeBag = DisposeBag()
        dataSource = _dataSource.asDriver(onErrorJustReturn: [])

    }

    func loadCharectors() {
        Request.breakingBadCharectors() { (result) in
            switch(result) {
            case let .success(response):
                guard let response = response else {
                    return
                }
                
                response.map{ v in 
                    
                }
            case .failure(_):
                break
            }
        }
    }
    
  
}