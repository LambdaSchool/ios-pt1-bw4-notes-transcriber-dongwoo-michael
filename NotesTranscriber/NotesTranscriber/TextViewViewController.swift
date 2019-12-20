//
//  TextViewViewController.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 12/20/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class TextViewViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
}
