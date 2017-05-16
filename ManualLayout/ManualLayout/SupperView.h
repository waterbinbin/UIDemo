//
//  SupperView.h
//  ManualLayout
//
//  Created by 王福滨 on 2017/4/14.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupperView : UIView
{
    UIView* _view1;
    UIView* _view2;
    UIView* _view3;
    UIView* _view4;
    UIView* _view5;
}

- (void)createSubViews;
@end
