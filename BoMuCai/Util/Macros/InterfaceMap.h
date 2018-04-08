//
//  InterfaceMap.h
//  HangZhouSchool
//
//  Created by admin on 16/1/31.
//  Copyright © 2016年 步晓虎. All rights reserved.
//

#ifndef InterfaceMap_h
#define InterfaceMap_h

//#define SocketUrl(userId) [NSString stringWithFormat:@"ws://116.231.119.53:8092/ggtRest/orderConnect/Owner/%@",userId]

//00800005  网站介绍
//00800006  公司介绍
//00800007  法律声明

#define BaseRequestHost @"http://47.92.129.93:8091"

//#define BaseRequestHost @"http://a7842752.imwork.net:8092"

//获取验证码
#define KURL_VerifyCodeRequest @"/ECPartyRest/rest/AppUserRest/getVerifyCode"

//注册
#define KURL_Regist @"/ECPartyRest/rest/AppUserRest/register"

//登录
#define KURL_Login @"/ECPartyRest/rest/AppUserRest/login"

#define KURL_ThirdLogin @"/ECPartyRest/rest/AppUserRest/thirdLogin"

#define KURL_ThirdBind @"/ECPartyRest/rest/AppUserRest/bindUser"

//忘记密码
#define KURL_ForgerPassword @"/ECPartyRest/rest/AppUserRest/forgetPasswd"

//修改密码
#define KURL_ChangePassword @"/ECPartyRest/rest/AppUserRest/changePasswd"

//首页轮播图
#define KURL_TrunRound @"/ECPartyRest/rest/MainRest/getTurnRoundImage"

//总后台活动
#define KURL_HomeActivity @"/ECPartyRest/rest/MainRest/getActivity"

//活动详情
#define KURL_ActivityDetail @"/ECPartyRest/rest/MainRest/getActivityDetail"

//活动时间
#define KURL_ActivityDetailTime @"/ECPartyRest/rest/MainRest/getActivityDetailTime"

//热门搜索
#define KURL_HotSearch @"/ECPartyRest/rest/SearchRest/getHotSearch"

//商品搜索
#define KURL_GoodsSearch @"/ECPartyRest/rest/SearchRest/findByMdse"

//商品分类查询
#define KURL_GoodsTypeSearch @"/ECPartyRest/rest/MdseTypeRest/getMdseByType"

//商品详情
#define KURL_GoodsDetail @"/ECPartyRest/mdse/getMdseDetail"

//店铺搜索
#define KURL_ShopSearch @"/ECPartyRest/rest/SearchRest/findByShop"

//店铺详情
#define KURL_ShopDetail @"/ECPartyRest/rest/ShopRest/getShopDetail"

//获取优惠券
#define KURL_UserTakeCoupon @"/ECPartyRest/rest/CouponRest/getCouponUser"

//收藏关注点赞
#define KURL_Collect @"/ECPartyRest/rest/CollectionRest/addCollection"

//我的收藏关注点赞
#define KURL_MyCollectList @"/ECPartyRest/rest/CollectionRest/getMyCollection"

//取消收藏关注点赞
#define KURL_DelCollect @"/ECPartyRest/rest/CollectionRest/delCollection"

//一级分类
#define KURL_TypeLevelOne @"/ECPartyRest/rest/MdseTypeRest/getOneType"

//其他分类
#define KURL_TypeOther @"/ECPartyRest/rest/MdseTypeRest/getOtherType"

//常见问题列表
#define KURL_NormalQuestionList @"/ECPartyRest/rest/CommProblemRest/getList"

//常见问题答案
#define KURL_NormalQuestionAnswer @"/ECPartyRest/rest/CommProblemRest/getAnswer"

//关于我们
#define KURL_AboutUsDetail @"/ECPartyRest/rest/AboutUsRest/getInfoMain"

//我的优惠券
#define KURL_MyCouponList @"/ECPartyRest/rest/AboutUsRest/getMyCoupon"

//账户信息
#define KURL_AccountInfo @"/ECPartyRest/rest/UserRest/getUserInfo"

//账户头像修改
#define KURL_UploadUserImage @"/ECPartyRest/rest/UserRest/uploadUserPhoto"

//账户信息修改
#define KURL_EditUserInfo @"/ECPartyRest/rest/UserRest/updateUserInfo"

//浏览记录
#define KURL_BrowsingHistory @"/ECPartyRest/mdse/getMdseHistory"

//地址管理
#define KURL_AddressManager @"/ECPartyRest/rest/AddressRest/getAddressList"

//新建地址
#define KURL_AddressCreat @"/ECPartyRest/rest/AddressRest/createAddress"

//获取默认地址
#define KURL_AddressDefaultGet @"/ECPartyRest/rest/AddressRest/getDefaultAddress"

//设置默认地址
#define KURL_AddressSetDefault @"/ECPartyRest/rest/AddressRest/setDefault"

//修改默认地址
#define KURL_AddressEdit @"/ECPartyRest/rest/AddressRest/updateAddress"

//地址删除
#define KURL_AddressDel @"/ECPartyRest/rest/AddressRest/deleteAddress"

//招标大厅列表
#define KURL_TenderHallSearch @"/ECPartyRest/rest/TenderRest/getTenders"

//招标大厅分类
#define KURL_TenderHallType @"/ECPartyRest/rest/TenderRest/getTenderTypes"

//招标详情
#define KURL_TenderHallDetail @"/ECPartyRest/rest/TenderRest/getTenderContent"

//加入购物车
#define KURL_CartAddProduct @"/ECPartyRest/shoppingCart/addCart"

//我的购物车
#define KURL_MyCartList @"/ECPartyRest/shoppingCart/myCart"

//购物车商品数量改变
#define KURL_CartGoodsNumChange @"/ECPartyRest/shoppingCart/changePurchaseQuantity"

//购物车单件商品删除
#define KURL_CartGoodsDel @"/ECPartyRest/shoppingCart/delete"

//获取商户头像和名称
#define KUR_ShopNameHead @"/ECPartyRest/mdse/getShopInformation"

//提交订单
#define KURL_OrderSubmit @"/ECPartyRest/order/confirmOrder"

//优惠券获取
#define KURL_CouponCanUseList @"/ECPartyRest/order/getCouponArray"

//删除优惠券
#define KURL_DelCoupon @"/ECPartyRest/rest/CouponRest/delCouponUser"

//订单详情
#define KURL_OrderList @"/ECPartyRest/rest/OrderShopRest/getAllOrder"

//订单详情
#define KURL_OrderDetail @"/ECPartyRest/rest/OrderShopRest/getOrderDetail"

//评价订单
#define KURL_OrderComment @"/ECPartyRest/rest/MdseAssessRest/setAssess"

//全部评价
#define KURL_GoodsAllComment @"/ECPartyRest/rest/MdseAssessRest/getAllAssess"

//退款列表
#define KURL_BackOrderList @"/ECPartyRest/rest/OrderShopRest/getMyOrderRejected"

//取消删除订单
#define KURL_CancelDelOrder @"/ECPartyRest/rest/OrderShopRest/cancelOrder"

//退款详情
#define KURL_BackOrderDetail @"/ECPartyRest/rest/OrderShopRest/OrderRejectedDetail"

//个人信息详情
#define KURL_UserInfo @"/ECPartyRest/rest/UserRest/getUserLevel"

//提醒发货
#define KURL_RemindSend @"/ECPartyRest/rest/OrderShopRest/remindOrderSend"

//确认收货
#define KURL_ConfirmRev @"/ECPartyRest/rest/OrderShopRest/confirmRev"

//生成支付订单
#define KURL_PayOrderCreat @"/ECPartyRest/unionpay/addSign"

//启动页图片
#define KURL_StartLoadImage @"/ECPartyRest/rest/AboutUsRest/getStartUp"

//意见反馈
#define KURL_FeedBack @"/ECPartyRest/problemFeedback/loggedIn"


#endif /* InterfaceMap_h */
