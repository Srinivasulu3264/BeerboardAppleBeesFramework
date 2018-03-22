//
//  AppleBeeViewController.swift
//  AppleBeeFramework
//
//  Created by Vmoksha on 19/03/18.
//  Copyright © 2018 Vmoksha. All rights reserved.
//

import UIKit

public class AppleBeeViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var slidemenuView: UIView!
    
    @IBOutlet weak var slideOutTable: UITableView!
    
    @IBOutlet weak var alphaView: UIView!
    
    @IBOutlet weak var viewRedeemBtn: UIButton!
    
    var ismenuShowing = true
    
    var titleArr  = [String]()
    var imagesArr  = [String]()
    var isSegueEnbled = false
    var navigationBarLabel:UILabel?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        
        leadingConstraint.constant = -240
        
        titleArr  = ["Sundar","Find Locations","Gift Cards","Nutrition,Allergen","Information","Social"]
        
        imagesArr = ["profile","search","gift","Nutrition","information","comments"]
        
        slideOutTable.tableFooterView = UIView()
        alphaView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navLabelFrame = CGRect(x: 70, y: 0, width: (self.navigationController?.navigationBar.frame.width)!/2, height: (self.navigationController?.navigationBar.frame.height)!)
        navigationBarLabel = UILabel(frame: navLabelFrame)
        navigationBarLabel?.text = "Welcome, Sundar!"
        navigationBarLabel?.textColor = .white
        self.navigationController?.navigationBar.addSubview(navigationBarLabel!)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationBarLabel?.removeFromSuperview()
    }
    
    @IBAction func slideoutmenuAction(_ sender: Any) {
        
       SlideMenuHideAndShow()
}
    
   public func SlideMenuHideAndShow()  {
        
        if ismenuShowing {
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .beginFromCurrentState, animations: {
                self.alphaView.isHidden = false
                self.leadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }else{
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .beginFromCurrentState, animations: {
                
                self.leadingConstraint.constant = -240
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                    self.alphaView.isHidden = true
                })
                
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
            if isSegueEnbled{
                performSegue(withIdentifier: "toRedeemVC", sender: self)
                isSegueEnbled = false
            }
        }
        ismenuShowing = !ismenuShowing
    }
    
    
    
    @IBAction func viewRedeemBtnAction(_ sender: Any) {
        
         performSegue(withIdentifier: "toRedeemVC", sender: self)
    }
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "toRedeemVC" {
            let destinationVC = segue.destination as! RedeemViewController
            destinationVC.redeemVCDelegate = self
        }
    }
    
    
    
}

extension AppleBeeViewController:redeemVCProtocol
{
    func callSliderMenu() {
    isSegueEnbled = true
      SlideMenuHideAndShow()
    }
}

extension AppleBeeViewController:UITableViewDataSource,UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! SlideoutMenuprofileTableViewCell
            cell.profileImageview.image = UIImage(named: "profile")
            cell.profileNameLbl.text = "Sundar"
            cell.profileSubtitleLbl.text = "Profile & Settings"
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! SlideoutmenuListTableViewCell
            cell.listImageView.image = UIImage(named: imagesArr[indexPath.row])
            cell.listTitlelbl.text = titleArr[indexPath.row]
            return cell
            
        }
    }
}

