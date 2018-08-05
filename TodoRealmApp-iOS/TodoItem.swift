//
//  TodoItem.swift
//  TodoRealmApp-iOS
//
//  Created by Nobuhiro Takahashi on 2018/08/05.
//  Copyright © 2018年 Nobuhiro Takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var title = ""
}
