//
//  ProductListViewController.swift
//  Plumb5SampleAppWithFrameWork
//
//  Created by Shama on 5/20/17.
//  Copyright © 2017 Plumb5. All rights reserved.
//

import Foundation
import UIKit

class ProductListController: UITableViewController {
    var productList = "productListId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    open func numberOfRows(inSection section: Int) -> Int{
        return 50
    }
    
    
     override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:ProductDetailController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ProductDetailController") as UIViewController as! ProductDetailController
        
        vc.SectionNumber = "Section \(indexPath.section)"
        vc.RowNumber = "Row \(indexPath.row)"
        
        self.show(vc, sender: self)
        //let vc = UIStoryboard(name: "ProductListViewController", bundle: nil).instantiateInitialViewController()
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    }

