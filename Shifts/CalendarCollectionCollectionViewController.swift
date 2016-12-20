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
var selectedDate = currentDate
var dayDiff = 0
var selectedDateComponents = DateComponents()
var firstDayOfSelected = Date()
var firstDayOfSelectedComponents = DateComponents()
var indexOfSelected1st = 0


class CalendarCollectionCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("SelectedDate: \(selectedDate)")
        
        selectedDateComponents = currentCalendar.dateComponents([.day, .month, .year, .weekday, .weekOfMonth, .weekOfYear], from: selectedDate)
        
        selectedDateComponents.day = 1
        
        firstDayOfSelected = currentCalendar.date(from:selectedDateComponents)!
        print("firstdayofselected: \(firstDayOfSelected)")
        
        firstDayOfSelectedComponents = currentCalendar.dateComponents([.day, .month, .year, .weekday, .weekOfMonth, .weekOfYear], from: firstDayOfSelected)
        
        //index of 1st day of month in collection view
        indexOfSelected1st = firstDayOfSelectedComponents.weekday!-currentCalendar.firstWeekday
        
        //for months starting on first cell (day 1), shift down to show one day from previous month
        indexOfSelected1st = (indexOfSelected1st == 0) ? indexOfSelected1st + 7 : indexOfSelected1st
        print("indexOfSelected1st: \(indexOfSelected1st)")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "dayCell")

        // Do any additional setup after loading the view.
    }
    
     func viewWillAppear() {
        super.viewWillAppear(true)
      
  
    }

    
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
        
        
        
        //number of days relative to 1st of month
        dayDiff = indexPath.item - indexOfSelected1st
            print("dayDiff: \(dayDiff)")
        
        //Date of cell to be painted according to dayDiff
        let cellDate = Date (timeInterval:oneDay*Double(dayDiff), since:firstDayOfSelected)
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
    
    func nextMonth() {
        
        firstDayOfSelectedComponents.month! += 1
        self.collectionView?.reloadData()
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
