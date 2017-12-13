
#import <UIKit/UIKit.h>

@class BaseLikeView;
@protocol BaseLikeViewDelegate <NSObject>

- (void)baseLikeViewDidTouchFinished:(BaseLikeView *)view isBeyondBounds:(BOOL)isBeyondBounds;

@end

//类似陌陌的点点功能
@interface BaseLikeView : UIView

- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)parentView;

@property (nonatomic,assign) id<BaseLikeViewDelegate> delegate;

@end
