//
//  VCViewModel.swift
//  ExRxTest
//
//  Created by VP on 2023/11/08.
//

import Foundation

import RxSwift
import RxRelay

class VCViewModel: ViewModelAA {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        var plusButtonTap: Observable<Void>
        var minusButtonTap: Observable<Void>
    }
    
    struct Output {
        var toggleCount = BehaviorRelay<Int>(value: 0)
    }
    
    func transform(input: Input) -> Output {
        let oupPut = Output()
        
        input.plusButtonTap
            .bind {
                oupPut.toggleCount.accept(oupPut.toggleCount.value + 1)
                print("tap")
            }
            .disposed(by: disposeBag)
        
        input.minusButtonTap
            .bind {
                oupPut.toggleCount.accept(oupPut.toggleCount.value - 1)
                print("tap")
            }
            .disposed(by: disposeBag)
        
        return oupPut
    }
}
