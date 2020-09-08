//
//  ViewController.swift
//  Plumb5SampleAppWithFrameWork
//
//  Created by Shama on 5/20/17.
//  Copyright © 2017 Plumb5. All rights reserved.
//

import UIKit
import Plumb5SDK

class HomeViewController: UIViewController, P5BannerDelegate {
   

    @IBOutlet weak var bannerView: UIView!
    var homeParam :String = "home"

    override func viewDidLoad() {
        super.viewDidLoad()
        P5SDKManager.registerUser(name: "abcd", email: "abcd@gmail.com", phoneNumber: "1234567890", extraParam: "asdf")
        
        P5SDKManager.loadBanner(screenName: "com.plumb5.p5testnew.MainActivity",bannerView: bannerView, delegate: self)


        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func showBannerTapped(_ sender: Any) {
        P5SDKManager.showInAppBannerDialog(screenName: "com.plumb5.p5testnew.MainActivity")
        P5SDKManager.trackEvents(name: "Show banner", type: P5SDKManager.BUTTON_CLICK, value: "100")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    open func numberOfRows(inSection section: Int) -> Int{
//        return 50
//    }
//    
//    //open func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//
//        let cell:UITableViewCell
//        cell = tableView.cellForRow(at: indexPath)!
//
//        cell.textLabel!.text = "Product Number  + \(indexPath.row)"
//        
//
////        if let i = self.data.index(of: snapshot.value as! String) {
////            
////            self.data[i] = snapshot.value as! String
////
////            cell = tableView.cellForRow(at: indexPath)!
////            
////            cell.textLabel!.text = "Modd"
////        }
////        else {
////            
////            print("Modified an item that wasn't in the data list")
////        }
//        
//        return  cell
//    }// returns nil if cell is not visible or index path is out of range
//
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        let vc:ProductDetailController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ProductDetailController") as UIViewController as! ProductDetailController
//        
//        vc.productDetailId = "Product Number  + \(indexPath.row)"
//        
//        //let vc = UIStoryboard(name: "ProductListViewController", bundle: nil).instantiateInitialViewController()
//        
//        self.pushViewController(vc, animated: true)
//
//    }
    
    
    func bannerLoaded(){
        print ("bannerLoaded")
    }
    func bannerRemoved(){
        print ("bannerRemoved")
    }

}

