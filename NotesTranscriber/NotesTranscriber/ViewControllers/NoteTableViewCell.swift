//
//  NoteTableViewCell.swift
//  NotesTranscriber
//
//  Created by Dongwoo Pae on 1/7/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var note: Note? {
        didSet {
            self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shareButton.imageView?.tintColor = .systemTeal
    }
    
    var delegate: NoteTableViewCellDelegate?
    
    private func updateViews() {
        
        guard let note = self.note else {return}
        
        self.noteLabel.text = note.noteText
        //Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let dateFromNote = note.timestamp
        let createdDate = dateFormatter.string(from: dateFromNote!)
        dateFormatter.timeZone = NSTimeZone.local
        self.dateLabel.text = createdDate
    }
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        self.shareButton.shake()
        self.delegate?.showActivityView(for: self)
    }
    
}

extension UIButton {
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 3, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 3, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
}
