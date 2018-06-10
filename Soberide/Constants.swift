//
//  Constants.swift
//  Soberide
//
//  Created by Grant Parton on 6/8/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
