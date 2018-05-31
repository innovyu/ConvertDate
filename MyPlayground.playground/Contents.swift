import UIKit

let str1 = "19770527"
let str2 = str1.substringFromIndex(str1.startIndex.advancedBy(4))


let year = Int(str1.substringToIndex(str1.startIndex.advancedBy(4)))

let month = Int(str2.substringToIndex(str2.startIndex.advancedBy(2)))

let day = Int(str1.substringFromIndex(str1.startIndex.advancedBy(6)))



//let year = 2018, month = 01, day = 07
var cal: NSCalendar!

//表示用
let df = NSDateFormatter()
df.dateStyle = .LongStyle //お好みで!

//グレゴリオ暦でNSDateを作る
let comps = NSDateComponents()
comps.year = year!
comps.month = month!
comps.day = day!
cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
if let date = cal.dateFromComponents(comps) {
    //グレゴリオ暦で表示する
    //df.calendar = cal
    print(df.stringFromDate(date))
    
    //和暦で表示する
    df.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierJapanese)
    print("和历是："+output(df.stringFromDate(date)))
    
}

func output(output:String){

    let outputYear = output.characters.split(" ")
    let years = String(outputYear[2])
    let yearsNo = String(outputYear[3])

    var outYearNos = ""
    
    switch yearsNo {
    
        case "Meiji":
        outYearNos = "明治"
    
        case "Taishō":
        outYearNos = "大正"
        
        case "Shōwa":
        outYearNos = "昭和"
        
        case "Heisei":
        outYearNos = "平成"
        
    default : outYearNos = "1868年9月8号以前还没有年号呢！"
        
     }
    outYearNos + " "+years
}

let b = output("May 27, 1 Keiō")


func effectiveDate(year:Int,month:Int,day:Int)->Bool{
    
    if year <= 0{return false}
    
    if month < 1 || month > 12{return false}
    
    var months = [31,0,31,30,31,30,31,31,30,31,30,31]
    
    
    
    if (year%4 == 0 && year%100 != 0) || year%400 == 0{
        
        months[1] = 29
        
    }else{
        
        months[1]=28
        
    }
    
    return (day>=1)&&(day<=months[month-1])
    
}

let a = effectiveDate(2000,month:02,day:30)
