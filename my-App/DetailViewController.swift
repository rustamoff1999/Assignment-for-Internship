//
//  DetailViewController.swift
//  my-App
//
//  Created by User on 29.07.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    
    var dataDetail: JsonData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = dataDetail?.title
        contentLbl.text =  dataDetail?.content
    }
}
