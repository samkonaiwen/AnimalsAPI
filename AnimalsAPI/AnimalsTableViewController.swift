//
//  AnimalsTableViewController.swift
//  AnimalsAPI
//
//  Created by SAM on 2020/11/2.
//

import UIKit

class AnimalsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var animalTableView: UITableView!
    
    var animal = [Animals]()
    
    func fecthAnimals() {
        let url = URL(string: "https://acnhapi.com/v1/villagers/")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
               let animalsDic = try? decoder.decode([String: Animals].self, from: data) {
                self.animal = Array(animalsDic.values)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fecthAnimals()
//        setupSearchBar()
    }

    @IBSegueAction func showDetail(_ coder: NSCoder) -> AnimalsDetailViewController? {
        let controller = AnimalsDetailViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.animal = animal[row]
        } 
        return controller
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animal.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalsTableViewCell", for: indexPath) as! AnimalsTableViewCell
        
        cell.task?.cancel()
        
        let animals = animal[indexPath.row]
        cell.name.text = animals.name.name_TWzh
        cell.gender.text = animals.gender
        cell.birthday.text = animals.birthday_string
        
        if let url = URL(string: animal[indexPath.row].image_uri) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.animalsImageView.image = image
                    }
                }
            }
            task.resume()
            cell.task = task
        }
        return cell
    }
    
    let searchBar = UISearchBar()
    
    func setupSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        // 顯示取消按鈕
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        animalTableView.delegate = self
        animalTableView.dataSource = self
        
        searchBar.searchTextField.clearButtonMode = .whileEditing
        searchBar.placeholder = "收尋島民"
        self.animalTableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text ?? ""
        if text == "" {
            fecthAnimals()
        } else {
            animal = animal.filter({ (animals) -> Bool in
                return animals.name.name_TWzh.uppercased().contains(searchText.uppercased())
            })
        }
        animalTableView.reloadData()
    }
    
    // 關閉虛擬鍵盤
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // 按取消按鈕，關閉虛擬鍵盤
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
