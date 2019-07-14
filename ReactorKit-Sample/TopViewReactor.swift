//
//  TopViewReactor.swift
//  ReactorKit-Sample
//
//  Created by Takuya Ohsawa on 2019/07/14.
//  Copyright © 2019 takuyaohsawa. All rights reserved.
//

import ReactorKit
import RxSwift

final class TopViewReactor: Reactor {
    // Action is an user interaction
    enum Action {
        case increase
        case decrease
    }
    
    // Mutate is a state manipulator which is not exposed to a view
    enum Mutation {
        case increaseValue
        case decreaseValue
    }
    
    // State is a current view state
    struct State {
        var value: Int
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            value: 0 // start from 0
        )
    }
    
    func mutate(action: TopViewReactor.Action) -> Observable<TopViewReactor.Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.increaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.decreaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                ])
        }
    }
    
    func reduce(state: TopViewReactor.State, mutation: TopViewReactor.Mutation) -> TopViewReactor.State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .decreaseValue:
            state.value -= 1
        }
        return state
    }
}
