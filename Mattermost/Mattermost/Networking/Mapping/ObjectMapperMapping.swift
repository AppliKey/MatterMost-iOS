//
//  ObjectMapperMapping.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import ObjectMapper

func objectMapperMapping<T: BaseMappable>() -> (_ responce: Any) -> T? {
    return { response in
        return Mapper<T>().map(JSONObject: response)
    }
}
