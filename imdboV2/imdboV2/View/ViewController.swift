//
//  ViewController.swift
//  imdboV2
//
//  Created by Tugcan barbin on 3/9/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController ,UITableViewDelegate, UISearchBarDelegate{
    let disposeBag = DisposeBag()
    let movieVM = MovieViewModel()
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedMovie : ListResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.dataSource = self
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        view.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        //movieVM.requestListData(name: "spider")
        
    }

    
    private func setupBindings()
    {
                   
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
            print("SelectedItem: \(item.title)")
            self.selectedMovie = item
            self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
            self.performSegue(withIdentifier: "List2DetailsVC", sender: nil)
            
            }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "List2DetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedMovie = selectedMovie
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search label changed")
        movieVM.requestListData(name: searchText)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

