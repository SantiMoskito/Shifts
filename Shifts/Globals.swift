//
//  Constants.swift
//  Shifts
//
//  Created by Santiago Pérez Martínez on 10/12/16.
//  Copyright © 2016 Santiago Pérez Martínez. All rights reserved.
//

import Foundation
import UIKit

let currentDate = Date()

let currentDateComponents = currentCalendar.dateComponents([ .day, .month, .year, .weekday, .weekOfMonth, .weekOfYear], from: currentDate)


//let formatterMonthYear = DateFormatter()
//formatterMonthYear.dateFormat = "MM.yy"
let formatter = DateFormatter()

let currentCalendar = Calendar.current


let oneDay = TimeInterval(60 * 60 * 24)

let darkerGrey  = UIColor(white: 0.4, alpha: 1)
let lighterGrey = UIColor(white: 0.8, alpha: 1)









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



