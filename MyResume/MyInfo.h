//
//  MyInfo.h
//  MyResume
//
//  Created by 韩威 on 16/7/22.
//  Copyright © 2016年 韩威. All rights reserved.
//

#ifndef MyInfo_h
#define MyInfo_h


#define Personal_Information @"姓名：韩威  \n学历：本科  \n工作经验：27个月 \n手机：159-1093-7390  \nEmail：hw1627@163.com \n\n应聘职位：iOS开发工程师 \n目前状况：已离职"


#define Skills @"1、熟练运用Xcode开发工具，熟悉iOS常用类库AVFoundation、MediaPlayer多媒体类库、CoreLocation、MapKit、Core Animation等\n2、熟练扫码，阿里云存储，支付，分享，XMPP，融云，地图等常用功能的开发\n3、熟练使用SQLite，对象归档，plist做iOS数据持久化，熟悉CoreData。\n4、掌握iOS网络通信协议，数据传输，JSON数据解析，熟练使用GCD、NSOperation、NSThread多线程编程\n5、熟练掌握MVC、代理、观察者、Block等常用设计模式以及控制器的生命周期\n6、熟练使用基本常用的第三方框架AFNetworking、SDWebImage、MJRefresh、YYModel、MBProgressHUD等\n7、熟悉推送服务通知Push Notification的实现管理\n8、熟练使用CocoaPods管理第三方框架，熟练SDK分享、登录、统计、推送、扫码等，熟悉微信、支付宝、Apple Pay支付\n9、熟练使用Storyboard和Nib，熟练使用Git、SVN管理代码\n10、熟练掌握iOS系统的事件捕捉、传递机制及事件响应者链\n11、熟练Objective-C的内存管理（ARC & MRC）"

#define Project_QuanWang @"项目名称：圈往\n开发周期：2015/06 – 2015/12\n链接:\nhttps://itunes.apple.com/cn/app/quan-wang/id1017192309?mt=8\n项目简介: 是专门为商学院、企业培训机构、以及商圈平台打造的线上客户服务系统\n项目职责：负责整个项目iOS端的开发、BUG调试和产品上线。（1.0和1.1两个版本）\n技术点：\n1、基于AFNetworking封装NetworkClient网络请求库，缓存JSON数据到本地，使用户体验更好，也便于后期的维护。\n2、使用MJRefresh进行上拉和下拉的加载数据，更节省用户流量。\n3、基于XMPPFramework封装ChatClient聊天类，进行消息收发和聊天用户的上线、下线等逻辑的处理。\n4、基于FMDB封装DataBase数据存储类，用于存储和读取用户的聊天记录。\n5、使用阿里云（AliyunOSSiOS）保存和读取用户聊天的图片和语音数据。\n6、封装HWADScrollview图片轮播器，可加载网络和本地图片。\n7、使用CocoaPods管理项目中的第三方框架。\n8、使用极光推送（JPush）进行消息的推送。\n9、使用 NSFileManager 计算文件大小、数目,实现缓存清理。\n10、优化动态列表的滚动流畅性：使用ViewModelFrame来进行一次性计算所有cell的布局信息，缓存到内存中。\n11、集成支付宝和银联两种支付方式来进行支付。"

#define Project_JinKaixun @"项目名称：金凯讯\n开发周期：2015/09 – 2015/11\n链接:\nhttps://itunes.apple.com/cn/app/jin-kai-xun-cai-jing-zi-xunapp/id1052972787?mt=8\n项目职责：一些BUG的修改和K线图的绘制等。\n技术点：\n1、利用socket通讯封装网络类，实时接收服务器的数据。\n2、利用UIWebview加载一些网络界面。\n3、利用算法计算K线、VOL、RSI、KDJ、MACD、BOLL等指标的值。\n4、使用异步加载、图片缓存等方式实现 TableView 的性能优化"

#define Project_YanShu @"项目名称：鼹鼠识货\n开发周期：2016/01 – 2016/02\n链接:\nhttps://itunes.apple.com/cn/app/yan-shu-shi-huo-peng-you-jian/id980185081?mt=8\n项目职责：负责整个项目iOS端的开发和接口的对接等工作。\n技术点：\n1、使用AFNetworking进行网络数据的获取和SDWebimage加载网络图片。\n2、集成友盟分享SDK，分享内容到微信、朋友圈和QQ。\n3、使用Storyboard和Xib以及纯代码写界面。\n4、使用ABAddressBookRef 获取手机联系人信息，然后取到手机号上传到服务器。\n5、使用UIWebview加载一些网络界面。\n6、自定义Cell，采用MVC模式分离。"

#define Project_DaDaJipei @"项目名称：达达集配\n开发周期：2016/03 – 2016/06\n链接:\nhttps://itunes.apple.com/cn/app/da-da-ji-pei/id1125271535?mt=8\n项目简介: 定位车辆，货物动态实时查询，实现物流运输高效透明；历史运单快速查询\n项目职责：负责iOS端的开发，以及接口对接和接口需求文档的编写。\n技术点：\n1、聊天页面的封装以及优化，基于XMPPFramework进行聊天。\n2、使用 AFNetworking 请求网络数据和 MJExtension 解析 JSON 数据。=\n3、集成百度地图，实时显示好友（司机）的位置以及导航功能。\n4、使用block、delegate和通知处理不同的事件。\n5、封装User单例类，对用户的信息进行处理。"

#define Project_YiMer @"项目名称：伊美尔\n开发周期：2016/05 – 2016/07\n链接：暂时未上架\n项目职责：负责项目iOS端的开发。\n项目简介：方便用户和咨询师的沟通交流，提供预约患者，查看自己的销售业绩等。\n技术点：\n1、集成融云SDK实现咨询师和客户之间的聊天。\n2、封装日历视图，实现每天展示预约咨询和预约治疗的患者个数，点击可查看详情。\n3、利用sqlite实现用户的最近搜索记录（去掉重复的，最近的放上面）。\n4、利用贝塞尔曲线和CAShapeLayer实现扇形比例图。"

#define Work_Experience @"2015/03 – 2016/07\n安卓联航软件科技（北京）有限公司 | iOS高级开发工程师\n行业类别：计算机软件\n工作描述：\n1、产品前期调研，需求分析。\n2、项目规划，架构设计。\n3、功能模块实现，优化。\n4、修复bug。\n5、产品上线，迭代维护。\n\n2014/04 -- 2015/02\n北京时代华唐软件服务有限公司 | iOS开发工程师\n行业类别：计算机软件\n工作描述：\n负责项目iOS端的开发，与后台人员进行接口对调，项目上线等工作。"

#define Personal_valuation @"从事iOS开发两年多，分析设计能力强，思路清晰，学习能力强,工作认真负责、细心，有不错的解决问题能力。热爱互联网，喜欢逛逛论坛看看博客等。喜欢接受新的挑战，来挑战自己。希望能有一个好的发展环境，一起拼搏，奋斗。"


#endif /* MyInfo_h */
