//
//  ViewController.swift
//  PickerInUITextField
//
//  Created by Trista on 2021/2/4.
//

import UIKit

//UIPickerView 的委任對象設置為self：ViewController的類別，遵守委任模式需要的協定 UIPickerViewDelegate 與 UIPickerViewDataSource，用來實作 UIPickerView 委任模式的方法
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //建立兩個屬性
    let meals = ["早餐","午餐","晚餐","宵夜"]
    var formatter: DateFormatter! = nil

    //UIPickerViewDataSource 必須實作的方法
    //UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //UIPickerViewDataSource 必須實作的方法
    //UIPickerView 各列有多少行資料
    //參數component代表哪一列,從0開始算起
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //返回陣列 meals 的成員數量
        return meals.count
    }
    
    //UIPickerView 每個選項顯示的資料
    //參數component及row，分別代表哪一列以及這列的哪一行資料,都是從0開始算起
    func pickerView(_ pickerView: UIPickerView,
      titleForRow row: Int,
      forComponent component: Int) -> String? {
        //設置為陣列 meals 的第 row 項資料
        return meals[row]
    }

    //UIPickerView 改變選擇後執行的動作
    //參數component及row，分別代表哪一列以及這列的哪一行資料,都是從0開始算起
    func pickerView(_ pickerView: UIPickerView,
      didSelectRow row: Int, inComponent component: Int) {
        //依據元件的 tag 取得 UITextField
        //UITextField 元件的tag設為100且加入到self.view
        //要取回這個 UITextField 時，就是使用self.view?.viewWithTag(100) as? UITextField
        let myTextField = self.view?.viewWithTag(100) as? UITextField

        //將 UITextField 的值更新為陣列 meals 的第 row 項資料
        myTextField?.text = meals[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //取得螢幕的尺寸
        let fullScreenSize = UIScreen.main.bounds.size
        
        //建立一個UIPickerView，設定好它的位置、尺寸及委任對象，並加入到畫面中
        //建立 UIPickerView 設置位置及尺寸
        //UIPickerView 的委任對象設置為self：ViewController
        //再新增此類別的實體,用來實作委任模式的方法
        let myPickerView = UIPickerView()
        
        //設定 UIPickerView 的 delegate 及 dataSource
        myPickerView.delegate = self
        myPickerView.dataSource = self
        
              
        //建立一個 UITextField
        var myTextField = UITextField(frame: CGRect(
                  x: 0, y: 0,
                  width: fullScreenSize.width, height: 40))
        
        //UITextField 的屬性inputView，預設為一個鍵盤的view
        //將 UITextField 原先鍵盤的view更換成 UIPickerView
        myTextField.inputView = myPickerView
 
        //設置 UITextField 預設的內容
        myTextField.text = meals[0]

        //所有 UIKIT元件都有tag這個屬性，可以為它設置一個整數數字
        //在之後要使用時，可以用父視圖的方法viewWithTag()來取得
        myTextField.tag = 100
   
        //設置 UITextField 其他資訊並放入畫面中
        myTextField.backgroundColor = UIColor.init(
                  red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
                myTextField.textAlignment = .center
                myTextField.center = CGPoint(
                  x: fullScreenSize.width * 0.5,
                  y: fullScreenSize.height * 0.15)
                    
        //UITextField 元件的tag設為100且加入到self.view
        //加入到畫面
        self.view.addSubview(myTextField)
        
        
        //建立一個與 UIDatePicker 結合應用的 UITextField
        //建立另一個 UITextField
        myTextField = UITextField(frame: CGRect(
          x: 0, y: 0,
          width: fullScreenSize.width, height: 40))

        //初始化 formatter 並設置日期顯示的格式
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"

        //建立一個 UIDatePicker
        let myDatePicker = UIDatePicker()

        //設置 UIDatePicker 偏好的選取模式
        myDatePicker.preferredDatePickerStyle = .wheels
        
        //設置 UIDatePicker 格式
        myDatePicker.datePickerMode = .date

        //設置 UIDatePicker 顯示的語言環境
        myDatePicker.locale =
            NSLocale(localeIdentifier: "zh_TW") as Locale

        //設置 UIDatePicker 預設日期為現在日期
        myDatePicker.date = NSDate() as Date

        //設置 UIDatePicker 改變日期時會執行動作的方法
        myDatePicker.addTarget(self,action:#selector(ViewController.datePickerChanged),for: .valueChanged)

        //UITextField 的屬性inputView，預設為一個鍵盤的view
        //將 UITextField 原先鍵盤的view更換成 UIPickerView
        myTextField.inputView = myDatePicker

        //設置 UITextField 預設的內容
        myTextField.text = formatter.string(from: myDatePicker.date)

        //所有 UIKIT元件都有tag這個屬性，可以為它設置一個整數數字
        //在之後要使用時，可以用父視圖的方法viewWithTag()來取得
        myTextField.tag = 200

        //設置 UITextField 其他資訊並放入畫面中
        myTextField.backgroundColor = UIColor.init(
          red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        myTextField.textAlignment = .center
        myTextField.center = CGPoint(
          x: fullScreenSize.width * 0.5,
          y: fullScreenSize.height * 0.25)
        
        //加入到畫面
        self.view.addSubview(myTextField)
        
        
        //選擇完後可以隱藏 UIPickerView 或 UIDatePicker
        //點擊空白處可以隱藏編輯狀態的功能
        // 增加一個觸控事件
        let tap = UITapGestureRecognizer(target: self,action:#selector(ViewController.hideKeyboard))

        tap.cancelsTouchesInView = false

        //加在最基底的 self.view 上
        self.view.addGestureRecognizer(tap)
        
    }
    
    
    //變換日期後執行動作的方法
    //UIDatePicker 改變選擇時執行的動作
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        //依據元件的 tag 取得 UITextField
        //UITextField 元件的tag設為200且加入到self.view
        //要取回這個 UITextField 時，就是使用self.view?.viewWithTag(100) as? UITextField
        let myTextField = self.view?.viewWithTag(200) as? UITextField

        //將 UITextField 的值更新為新的日期
        myTextField?.text = formatter.string(from: datePicker.date)
    }
    
    
    //按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

}

