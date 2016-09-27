//
//  IFQMethodSwizzle.h
//  IFQLive
//
//  Created by taizi on 16/9/27.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#ifndef IFQMethodSwizzle_h
#define IFQMethodSwizzle_h

#include <stdio.h>
#include <objc/runtime.h>

void IFQSwizzleMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

#endif /* IFQMethodSwizzle_h */
