

#import "ViewController.h"
#import "ImgLikeView.h"

@interface ViewController ()<BaseLikeViewDelegate>

@property (nonatomic,assign) CGFloat rotation;
@property (nonatomic,assign) CGPoint originCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat vx = 20;
    CGFloat vw = self.view.frame.size.width - 2*vx;
    //可通过继续BaseLikeView，实现内容多样化
    ImgLikeView *likeView1 = [[ImgLikeView alloc] initWithFrame:CGRectMake(vx, 80, vw, vw) parentView:self.view];
    [self.view addSubview:likeView1];
    likeView1.delegate = self;
    [likeView1 setImgName:@"1"];
    
    ImgLikeView *likeView2 = [[ImgLikeView alloc] initWithFrame:CGRectMake(vx, 80, vw, vw) parentView:self.view];
    [self.view addSubview:likeView2];
    likeView2.delegate = self;
    [likeView2 setImgName:@"2"];

}

#pragma mark - BaseLikeViewDelegate

- (void)baseLikeViewDidTouchFinished:(BaseLikeView *)view isBeyondBounds:(BOOL)isBeyondBounds{
    if (isBeyondBounds) {
        [self.view sendSubviewToBack:view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
