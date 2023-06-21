//
//  Classes.swift
//  FlavorBot
//
//  Created by Taif Al.qahtani on 17/06/2023.
//

import Foundation


struct User{
    var uid : String
    var name : String
    var email : String
}


struct Recipe {
    var rid : String
    var name : String
    var ingredients : [String]
    var instructions : [String]
}
