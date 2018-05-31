//
//  ViewController.swift
//  DateTransfer
//
//  Created by Black on 2018/05/27.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var outputDateLb: UILabel!
    @IBOutlet weak var outputImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputDate.placeholder = "YYYYMMDD"
        inputDate.clearButtonMode = .WhileEditing
        
        outputImage.image = UIImage(named: "0")
        
        okButton.backgroundColor = UIColor(red:0.02,green:0.48,blue:1,alpha:0.5)
        okButton.layer.borderColor = UIColor.blackColor().CGColor
        okButton.layer.borderWidth = 2
        okButton.layer.cornerRadius = 5
        okButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        outputDateLb.textColor = UIColor.redColor()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        inputDate.resignFirstResponder()
    }

    @IBAction func OKTapped(sender: AnyObject) {
        
        inputDate.resignFirstResponder()
        
        let str1 = inputDate.text
        
        if  str1!.characters.count == 8{
          let str2 = str1!.substringFromIndex(str1!.startIndex.advancedBy(4))
        
          let year = Int(str1!.substringToIndex(str1!.startIndex.advancedBy(4)))
        
          let month = Int(str2.substringToIndex(str2.startIndex.advancedBy(2)))
        
          let day = Int(str1!.substringFromIndex(str1!.startIndex.advancedBy(6)))
            
            let checkDate = effectiveDate(year!,month:month!,day:day!)
            
            if(checkDate){
                
                var cal: NSCalendar!
                
                //表示用
                let df = NSDateFormatter()
                df.dateStyle = .LongStyle //
                
                //グレゴリオ暦でNSDateを作る
                let comps = NSDateComponents()
                comps.year = year!
                comps.month = month!
                comps.day = day!
                cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                if let date = cal.dateFromComponents(comps) {
                    
                    //和暦で表示する
                    df.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierJapanese)
                    
                   let out = output(String(df.stringFromDate(date)))
                    outputDateLb.text = out
                    outputImage.image = UIImage(named: "3")
                    //outputDateLb.text = df.stringFromDate(date)
                    //print(df.stringFromDate(date))
                }
                
            }else{
                outputImage.image = UIImage(named: "2")
                outputDateLb.text = "你自己看看你敲的日期,有这天吗！?"
            }
        
        }else{
            outputImage.image = UIImage(named: "1")
            outputDateLb.text = "瞎敲什么！日期几位？啊？几位！？"
        }
    }
    
    //日付有効チェック
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
    
    
    func output(output:String)->String{
        
        let outputYear = output.characters.split(" ")
        let years = String(outputYear[2])
        let yearsNo = String(outputYear[3])
        
        var outYearNos = ""
        
        switch yearsNo {
            
        case "Meiji":
            outYearNos = "明治"
            return ("真不是蒙的！和历是: " + outYearNos + " " + years + "年")
            
        case "Taishō":
            outYearNos = "大正"
            return ("真不是蒙的！和历是: " + outYearNos + " " + years + "年")
            
        case "Shōwa":
            outYearNos = "昭和"
            return ("真不是蒙的！和历是: " + outYearNos + " " + years + "年")
            
        case "Heisei":
            outYearNos = "平成"
            return ("真不是蒙的！和历是: " + outYearNos + " " + years + "年")
            
        default : outYearNos = "1868年9月8号以前是古年号，不稀查吧！"
            return (outYearNos)
        }
    
    }
}
