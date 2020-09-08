//
//  ProductDetailViewController.swift
//  Plumb5SampleAppWithFrameWork
//
//  Created by Shama on 5/20/17.
//  Copyright © 2017 Plumb5. All rights reserved.
//

import Foundation
import UIKit

 class ProductDetailController: UIViewController {
    public var SectionNumber :String = ""
    public var RowNumber :String = ""

    @IBAction func btnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

