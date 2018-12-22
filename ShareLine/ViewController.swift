//
//  ViewController.swift
//  ShareLine
//
//  Created by Jim Chuang on 2018/12/22.
//  Copyright © 2018 nhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shareImgBtnTag = 999
    let shareMsgBtnTag = 998

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {

        let shareImgBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        shareImgBtn.setTitle("share image", for: .normal)
        shareImgBtn.backgroundColor = .blue
        shareImgBtn.tag = shareImgBtnTag
        shareImgBtn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)

        let shareMsgBtn = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        shareMsgBtn.setTitle("share msg", for: .normal)
        shareMsgBtn.backgroundColor = .blue
        shareMsgBtn.tag = shareMsgBtnTag
        shareMsgBtn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)

        view.addSubview(shareImgBtn)
        view.addSubview(shareMsgBtn)
    }

    func share(){
        let image = UIImage(named: "image1.png")!
        let pasteBoard = UIPasteboard.general
        pasteBoard.setData(image.pngData()!, forPasteboardType: "public.png")
        let encodeImage = pasteBoard.name.rawValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let lineURL = URL(string: "line://msg/image/" + encodeImage!)

        if UIApplication.shared.canOpenURL(lineURL!) {
            UIApplication.shared.open(lineURL!, options: [:], completionHandler: nil)
        } else {
            let appStroeLineURL = URL(string: "itms-apps://itunes.apple.com/app/id443904275")!
            UIApplication.shared.open(appStroeLineURL, options: [:], completionHandler: nil)
        }
    }

    func shareImage(img:UIImage) ->Bool{
        let pasteBoard = UIPasteboard.general
        if let imgData = img.pngData(){
            pasteBoard.setData(imgData, forPasteboardType: "public.png")
            if let encodePasteName = pasteBoard.name.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                let lineImageStr = "line://msg/image/"
                if let lineURL = URL(string: lineImageStr + encodePasteName){
                    if UIApplication.shared.canOpenURL(lineURL){
                        UIApplication.shared.open(lineURL, options: [:], completionHandler: nil)
                        return true
                    }
                }
            }
        }

        return false
    }

    func shareMessage(str:String) ->Bool{
        if let encoeMSG = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            let lineMessageStr = "line://msg/text/"
            if let lineURL = URL(string: lineMessageStr + encoeMSG){
                if UIApplication.shared.canOpenURL(lineURL){
                    UIApplication.shared.open(lineURL, options: [:], completionHandler: nil)
                    return true
                }
            }
        }
        return false
    }

    @objc func btnClick(sender:UIButton){
        switch sender.tag {
        case shareMsgBtnTag:
            if !shareMessage(str: "Hello Test"){
                print("error 1")
            }
        case shareImgBtnTag:
            if let myImg = UIImage(named: "image1.png"){
                if !shareImage(img: myImg){
                    print("error 2")
                }
            }else{
                print("image fail")
            }
        default:
            break
        }
    }

}

