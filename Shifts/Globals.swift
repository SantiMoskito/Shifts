//
//  Constants.swift
//  Shifts
//
//  Created by Santiago Pérez Martínez on 10/12/16.
//  Copyright © 2016 Santiago Pérez Martínez. All rights reserved.
//

import Foundation
import UIKit

var currentCalendar = Calendar.current

////WARNING: REMOVE AFTER TESTING AND calendarCollectionViewContro
let testLocale = Locale(identifier: "he_IL") //ja_JP en_US es_ES ar_SA ne he_IL zh zh_Hant
let testCalendarIdentifier : Calendar.Identifier = .hebrew  //.japanese .gregorian .islamicUmmAlQura .buddhist .hebrew .chinese
////

let currentDate = Date()

var currentDateComponents = currentCalendar.dateComponents([.day,.month,.year,.weekday,.weekdayOrdinal], from: currentDate)

//let formatterMonthYear = DateFormatter()
//formatterMonthYear.dateFormat = "MM.yy"
let formatter = DateFormatter()

let oneDay = TimeInterval(60 * 60 * 24)

let darkerGrey  = UIColor(white: 0.4, alpha: 1)
let lighterGrey = UIColor(white: 0.8, alpha: 1)
let dayRed = #colorLiteral(red: 0.6038824556, green: 0.29627498, blue: 0.2957891252, alpha: 1)
let almostBlack = #colorLiteral(red: 0.1704671637, green: 0.1704671637, blue: 0.1704671637, alpha: 1)
let faintGrey = #colorLiteral(red: 0.963971288, green: 0.963971288, blue: 0.963971288, alpha: 1)



//print("\(DateComponents(day:1,year:selectedDateComponents.year,month:selectedDateComponents.month))")
// MARK: - Global Func
//
//func dateComponents(_ calendar:Calendar?=currentCalendar,
//                    _ timeZone:TimeZone?=currentCalendar.timeZone,
//                    _ era:Int?=nil,
//                    year:Int?=selectedDateComponents.year,
//                    month:Int?=selectedDateComponents.month,
//                    day:Int?=selectedDateComponents.day,
//                    _ hour:Int?=nil,
//                    _ minute:Int?=nil,
//                    _ second:Int?=nil,
//                    _ nanosecond:Int?=nil,
//                    _ weekday:Int?=nil,
//                    _ weekdayOrdinal:Int?=nil,
//                    _ quarter:Int?=nil,
//                    _ weekOfMonth:Int?=nil,
//                    _ weekOfYear:Int?=nil,
//                    _ yearForWeekOfYear:Int?=nil)->DateComponents{
//
//    return DateComponents(calendar: calendar,
//                   
//                   timeZone: timeZone,
//                   
//                   era: era,
//                   
//                   year: year,
//                   
//                   month: month,
//                   
//                   day: day,
//                   
//                   hour: hour,
//                   
//                   minute: minute,
//                   
//                   second: second,
//                   
//                   nanosecond: nanosecond,
//                   
//                   weekday: weekday,
//                   
//                   weekdayOrdinal: weekdayOrdinal,
//                   
//                   quarter: quarter,
//                   
//                   weekOfMonth: weekOfMonth,
//                   
//                   weekOfYear: weekOfYear,
//                   
//                   yearForWeekOfYear: yearForWeekOfYear)
//
//}




