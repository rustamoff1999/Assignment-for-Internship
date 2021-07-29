//
//  ViewController.swift
//  my-App
//
//  Created by User on 27.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var data = [JsonData]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        gettingJsonData {
            self.tableView.reloadData()
        }
       
    }

    func gettingJsonData(completed: @escaping ()->()) {
        let urlString = "http://assignment-ios-br.free.beeceptor.com/"
        //Trying to get url
        guard let url = URL(string: urlString)  else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return} //checking for non empty data
            guard error == nil else {return} //checking  if there is an error
            do {
                self.data = try JSONDecoder().decode([JsonData].self, from: data)
                DispatchQueue.main.async {
                    completed()
                }
            } catch {
                print("JSON Error")
            }
        }.resume()
    }
    
}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    //cell itself
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = data[indexPath.row].title.capitalized
        cell.detailTextLabel?.text = data[indexPath.row].content
        cell.backgroundColor = UIColor.white
        cell.textLabel?.textColor = UIColor.black
        cell.detailTextLabel?.textColor = UIColor.gray
        cell.textLabel?.font = UIFont(name: "Impact", size: 20.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if let destination = segue.destination as? DetailViewController {
            destination.dataDetail = data[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}



