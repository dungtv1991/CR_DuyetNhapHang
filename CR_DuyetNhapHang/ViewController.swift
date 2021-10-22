//
//  ViewController.swift
//  CR_DuyetNhapHang
//
//  Created by Trần Văn Dũng on 07/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tappp(_ sender: Any) {
        self.navigationController?.pushViewController(DanhSachDuyetNhapHangRouter().configureVIPERDanhSachDuyetNhapHang(), animated: true)
    }
    
}


