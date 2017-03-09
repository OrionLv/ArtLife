# Art Life

####项目是自己通过抓包几个项目接口，然后拼接成的一个完整的项目

####项目一共分有四个模块：
- 首页
- 生活
- 分类
- 个人

####现在是各个页面的效果展示：

> 首页

![首页](https://github.com/OrionLv/ArtLife/blob/master/%E9%A6%96%E9%A1%B5.gif)

> 生活

![生活](https://github.com/OrionLv/ArtLife/blob/master/%E7%94%9F%E6%B4%BB.gif)

> 分类

![分类](https://github.com/OrionLv/ArtLife/blob/master/%E5%88%86%E7%B1%BB.gif)

> 个人

![个人](https://github.com/OrionLv/ArtLife/blob/master/%E4%B8%AA%E4%BA%BA.gif)

### 好了  接下来进入正题 

##### 先讲一下 各个页面的出处：接口分别为 半糖， 开眼， 片刻 ，抓包工具的是青花瓷，想要了解详细的同学可以自行百度 

##### 接下来来说下文件用到的第三方的库

- SDCycleScrollView (无线轮播图)
- Masonry (老司机们这个应该不用解释了)
- MJExtension
- MJRefresh
- SDWebImage
- SVProgressHUD

用到的都是最基本的第三方库 ，有兴趣的同学可以看下源码 ，源码链接放在文章的最后

##### 另外是文件中用到的比较重要的类

- UIView+Addition 方便取控件的各个属性，不用再频繁的...
- XBRefreshHeader XBRefreshFooter 这两个类 是定义刷新的动画
- AFOwnerHTTPSessionManager 网络请求类 
- XBLoadingView 加载蒙版类 （控制加载的动画）

另外的还有视频播放的类，主流框架的搭建等等的类，有兴趣的同学同上



#### 好了，因为项目虽然只是个小的项目，但是牵涉的文件太多，我也不方便在这里一一的说，最后直接放源码，如果喜欢的同学麻烦点个start,不胜感激~
