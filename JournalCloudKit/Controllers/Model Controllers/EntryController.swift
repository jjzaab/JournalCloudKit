//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by XMS_JZhan on 2/25/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    fileprivate static let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Source of truth
    var entries: [Entry] = []
    
    // MARK: - CRUD
    func save(entry: Entry, completion: @escaping (Bool) -> Void) {
        
        let record = CKRecord(entry: entry)
        EntryController.privateDB.save(record) { (record, error) in
            if let error = error {
                print("Error saving to CloudKit: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let record = record else {
                completion(false)
                return
            }
            guard let entry = Entry(ckRecord: record) else {
                completion(false)
                return
            }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, text: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, text: text)
        save(entry: entry) { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.EntryKey, predicate: predicate)
        EntryController.privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching from CloudKit: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else {
                completion(false)
                return
            }
            
            let entriesArray = records.compactMap({(record) -> Entry? in
                return Entry(ckRecord: record)
            })
            
            self.entries = entriesArray
            completion(true)
        }
    }
}
