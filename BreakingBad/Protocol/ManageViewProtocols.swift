//
//  ManageViewProtocols.swift
//  BreakingBad
//
//  Created by Myvili.jeyaraj on 10/12/2020.
//

import RxCocoa


protocol PushViewControllerViewModelProtocol {
    var pushViewController: Driver<UIViewController> { get set }
}

protocol ItemInViewFeedbackProtocol {
    var loadingStatus: Driver<ViewLoadStatus> { get set }
    var items: Driver<[BreakingBadUser]> { get set }
}

protocol ViewControllerFeedbackProtocol {
    var pageTitle: String? { get set }
    var notification: Driver<String?> { get set }
    var errors: Driver<Error?> { get set }
    var loadingStatus: Driver<ViewLoadStatus> { get set }
}
