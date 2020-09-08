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
    @IBOutlet weak var ServiceURL: UITextField!
    @IBOutlet weak var ApiKey: UITextField!

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Extra: UITextField!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var DeviceInfo: UITextView!
    
    var ApiKEy:String = "p5m1a2i3sdk5"
    var ServiceURL_ =  "https://p5mobtrk.bajajfinservmarket.in/mTracker.svc/"
    var Email_ :String = "abcd@gmail.com"
    var Username_:String = "abcd"
    var Phone_:String = "1234567890"
    var Extra_:String = "asdf"
    var Status_:String = "false"
    var homeParam :String = "home"

    override func viewDidLoad() {
        super.viewDidLoad()
self.hideKeyboardWhenTappedAround()
        Status.text! = Status_
        ServiceURL.text! = ServiceURL_
                ApiKey.text! = ApiKEy
                Email.text! = Email_
                Username.text! = Username_
                Phone.text! = Phone_
        Extra.text! = Extra_
        DeviceInfo.isEditable = false


    }
    @IBAction func showBannerTapped(_ sender: Any) {

   Status_ = Status.text!
       ServiceURL_ = ServiceURL.text!
               ApiKEy =  ApiKey.text!
               Email_ = Email.text!
               Username_ = Username.text!
               Phone_ = Phone.text!
       Extra_ = Extra.text!
        
        print(ServiceURL_)
     
        P5SDKManager.initP5SDK(key: ApiKEy,url: ServiceURL_ ,completion: { status in
                    if status
                    {
                    
                        
           
                        
                    
                    }
                });
        
        P5SDKManager.registerUser(name: self.Username_, email: self.Email_, phoneNumber: self.Phone_, extraParam: self.Extra_)
                   
                   
               
                   
                   
                   P5SDKManager.showInAppBannerDialog(screenName: "com.plumb5.p5testnew.MainActivity")
                   P5SDKManager.trackEvents(name: "Show banner", type: P5SDKManager.BUTTON_CLICK, value: "100")
                   self.DeviceInfo.text! =  P5SDKManager.getDeviceInfoAsJson()
                  
        
        
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

