//
//  Helper.swift
//  altamira
//
//  Created by recep daban on 5.08.2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class Helper: NSObject {

    static let sharedHelper = Helper.init()
    
    func getScreenWidth() -> CGFloat
    {
        return UIScreen.main.bounds.size.width
    }
    
    func getScreenHeight() -> CGFloat
    {
        return UIScreen.main.bounds.size.height
    }
}
