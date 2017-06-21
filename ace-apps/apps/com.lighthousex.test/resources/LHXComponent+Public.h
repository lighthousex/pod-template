//
//  LHXComponent+Public.h
//  Eudaimonia
//
//  Created by Zitao Xiong on 4/13/17.
//  Copyright © 2017 Zitao Xiong. All rights reserved.
//

#ifndef LHXComponent_Public_h
#define LHXComponent_Public_h
IB_DESIGNABLE
@interface UIView (LHXSmartDesignPublic)
//must declare explicitly, otherwise IB won't pickup IBInspectable property
@property (nonatomic, readwrite, nullable) IBInspectable NSString *lhx_propertyName;
@end
#endif /* LHXComponent_Public_h */
