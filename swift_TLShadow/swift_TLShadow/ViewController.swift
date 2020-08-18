//
//  ViewController.swift
//  swift_TLShadow
//
//  Created by TL on 2020/8/18.
//  Copyright © 2020 TL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.init(red: 216/255.0, green: 226/255.0, blue: 237/255.0, alpha: 1)
        
        
        let view0 = UILabel()
        view0.frame = CGRect.init(x: 50, y: 100, width: 100, height: 100)
        view0.backgroundColor = UIColor.init(red: 229/255.0, green: 237/255.0, blue: 246/255.0, alpha: 1)
        view0.layer.cornerRadius = 50
        view0.text = "123"
        view0.textAlignment = .center
        self.view.addSubview(view0)
        TLShadow.tl_initShadow(view: view0)

        let view1 = UILabel()
        view1.frame = CGRect.init(x: 50, y: 250, width: 100, height: 50)
        view1.backgroundColor = UIColor.init(red: 229/255.0, green: 237/255.0, blue: 246/255.0, alpha: 1)
        view1.layer.cornerRadius = 8
        view1.text = "123"
        view1.textAlignment = .center
        self.view.addSubview(view1)
        let con1 = TLShadowConfiguration()
        con1.sideType = .outSide
        con1.directionType = .rightTopDirection
        TLShadow.tl_initShadow(view: view1, configuration: con1)
        
        let view2 = UILabel()
        view2.frame = CGRect.init(x: 50, y: 350, width: 100, height: 100)
        view2.backgroundColor = UIColor.init(red: 229/255.0, green: 237/255.0, blue: 246/255.0, alpha: 1)
        view2.layer.cornerRadius = 50
        view2.text = "123"
        view2.textAlignment = .center
        self.view.addSubview(view2)
        let con2 = TLShadowConfiguration()
        con2.sideType = .inSide
        con2.directionType = .leftTopDirection
        TLShadow.tl_initShadow(view: view2, configuration: con2)
        
    }


}

