#import <UIKit/UIKit.h>

@interface PageScrollView : UIView <UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
	CGRect _pageRegion, _controlRegion;
	NSMutableArray *_pages;
	id _delegate;
}
-(void)layoutViews;
-(void) notifyPageChange;
- (void)setPageControlHidden:(BOOL)hidden;

@property(nonatomic,assign,getter=getPages)       NSMutableArray * pages;		 /* UIView Subclases */
@property(nonatomic,assign,getter=getCurrentPage) int              currentPage; 
@property(nonatomic,assign,getter=getDelegate)    id               delegate;     /* PageScrollViewDelegate */
@end

@protocol PageScrollViewDelegate<NSObject>

@optional

-(void) pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage;

-(void) pageScrollViewWillBeginDragging:(PageScrollView *)pageScrollView;

@end