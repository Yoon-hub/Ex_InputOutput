//
//  ViewController.swift
//  ExRxTest
//
//  Created by 윤제 on 2023/11/08.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let plusButton: UIButton = {
       let button = UIButton()
        button.setTitle("플러스", for: .normal)
        //button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    let minusButton: UIButton = {
       let button = UIButton()
        button.setTitle("마이너스", for: .normal)
       // button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let numberLabel: UILabel = {
       let label = UILabel()
        label.text = "0"
        return label
    }()
    
    let viewModel: VCViewModel
    
    init(viewModel: VCViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    var disposeBag = DisposeBag()
    
    lazy var input = VCViewModel.Input(plusButtonTap: plusButton.rx.tap.asObservable(), minusButtonTap: minusButton.rx.tap.asObservable())
    lazy var output = viewModel.transform(input: self.input)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        output.toggleCount
            .map {String($0)}
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        [plusButton, minusButton, numberLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            plusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            plusButton.widthAnchor.constraint(equalToConstant: 100),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            minusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            minusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            minusButton.widthAnchor.constraint(equalToConstant: 100),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

