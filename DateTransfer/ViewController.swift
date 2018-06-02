//
//  ViewController.swift
//  DateTransfer
//
//  Created by Black on 2018/05/27.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var outputDateLb: UILabel! //output date or message
    @IBOutlet weak var outputImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDate.delegate = self
        
        inputDate.placeholder = "YYYYMMDD"
        inputDate.clearButtonMode = .WhileEditing
        inputDate.tintColor = UIColor.grayColor()
        
        inputDate.layer.masksToBounds = true
        inputDate.layer.cornerRadius = 6.0
        inputDate.layer.borderWidth = 2.0
        inputDate.layer.borderColor = UIColor.redColor().CGColor
        
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
        
        inputDate.resignFirstResponder() //hide the keyboard
        
        let str1 = inputDate.text
        let str1Trim = str1!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if  str1Trim.characters.count == 8{
            
            let str2 = str1!.substringFromIndex(str1!.startIndex.advancedBy(4)) //MMDD
            
            let year = Int(str1!.substringToIndex(str1!.startIndex.advancedBy(4)))
            
            let month = Int(str2.substringToIndex(str2.startIndex.advancedBy(2)))
            
            let day = Int(str1!.substringFromIndex(str1!.startIndex.advancedBy(6)))
            
            var checkDate = false
            
            //when input is numberic, check the date
            if(year != nil && month != nil && day != nil){
                
                checkDate = effectiveDate(year!,month:month!,day:day!)
            }
            
            if(checkDate){
                
                var cal: NSCalendar!
                let df = NSDateFormatter()
                df.dateStyle = .LongStyle
                
                let comps = NSDateComponents()
                comps.year = year!
                comps.month = month!
                comps.day = day!
                cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                if let date = cal.dateFromComponents(comps) {
                    
                    //Japanese Calendar
                    df.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierJapanese)
                    
                    let out = output(String(df.stringFromDate(date)))
                    outputDateLb.text = out
                    outputImage.image = UIImage(named: "3")
                    //outputDateLb.text = df.stringFromDate(date)
                    //print(df.stringFromDate(date))
                }
                
            }else{
                outputImage.image = UIImage(named: "2")
                outputDateLb.text = "你自己看看你敲的什么,有这天吗！?"
            }
        }else{
            //input is space or null
            if (str1Trim == "" || str1 == nil){
                outputImage.image = UIImage(named: "0")
                outputDateLb.text = ""
            }else{
                //input < 8 byte
                outputImage.image = UIImage(named: "1")
                outputDateLb.text = "瞎敲什么！你敲的是日期吗！？"
            }
            
        }
        
    }
    
    //check date
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
    
    //8 byte limit
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool{
        let maxLength = 8
        let currentString: NSString = textField.text!
        let newString: NSString =
        currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
}
