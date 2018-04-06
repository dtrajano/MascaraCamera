//
//  PreviewViewController.swift
//  MascaraCamera
//
//  Created by Diogo Trajano on 06/04/18.
//  Copyright © 2018 Diogo Trajano. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var imgPreview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
