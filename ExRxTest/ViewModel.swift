//
//  ViewModel.swift
//  ExRxTest
//
//  Created by 윤제 on 2023/11/08.
//

import Foundation

protocol ViewModelAA: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
