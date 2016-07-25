# PSRefresh
滚动视图的横向刷新和加载，像MJRefresh一样简单，
只需一行代码，支持UIScrollView、UICollectionView、UITableView及其他UIScrollView派生的滚动视图


		以下列出三种调用方法
		// 普通刷新加载
		WeakSelf(self)
		[_collectionView addRefreshHeaderWithClosure:^{
				[weakSelf refreshData]; // 刷新数据
		} addRefreshFooterWithClosure:^{
				[weakSelf loadingData]; // 加载数据
		}];
    
		// gif动态图刷新加载（显示状态）
		WeakSelf(self)
		[_collectionView addGifRefreshHeaderWithClosure:^{
    		[weakSelf refreshData];
		} addGifRefreshFooterWithClosure:^{
    		[weakSelf loadingData];
		}];
    
		// gif动态图刷新加载（不显示状态）
		WeakSelf(self)
		[_collectionView addGifRefreshHeaderNoStatusWithClosure:^{
				[weakSelf refreshData];
		} addGifRefreshFooterNoStatusWithClosure:^{
    		[weakSelf loadingData];
		}];
    
		/**
 		 * ********************** 以下是调用的方法 **********************
 		 */
		/**
 		* 普通的刷新及加载
 		*/
		- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)closure;

		- (void)addRefreshFooterWithClosure:(PSRefreshClosure)closure;

		/**
 		 * gif 图刷新及加载（带有状态提示）
 		 */
		- (void)addGifRefreshHeaderWithClosure:(PSRefreshClosure)closure;

		- (void)addGifRefreshFooterWithClosure:(PSRefreshClosure)closure;

		/**
 		 * gif 图刷新及加载（不带有状态提示）
		 */
		- (void)addGifRefreshHeaderNoStatusWithClosure:(PSRefreshClosure)closure;

		- (void)addGifRefreshFooterNoStatusWithClosure:(PSRefreshClosure)closure;


		/**
 		 * ****************** 以下三个方法是对上面方法的再次封装 ******************
 		 */
		/**
 		 * 普通的刷新及加载
 		 */
		- (void)addRefreshHeaderWithClosure:(PSRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(PSRefreshClosure)footerClosure;

		/**
 		 * gif 图刷新及加载（带有状态提示）
 		 */
		- (void)addGifRefreshHeaderWithClosure:(PSRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(PSRefreshClosure)footerClosure;

		/**
 		 * gif 图刷新及加载（不带有状态提示）
 		 */
		- (void)addGifRefreshHeaderNoStatusWithClosure:(PSRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(PSRefreshClosure)footerClosure;

		/**
 		 * 结束刷新
 		 */
		- (void)endRefreshing;

    
