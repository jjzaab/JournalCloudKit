//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by XMS_JZhan on 2/25/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    private let entryController = EntryController()
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        updateViews()
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.text
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, title != "", let text = bodyTextView.text, text != "" else { return }
        
        entryController.addEntryWith(title: title, text: text) { (success) in
            if success {
                self.entryController.fetchEntries(completion: { (success) in
                    
                })
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }

}

extension EntryDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}
