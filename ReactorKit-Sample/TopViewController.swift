//
//  TopViewController.swift
//  ReactorKit-Sample
//
//  Created by Takuya Ohsawa on 2019/07/07.
//  Copyright © 2019 takuyaohsawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class TopViewController: UIViewController {
    private let disposeBag: DisposeBag = .init()
    @IBOutlet private weak var increaseButton: UIButton!
    @IBOutlet private weak var decreaseButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!
    private let reactor = TopViewReactor()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(reactor: reactor)
    }
    
    private func bind(reactor: TopViewReactor) {
        increaseButton.rx.tap
            .map { TopViewReactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { TopViewReactor.Action.decrease }
            .bind(to: reactor.action )
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.value }   // 10
            .distinctUntilChanged()
            .map { "\($0)" }               // "10"
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

