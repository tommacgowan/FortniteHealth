//
//  UIView.swift
//  FortniteHealth
//
//  Created by Heath Rusby on 20/6/18.
//  Copyright © 2018 Tom Macgowan. All rights reserved.
//

import UIKit

extension UIView {
    
    func setWidth(width: CGFloat)
    {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
}
