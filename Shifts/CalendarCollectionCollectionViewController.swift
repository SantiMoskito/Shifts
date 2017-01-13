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

var shiftDateComponents = DateComponents()

let firstWeekday = currentCalendar.firstWeekday
let veryShortWeekdaysArray = currentCalendar.veryShortWeekdaySymbols
let numberOfWeekdays = veryShortWeekdaysArray.count


class CalendarCollectionCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var CollecionViewOT: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////WARNING: REMOVE AFTER TESTING
        currentCalendar = Calendar(identifier:testCalendarIdentifier)
        currentCalendar.locale = testLocale
        formatter.calendar = currentCalendar
        formatter.locale = testLocale
        ////
        
        let swipeRight = UISwipeGestureRecognizer(target:self, action:#selector(self.goPast))
        swipeRight.direction = .right
        CollecionViewOT.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target:self, action:#selector(self.goNext))
        swipeLeft.direction = .left
        CollecionViewOT.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target:self, action:#selector(self.goPast))
        swipeDown.direction = .down
        CollecionViewOT.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target:self, action:#selector(self.goNext))
        swipeUp.direction = .up
        CollecionViewOT.addGestureRecognizer(swipeUp)
        
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
        // number of items even for calendars with weeks different than 7 days
        return numberOfWeekdays*6
    }

// MARK: Collection Day Cell Presentation
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"dayCell", for: indexPath) as! CalendarCollectionCell
        
        selectedDateComponents = currentCalendar.dateComponents([.hour,.day,.month,.year,.weekday,.weekdayOrdinal], from: selectedDate)
        
                            print("SelectedDate: \(selectedDate)")
                            print("selectedDateComponents: \(selectedDateComponents)")
        
        //make selected day 1st of month
        selectedDateComponents.day = 1
        //to avoid automatic conversion to UTC causing to go back to previous Date
        selectedDateComponents.hour = 12
        
                            print("selectedDateComponents1st: \(selectedDateComponents)")
        
        //clear weekday of selected
        //selectedDateComponents.weekday = nil
        
        //create new date for 1st
        firstDateOfSelected = currentCalendar.date(from:selectedDateComponents)!
        firstDateOfSelectedComponents = currentCalendar.dateComponents([.day,.month,.year,.weekday,.weekdayOrdinal], from: firstDateOfSelected)
        
                            print("firstDateOfSelected: \(firstDateOfSelected)")
        
        //index of 1st day of month in collectionview. It depends on represented 1st weekday (ex. Lunes in ES, Sunday in US)
        indexOfSelected1st = (firstDateOfSelectedComponents.weekday! - currentCalendar.firstWeekday)
        //for months starting on first cell (day 1), shift down to show one day from previous month
        indexOfSelected1st = (indexOfSelected1st < 1) ? indexOfSelected1st + numberOfWeekdays : indexOfSelected1st
        
                            print("SelectedWeekDay: firstWeekday: \(selectedDateComponents.weekday!) \(currentCalendar.firstWeekday)")
                            print("indexOfSelected1st: \(indexOfSelected1st)")
    
        //number of days relative to 1st of month
        dayDiff = indexPath.item - indexOfSelected1st
                            print("dayDiff: \(dayDiff)")
        
        //Date of cell to be painted according to dayDiff
        let cellDate = Date (timeInterval:oneDay*Double(dayDiff), since:firstDateOfSelected)
                            print("cellDate: \(cellDate)")
        
        //remake components for cell date
        var cellDateComponents = currentCalendar.dateComponents([.day, .month, .year, .weekday,.weekdayOrdinal], from: cellDate)
                            print("cellDateComponents: \(cellDateComponents)")
        
        //MonthDay for cell
        cell.dayNumberLBL.text = "\(cellDateComponents.day!)"
        

        
        //shadowed color of previous and next month

        
        //if current Day, highlighted. If other month, shadowed. If day Sat or Sun, dayRed
        if (
            (cellDateComponents == currentDateComponents)
            //&& (cellDateComponents.month! == currentDateComponents.month!)
            //&& (cellDateComponents.year! == currentDateComponents.year!)
            //cellDate == currentDate
           ){
                cell.dayNumberLBL.textColor = .white
                cell.dayBackgroundOT.backgroundColor = darkerGrey
                cell.backgroundColor = (currentCalendar.isDateInWeekend(cellDate)) ? faintGrey : .white
        }else{
                cell.dayBackgroundOT.backgroundColor = .white
                cell.dayNumberLBL.textColor = currentCalendar.isDateInWeekend(cellDate) ? dayRed : darkerGrey
                cell.backgroundColor = (currentCalendar.isDateInWeekend(cellDate)) ? faintGrey : .white
                cell.notasViewBackground.backgroundColor = (currentCalendar.isDateInWeekend(cellDate)) ? faintGrey : .white
            
                cell.shadowOT.isHidden = (selectedDateComponents.month!==cellDateComponents.month!) ? true : false
        }
        
        ////Warning: Random notes mark for now (testing UI)
        //TODO: Get from DB
        let randomNotasTxt:UInt32 = arc4random_uniform(100)
        let randomNotasHrs:UInt32 = arc4random_uniform(100)
        let randomNotasChg:UInt32 = arc4random_uniform(100)
        cell.notaTxtOT.isHidden = (randomNotasTxt > 70) ? false : true
        cell.notaHrsOT.isHidden = (randomNotasHrs > 70) ? false : true
        cell.notaChgOT.isHidden = (randomNotasChg > 60) ? false : true
        ////
        
        
        //Personalized color of day ring according to ShiftType (Morning, Afternoon, Night, Free, Holiday....)
        ////WARNING: [[Test Code. Forced colors as of now to test auto shift prediction
        let todayShift = getShift(shiftDate: cellDate)
        
        switch todayShift {
            
        case .day :
            cell.dayRingOT.backgroundColor = testBlueDayColor
        case .afternoon :
            cell.dayRingOT.backgroundColor = testBlueAfternoonColor
        case .night :
            cell.dayRingOT.backgroundColor = testBlueNightColor
        case .free :
            cell.dayRingOT.backgroundColor = testGreenFreeColor
        case .holiday :
            cell.dayRingOT.backgroundColor = testGreenHolidayColor

        default:
            cell.dayRingOT.backgroundColor = testGreenDefaultColor
        }
        /////WARNING: Test Code ]]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let floatNumberOfWeekdays = CGFloat(numberOfWeekdays)
        let cellWidth = ( self.view.frame.width / floatNumberOfWeekdays )
        let cellHeight = cellWidth * 72 / 50
        let size = CGSize(width:cellWidth,height:cellHeight)
        
        return size
    }
    
// MARK: Header/Footer Weekdays
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
    
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                            withReuseIdentifier:"headerView",
                                                            for: indexPath) as! CollectionHeaderReusableView
           
                                print("currentDateComponentsH: \(currentDateComponents)")
            
            formatter.dateFormat = "MMMM yyyy"
            header.monthLBL.text = formatter.string(from: selectedDate).localizedUppercase
            
                                print(currentCalendar)
                                print(currentCalendar.locale!)

                                print(currentCalendar.veryShortWeekdaySymbols)
                                print(firstWeekday)
            
            //Strange index use to make it valid for all types of calendar, locales, and even numberOfWeekdays in that calendar.
            header.Weekday1.text = veryShortWeekdaysArray[(0+firstWeekday-1)%numberOfWeekdays]
            header.Weekday2.text = veryShortWeekdaysArray[(1+firstWeekday-1)%numberOfWeekdays]
            header.Weekday3.text = veryShortWeekdaysArray[(2+firstWeekday-1)%numberOfWeekdays]
            header.Weekday4.text = veryShortWeekdaysArray[(3+firstWeekday-1)%numberOfWeekdays]
            header.Weekday5.text = veryShortWeekdaysArray[(4+firstWeekday-1)%numberOfWeekdays]
            header.Weekday6.text = veryShortWeekdaysArray[(5+firstWeekday-1)%numberOfWeekdays]
            header.Weekday7.text = veryShortWeekdaysArray[(6+firstWeekday-1)%numberOfWeekdays]
            
            
            //Calculations to obtain weekend days and highlight them:
            
            //clear weekday of selected
            selectedDateComponents.day = nil
            selectedDateComponents.weekdayOrdinal = 1
            //starts asking for day in column 1  //MOD bacause if firstweekday is 2, 2+6 is out of range
            selectedDateComponents.weekday = firstWeekday%numberOfWeekdays
            let testWeekday1Date = currentCalendar.date(from: selectedDateComponents)
                                    print("===")
                                    print(selectedDateComponents)
                                    print(testWeekday1Date!)
            selectedDateComponents.weekday = firstWeekday+5%numberOfWeekdays
            let testWeekday6Date = currentCalendar.date(from: selectedDateComponents)
                                    print("===")
                                    print(selectedDateComponents)
                                    print(testWeekday6Date!)
            selectedDateComponents.weekday = firstWeekday+6%numberOfWeekdays
            let testWeekday7Date = currentCalendar.date(from: selectedDateComponents)
                                    print("===")
                                    print(selectedDateComponents)
                                    print(testWeekday7Date!)
                    
            let isWeekday1Weekend = currentCalendar.isDateInWeekend(testWeekday1Date!)
                                    print(isWeekday1Weekend)

            let isWeekday6Weekend = currentCalendar.isDateInWeekend(testWeekday6Date!)
                                    print(isWeekday6Weekend)
            
            let isWeekday7Weekend = currentCalendar.isDateInWeekend(testWeekday7Date!)
                                    print(isWeekday7Weekend)
            
            header.Weekday1.textColor = (isWeekday1Weekend) ? dayRed : almostBlack
            header.Weekday2.textColor = almostBlack
            header.Weekday3.textColor = almostBlack
            header.Weekday4.textColor = almostBlack
            header.Weekday5.textColor = almostBlack
            header.Weekday6.textColor = (isWeekday6Weekend) ? dayRed : almostBlack
            header.Weekday7.textColor = (isWeekday7Weekend) ? dayRed : almostBlack
            
            
            return header
            
            
        case UICollectionElementKindSectionFooter:
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                            withReuseIdentifier:"footerView",
                                                            for: indexPath) as! CollectionFooterReusableView
            
            //Strange index use to make it valid for all universl types of calendar, locales, and even numberOfWeekdays not equal to 7 in that calendar.
            footer.Weekday1.text = veryShortWeekdaysArray[(0+firstWeekday-1)%numberOfWeekdays]
            footer.Weekday2.text = veryShortWeekdaysArray[(1+firstWeekday-1)%numberOfWeekdays]
            footer.Weekday3.text = veryShortWeekdaysArray[(2+firstWeekday-1)%numberOfWeekdays]
            footer.Weekday4.text = veryShortWeekdaysArray[(3+firstWeekday-1)%numberOfWeekdays]
            footer.Weekday5.text = veryShortWeekdaysArray[(4+firstWeekday-1)%numberOfWeekdays]
            footer.Weekday6.text = veryShortWeekdaysArray[(5+firstWeekday-1)%numberOfWeekdays]
            footer.Weekday7.text = veryShortWeekdaysArray[(6+firstWeekday-1)%numberOfWeekdays]
            
            
            //Calculations to obtain weekend days and highlight them:
            
            //clear weekday of selected
            selectedDateComponents.day = nil
            selectedDateComponents.weekdayOrdinal = 1
            //starts asking for day in column 1  //MOD bacause if firstweekday is 2, 2+6 is out of range
            selectedDateComponents.weekday = firstWeekday%numberOfWeekdays
            let testWeekday1Date = currentCalendar.date(from: selectedDateComponents)

            selectedDateComponents.weekday = firstWeekday+5%numberOfWeekdays
            let testWeekday6Date = currentCalendar.date(from: selectedDateComponents)

            selectedDateComponents.weekday = firstWeekday+6%numberOfWeekdays
            let testWeekday7Date = currentCalendar.date(from: selectedDateComponents)
            
            let isWeekday1Weekend = currentCalendar.isDateInWeekend(testWeekday1Date!)

            let isWeekday6Weekend = currentCalendar.isDateInWeekend(testWeekday6Date!)
            
            let isWeekday7Weekend = currentCalendar.isDateInWeekend(testWeekday7Date!)
            
            footer.Weekday1.textColor = (isWeekday1Weekend) ? dayRed : almostBlack
            footer.Weekday2.textColor = almostBlack
            footer.Weekday3.textColor = almostBlack
            footer.Weekday4.textColor = almostBlack
            footer.Weekday5.textColor = almostBlack
            footer.Weekday6.textColor = (isWeekday6Weekend) ? dayRed : almostBlack
            footer.Weekday7.textColor = (isWeekday7Weekend) ? dayRed : almostBlack
            
            return footer
            
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    

// MARK: Navigation Actions
    
    @IBAction func nextMonth(_ sender: UIButton) {
        
        goNext()
    }
    
    
    func goNext(){
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
        
        goPast()
    }
    
    
    func goPast(){
        
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
    
    // MARK: Functionality
    
    func getShift(shiftDate: Date) -> Shift {
    ////TODO: Get Actual Shift from DB, for now it is fixed for testing
        shiftDateComponents = currentCalendar.dateComponents([.day,.month,.year,.weekday,.weekdayOrdinal], from: shiftDate)
        let mod = shiftDateComponents.day!%16
        switch mod {
        case 1...3:
            return Shift.day
        case 4...5:
            return Shift.night
        case 6...7:
            return Shift.free
        case 9...11:
            return Shift.afternoon
        case 12...13:
            return Shift.night
        case 14...15:
            return Shift.free
        case 8,16:
            return Shift.holiday
        default:
            return Shift.holiday
        }
       
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
