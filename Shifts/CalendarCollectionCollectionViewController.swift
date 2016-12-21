//
//  CalendarCollectionCollectionViewController.swift
//  Shifts
//
//  Created by Santiago Pérez Martínez on 13/12/16.
//  Copyright © 2016 Santiago Pérez Martínez. All rights reserved.
//

import UIKit
import Foundation

//Date of selected month
var selectedDate = Date()
var selectedDateComponents = DateComponents()

var dayDiff = 0
var firstDateOfSelected = Date()
var firstDateOfSelectedComponents = DateComponents()
var indexOfSelected1st = 0


class CalendarCollectionCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var CollecionViewOT: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "dayCell")

        // Do any additional setup after loading the view.
    }
    
     //func viewWillAppear() {
        //super.viewWillAppear(<#T##Bool#>)
     //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 42
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"dayCell", for: indexPath) as! CalendarCollectionCell
        
        selectedDateComponents = currentCalendar.dateComponents([.hour,.day,.month,.year,.weekday], from: selectedDate)
        
        print("SelectedDate: \(selectedDate)")
        print("selectedDateComponents: \(selectedDateComponents)")
        
        //make selected day 1st of month
        selectedDateComponents.day = 1
        //to avoid that automatic conversion to UTC causes go back to previous Date
        selectedDateComponents.hour = 12
        
        print("selectedDateComponents1st: \(selectedDateComponents)")
        
        //index of 1st day of month in collectionview. It depends on represented 1st weekday (Sunday in US)
        indexOfSelected1st = selectedDateComponents.weekday! - currentCalendar.firstWeekday
        //for months starting on first cell (day 1), shift down to show one day from previous month
        indexOfSelected1st = (indexOfSelected1st < 1) ? indexOfSelected1st + 7 : indexOfSelected1st
        
        print("indexOfSelected1st: \(indexOfSelected1st)")
        
        //clear weekday of selected
        selectedDateComponents.weekday = nil
        
        firstDateOfSelected = currentCalendar.date(from:selectedDateComponents)!
        
        print("firstDateOfSelected: \(firstDateOfSelected)")
    
        //number of days relative to 1st of month
        dayDiff = indexPath.item - indexOfSelected1st
            print("dayDiff: \(dayDiff)")
        
        //Date of cell to be painted according to dayDiff
        let cellDate = Date (timeInterval:oneDay*Double(dayDiff), since:firstDateOfSelected)
            print("cellDate: \(cellDate)")
        //remake components for cell date
        var cellDateComponents = currentCalendar.dateComponents([.day, .month, .year, .weekday, .weekOfMonth, .weekOfYear], from: cellDate)
            print("cellDateComponents: \(cellDateComponents)")
        //MonthDay for cell
        cell.dayNumberLBL.text = "\(cellDateComponents.day!)"
        
        //shadowed color of previous and next month
        cell.dayNumberLBL.textColor = (selectedDateComponents.month==cellDateComponents.month) ? darkerGrey : lighterGrey
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = ( self.view.frame.width / 7 )
        let cellHeight = cellWidth * 72 / 50
        let size = CGSize(width:cellWidth,height:cellHeight)
        
        return size
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
    
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                            withReuseIdentifier:"headerView",
                                                            for: indexPath) as! CollectionHeaderReusableView
            //header.monthLBL.text = "\((currentDateComponents.month?.description)!)"
            
            formatter.dateFormat = "MMMM yyyy"
            header.monthLBL.text = formatter.string(from: selectedDate).localizedUppercase
            
            return header
            
            
        case UICollectionElementKindSectionFooter:
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                            withReuseIdentifier:"footerView",
                                                            for: indexPath) as! CollectionFooterReusableView
            return footer
            
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        
        print("next")
        print("selectedDate: \(selectedDate)")
        print("selectedDateComponents: \(selectedDateComponents)")
       
        
        if (selectedDateComponents.month! < 12) {
            
            selectedDateComponents.month! += 1
            
        }else{
            
            selectedDateComponents.month = 1
            selectedDateComponents.year! += 1
        }
        
        print("selectedDateComponents: \(selectedDateComponents)")
        
        selectedDate = currentCalendar.date(from:selectedDateComponents)!
        
        print("selectedDate: \(selectedDate)")
        self.CollecionViewOT!.reloadData()
        
    }
    

    @IBAction func pastMonth(_ sender: UIButton) {
        
        print("past")
        print("selectedDate: \(selectedDate)")
        print("selectedDateComponents: \(selectedDateComponents)")
        
        if (selectedDateComponents.month! > 1) {
            
            selectedDateComponents.month! -= 1
        }else{
            
            selectedDateComponents.month = 12
            selectedDateComponents.year! -= 1
        }
        
        print("selectedDateComponents: \(selectedDateComponents)")
        
        selectedDate = currentCalendar.date(from:selectedDateComponents)!
        
        print("selectedDate: \(selectedDate)")
        self.CollecionViewOT!.reloadData()
    
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
