//
//  LFLivePreview.h
//  LFLiveKit
//
//  Created by 倾慕 on 16/5/2.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidActionCloseBlock)();

@interface LFLivePreview : UIView

@property (nonatomic, copy) DidActionCloseBlock didActionCloseBlock;

@end
