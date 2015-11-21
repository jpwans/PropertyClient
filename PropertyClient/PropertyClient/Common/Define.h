


//iphone 6 6+有放大模式和，正常模式
//判断时候为IPHONE6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

//判断时候为IPHONE6 PLUS
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//判断是否是Retina显示屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO) //iphone4
//判断是否是iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) //iphone5
#define isInch4 [UIScreen mainScreen].bounds.size.height==568  //iphone5
//判断是否是pad

//主屏宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//主屏高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//当前设备的ios版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7  ([[UIDevice currentDevice].systemVersion doubleValue] >=7.0)
//当前设备的语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//软键盘高度
#define KEYBOARD_HEIGHT 216.0f
//状态栏高度
#define STATUS_HEIGHT 20.0f
//[[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define NAVIGATION_HEIGHT  44.0f
//(self.navigationController.navigationBar.frame.size.height)
//tabBar高度
#define BUTTOMBAR_HEIGHT 49.0f
//(self.tabBarController.tabBar.frame.size.height)
//界面frame
//提醒小圆点的SIZE
#define remindSize 10

#define advWidth SCREEN_WIDTH * 180 /720

#define DEFAULT_FRAME CGRectMake(0.,0.,SCREEN_WIDTH,SCREEN_HEIGHT)
//设置系统字体大小
#define SystemFont(size) [UIFont systemFontOfSize:(size)];
//去掉状态栏和导航栏的视图大小
#define BOTTOM_FRAME CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-STATUS_HEIGHT-NAVIGATION_HEIGHT)
//去掉状态栏,导航栏和TabBar的视图大小
#define MIDDLE_FRAME CGRectMake(0,NAVIGATION_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STATUS_HEIGHT-NAVIGATION_HEIGHT-BUTTOMBAR_HEIGHT)
//默认采色
//#define DEFAULT_COLOR [UIColor colorWithRed:52/255.0 green:105/255.0 blue:227/255.0 alpha:1.0f]

//  #define SCROLL_COLOR  [UIColor colorWithRed:111/255.0 green:113/255.0 blue:121/255.0 alpha:1.0f]
#define DEFAULT_COLOR [UIColor colorWithRed:240.0/255.0 green:84.0/255.0 blue:35.0/255.0 alpha:1.0]


#define BACKGROUND_COLOR [UIColor colorWithRed:241.0/255.0 green:141.0/255.0 blue:0/255.0 alpha:1.0]//主题色

#define ALLBACKCOLOR  [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0] //背景色
//空值
#define NULL_VALUE @""
//Json里的基本字段
#define Y_Code      @"code"
#define Y_Ver       @"ver"
#define Y_Data      @"data"
#define Y_Message   @"message"
#define Y_Version  [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]



#define Y_Code_Failure  101
#define Y_Code_Success 1
#define NetError @"网络异常..."

#define URL_Error  @"/f/rest/in/moblog/insertMobLog" //捕抓崩溃
#define URL_FEEDBACK @"/f/rest/in/mobcomment/insertMobComment"//意见反馈
#define CrasLlogPath [NSHomeDirectory() stringByAppendingPathComponent:@"CrashLogs.data"]

#define URL_TOKEN @"/f/rest/in/file/getUpToken0" //获取Token
#define POST_LOGINOUT_URL @""//注销
#define LoginType @"2" //登陆type  业主为1 物业为 2
#define URL_REGISTER @"/f/rest/login/register"//注册
#define URL_SMS_AUTH @"https://api.sms.mob.com/sms/verify"//短信验证
#define URL_SUFFIX_LOGIN @"/f/rest/login/login/"//登陆
#define URL_FORGETPWD @"/f/rest/login/forgetPassword"//忘记密码
#define URL_UPDATEPWD @"/f/rest/in/car/updatePassword"//修改密码
#define URL_SERVICEPROTOCOL @"/f/app/serviceProtocol"//协议

#define URL_GETCOMMUNITY @"/f/rest/login/getAllCommunity"//获取小区
#define URL_GETROOM @"/f/rest/login/getAllRoom"//获取房屋信息

#define  URL_GETROOMLIST @"/f/rest/login/getRoomList"//获取房屋信息

#define URL_GETPHONE @"/f/rest/login/getAllphone/"//获取手机号
#define URL_ABOUTCOMMUNITY @"/f/rest/in/community/findCommunityInfo"//关于小区
#define URL_UPDATEPHOTO @"/f/rest/in/advice/updatePhoto"//更新头像
#define URL_RELATIVEUSER @"/f/rest/in/car/addRelativeInfo"//添加关联用户
#define URL_RELATIVELIST @"/f/rest/in/car/relativeList"//该业主下的关联用户
#define URL_LABELLIST @"/f/rest/in/car/labelList"//关联用户关联关系
#define URL_DELETERELATIVEINFO @"/f/rest/in/car/deleteRelativeInfo"//删除关联用户

#define  URL_FindVisitorByQrcode @"/f/rest/in/vistor/findVisitorByQrcode"//访客证验证信息
#define URL_FindCarNum @"/f/rest/in/car/findCarInfoByNo" //查询车牌号


#define URL_GETCOMPLAINTS  @"/f/rest/in/complaint/getAllCompByOwnerId"//获取投诉信息列表
#define URL_ADDCOMPLAINTS @"/f/rest/in/complaint/addComplaint"//添加投诉信息
#define URL_GETCOMPBYCOMID @"/f/rest/in/complaint/getCompDetailByCompId"//根据投诉信息ID获取投诉详情
#define URL_DELETECOMPLAINTINFO @"/f/rest/in/complaint/deleteComplaintInfo"//删除投诉信息

#define URL_GETALLACTIVITYBYID @"/f/rest/in/actity/getAllActivityByCommunityId" //根据小区编号，分页显示该小区的所有活动
#define URL_ADDACTIVITY @"/f/rest/in/actity/addActivity" //新增活动管理
#define URL_GETACTIVITYDETAILBYID @"/f/rest/in/actity/getActivityDetailById"//根据活动编号查询活动详情
#define  URL_GETALLCOMMENTBYACTIVITYID @"/f/rest/in/actity/getAllCommentByActivityId"//根据活动编号查询评论列表
#define URL_ADDACTCOMMENT @"/f/rest/in/actity/addActComment" //新增评论信息
#define URL_DELETEACTIVITYINFO @"/f/rest/in/actity/deleteActivityInfo"//删除活动

#define URL_GETFLEAMARKETSBYCOMMUNITYID @"/f/rest/in/fleaMarkets/getFleaMarketsByCommunityId" // 根据小区编号，查看该小区跳蚤市场所有商品信息
#define URL_GETFLEAMARKETBYID  @"/f/rest/in/fleaMarkets/getFleaMarketById" //根据商品ID查看详细信息
#define URL_GETALLDITBYTYPE @"/f/rest/in/dict/getAllDitByType?type=goods_category"//获取类型列表
#define URL_ADDFLEAMARKETS @"/f/rest/in/fleaMarkets/addFleaMarkets" //新增商品信息
#define URL_DELETEMARKETINFO @"/f/rest/in/fleaMarkets/deleteMarketInfo"//删除信息



/*消息通知*/
#define URL_FINDADVICELIST @"/f/rest/in/advice/findAdviceList"// 根据通知类型获取列表信息
/*报修*/
#define URL_FINREPAIRLISTBYROOMID @"/f/rest/in/repair/finRepairListByRoomId"//根据业主房间id查看报修单信息列表
#define URL_GETREPAIRDETAILBYREPAIRID @"/f/rest/in/repair/getRepairDetailByRepairId"//根据报修单编号查看报修单详情
#define URL_ADDREPAIR @"/f/rest/in/repair/addRepair"//新增报修单
#define URL_ADDREPAIRCOMMENT @"/f/rest/in/repair/addRepairComment"//新增报修评价

#define URL_CHECKREPAIR @"/f/rest/in/repair/checkRepair" //物业管理人员查看报修单
#define URL_Complete @"/f/rest/in/repair/affirmComplete"//确认完工
#define URL_UPNDATEVERSION @"/f/rest/in/version/upndateVersion"//更新版本

//API路径
#define URL_QINIU @"http://7xik26.com1.z0.glb.clouddn.com/"//七牛云
#define BASE_URL @""
//#define API_BASE_URL(_URL_) [NSURL URLWithString:[@"http://esp.vjiao.net" stringByAppendingString:_URL_]]

//#define API_BASE_URL_STRING(_URL_) [NSString stringWithFormat:@"%@%@",@"http://120.25.232.198/wuye-o2o",_URL_] //上线环境

#define API_BASE_URL_STRING(_URL_) [NSString stringWithFormat:@"%@%@",@"http://120.24.74.231:8080/wuye-o2o",_URL_] //测试环境

#define CHECKNETWORK   if (ShareDelegate.reachableViaFlag == NotReachable) {[[CheckNetwork sharedManager] notReachableAlertView];return;} //网络检查



/**
 data
 */
#define Y_USERNAME @"userName" //登陆账号
#define Y_ROLE_TYPE @"roleType"   //角色类型
#define Y_OWNERID @"ownerId"  // 业主ID
#define Y_COMMUNITY @"community" //物业名称
#define Y_COMMUNITYID @"communityId" //物业ID
#define Y_COMPANYID @"companyId"//公司ID
#define Y_company @"company"//公司名称
#define Y_employeeId @"employeeId"//员工ID
#define Y_roleName @"roleName"//员工角色名称
#define Y_NAME @"name" //姓名
#define Y_PHONE @"phone" //电话
#define Y_ROOMID @"roomId"//房间id
#define Y_ROOMNO @"roomNo"//房间号码
#define Y_SEX  @"sex" //性别
#define Y_TYPE @"type" //登陆类型  1为业主 2 为物管
#define Y_U_REMEMBER 1 //记住用户
#define Y_U_ISNOTREMEMBER 0 //不记住用户
#define Y_UIS_REMEMBER  @"isRememberUser" //是否记住用户
#define Y_PWD @"password"
#define Y_PHOTO @"photo"//头像
#define Y_buildingNo @"buildingNo"//几栋
#define Y_unitNo @"unitNo"//几单元
#define VERSIONTYPE @"4"//3是业主  4是物业
#define CrasLlogType @"1" //日志类型 崩溃日志
//获取UserDefault
#define SYSTEM_USERDEFAULTS [NSUserDefaults standardUserDefaults]


//获取短信验证码
#define SMSAPPKEY @"636cc8f10fb6"
#define SMSAPPSECRET @"c76ceb663235adb967f6a2a367e6c979"
#define ZONE @"86"

/**
 *  XMPP
 */
#define XMPP_HOST_ADDRESS @"120.24.74.231"//测试
//#define XMPP_HOST_ADDRESS @"120.25.232.198"//上线

#define XMPP_HOST_ADDROOMRESS  @"@iz9435byih4z"    //测试环境
//#define XMPP_HOST_ADDROOMRESS  @"@iz941z7oqaxz"    // 上线环境

#define XMPP_Host_PORT 5222

//---------------------------------------------------------------------------------------------------------------
//tag
#define InformationBadgeImageValueTag  1001
#define SendMessageImageValueTag  1002
#define SendMessageAudioTimeLabelValueTag  1003
#define SoundImageViewValueTag  1004
#define FaceViewValueTag  1005


//cache catalog
#define MessageImageCashe @"messageImageCache"
#define UserVcardCache @"userVcardCache"
#define TableDynamicImageCaches @"tableDynamicImageCaches"

//face
#define Face_Key    @"faceKey"
#define Face_Value  @"faceValue"

//发送图片，本地保存文件名
#define SendMessageImageCatalog @"sendMessageImageCatalog"
#define RecordingVoiceCatalog @"recordingVoiceCatalog"

//FMDB
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }


//数据库文件
//#define DATABASE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/UnisouthChat.sqlite3"]
#define USER_DB_FILE_NAME @"userdb.sqlite3"


//消息实例
#define System_Notification [NSNotificationCenter defaultCenter]

//我的收益地址
#define MY_EARNING_URL_STRING @"/payment/myBenefit.action?userId="


#define Y_SETTING_FILE  @"setting.plist" //设置声音/震动 文件名
#define Y_SOUND   @"y_sound_state"  //是否开启声音 (Y/N) 默认Y
#define Y_SHAKE   @"y_shake_state"  //是否开启震动 (Y/N) 默认Y
#define Y_CONTACT_FLAG @"y_reload_contact_falg" //新增或者删除班级后，赋值Y，进入联系人页面时，进行刷新显示数据


//消息中心
#define Notif_ReloadContacts @"ReloadContacts"
#define Notif_Login @"LoginRespond"
#define Notif_NetworkChanged @"NetworkChanged"
#define Notif_TelephoneToAddress @"NotificationTelephoneToAddress"
#define Notif_XMPP_NewMsg @"NotificationXMPPNewMsg"
#define Notif_XMPP_DisplayNewMsg  @"NotificationXMPPDisplayNewMsg"
#define NOtif_CurrentClass @"NotificationCurrentClass"
#define Notif_XMPP_CreateRoomSucess @"NotificationCreateRoomSuccess"
#define Notif_UploadFile_ReturnInfo @"NotifUploadFileReturnInfo"
#define Notif_UploadFile_ProcessInfo @"Notif_UploadFile_ProcessInfo"
#define Notif_FromBecomeActive_XMPP @"Notif_FromBecomeActive_XMPP"

#define WebServicesURL @"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx"
//文字描述
#define  Not_History_Data   @"数据已全部加载!"

//消息展示数目
#define maxDisplayingCount 15


//提示信息，页面停留时间
#define MakeToast_Time 4.0f

//RGB颜色转换（16进制->10进制）
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ShareDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//获取当前应用版本号
#define Y_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

