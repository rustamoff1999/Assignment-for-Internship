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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell

        cell.myImage.image = #imageLiteral(resourceName: "Uncheck")
        cell.titleOfLabel.text = data[indexPath.row].title.capitalized
        cell.contentOfLabel.text = data[indexPath.row].content
        cell.backgroundColor = UIColor.white
        cell.titleOfLabel.textColor = UIColor.black
        cell.contentOfLabel.textColor = UIColor.gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TableViewCell
        cell.myImage.image = #imageLiteral(resourceName: "Check")
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if let destination = segue.destination as? DetailViewController {
            destination.dataDetail = data[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}



