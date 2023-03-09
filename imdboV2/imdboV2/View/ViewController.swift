//
//  ViewController.swift
//  imdboV2
//
//  Created by Tugcan barbin on 3/9/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController ,UITableViewDelegate{
    let disposeBag = DisposeBag()
    let movieVM = MovieViewModel()
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.delegate = self
        //tableView.dataSource = self
        view.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        movieVM.requestListData(name: "")
    }

    private func setupBindings() {
                   
        movieVM
                    .error
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { failure in
                        print(failure)
                    })
                    .disposed(by: disposeBag)
                

               
        movieVM.movies.bind(to: tableView.rx.items(cellIdentifier: "ListCell", cellType: ListResultCell.self)) { (row,item,cell) in
                    cell.item = item
                }.disposed(by: disposeBag)
        
            tableView.rx.modelSelected(ListResult.self).subscribe(onNext: { item in
                print("SelectedItem: \(item.currency)")
                }).disposed(by: disposeBag)
            }
}
