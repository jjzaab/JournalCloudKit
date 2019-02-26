//
//  Entry.swift
//  JournalCloudKit
//
//  Created by XMS_JZhan on 2/25/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let titleKey = "Title"
    static let textKey = "Body"
    static let EntryKey = "Entry"
}

class Entry {
    let title: String
    let text: String
    let ckRecordID: CKRecord.ID
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
        self.ckRecordID = CKRecord.ID(recordName: UUID().uuidString)
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[Constants.titleKey] as? String,
            let text = ckRecord[Constants.textKey] as? String else { return nil }
        self.init(title: title, text: text)
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: Constants.EntryKey, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: Constants.titleKey)
        self.setValue(entry.text, forKey: Constants.textKey)
    }
}


