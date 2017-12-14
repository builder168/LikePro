
#import "BaseLikeView.h"

@interface BaseLikeView ()
{
    UIView *_parentView;
}
@property (nonatomic,assign) CGPoint originCenter;//记录最初始的中心点位置

@end

@implementation BaseLikeView

- (instancetype)initWithFrame:(CGRect)frame parentView:(UIView *)parentView{
    self = [super initWithFrame:frame];
    if (self) {
        _parentView = parentView;
        
        self.originCenter = self.center;
        
        UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doMoveAction:)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

-(void)doMoveAction:(UIPanGestureRecognizer *)recognizer{
    // Figure out where the user is trying to drag the view.
    if (!_parentView) {
        return;
    }
    //通过变换view的中心点实现view随手指移动
    CGPoint translation = [recognizer translationInView:_parentView];//获取到的是手指移动后，在相对坐标中的偏移量
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
    recognizer.view.center = newCenter;
    
    [recognizer setTranslation:CGPointZero inView:_parentView];
    
    //通过移动的距离计算倾斜的角度，最大为45度
    CGPoint center = _parentView.center;
    CGFloat dw = recognizer.view.frame.size.width * 0.5;
    CGFloat rotation;
    if (newCenter.x < center.x) {//左边
        CGFloat w1 = center.x - newCenter.x;
        rotation =[self getRotationDegreeWithAngle:-(45* w1)/dw];
    }else if(newCenter.x > center.x){//右边
        CGFloat w2 = newCenter.x - center.x;
        rotation =[self getRotationDegreeWithAngle:(45* w2)/dw];
    }else{//中间线
        rotation =[self getRotationDegreeWithAngle:0];
    }
    recognizer.view.transform = CGAffineTransformMakeRotation (rotation);
    
    //手势结束时判断
    if (recognizer.state==UIGestureRecognizerStateEnded || recognizer.state==UIGestureRecognizerStateCancelled)
    {
        if (newCenter.x < center.x) {//左边
            if (newCenter.x > (center.x - 50)) {//移动距离没有超过界限
                [UIView animateWithDuration:0.15 animations:^{
                    [self gestureFinishedWithIsBeyondBounds:NO];
                }];
            }else{//移动距离超过界限
                CGPoint dPoint = recognizer.view.center;
                dPoint.x = dPoint.x - recognizer.view.frame.size.width;
                [UIView animateWithDuration:0.35 animations:^{
                    recognizer.view.center = dPoint;
                    recognizer.view.transform = CGAffineTransformMakeRotation ([self getRotationDegreeWithAngle:-45]);
                } completion:^(BOOL finished) {
                    [self gestureFinishedWithIsBeyondBounds:YES];
                }];
            }
        }else if(newCenter.x > center.x){//右边
            if(newCenter.x < (center.x + 50)){//移动距离没有超过界限
                [UIView animateWithDuration:0.15 animations:^{
                    [self gestureFinishedWithIsBeyondBounds:NO];
                }];
            }else{//移动距离超过界限
                CGPoint dPoint = recognizer.view.center;
                dPoint.x = dPoint.x + recognizer.view.frame.size.width;
                [UIView animateWithDuration:0.35 animations:^{
                    recognizer.view.center = dPoint;
                    recognizer.view.transform = CGAffineTransformMakeRotation ([self getRotationDegreeWithAngle:45]);
                } completion:^(BOOL finished) {
                    [self gestureFinishedWithIsBeyondBounds:YES];
                }];
            }
        }
    }
    
}
//把角度转换成要旋转的度数
- (float)getRotationDegreeWithAngle:(float)angle{
    return angle * M_PI/180.0;
}
//手势完成后复原
- (void)gestureFinishedWithIsBeyondBounds:(BOOL)isBeyondBounds{
    self.center = self.originCenter;
    self.transform = CGAffineTransformMakeRotation ([self getRotationDegreeWithAngle:0]);
    
    if (self.delegate&&([self.delegate respondsToSelector:@selector(baseLikeViewDidTouchFinished:isBeyondBounds:)])) {
        [self.delegate baseLikeViewDidTouchFinished:self isBeyondBounds:isBeyondBounds];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
