// const serviceUrl = 'https://mock.yonyoucloud.com/mock/3774/';
// const serviceUrl = 'http://192.168.0.110:3000/';
const serviceUrl = 'http://baixing.huangdongyang.cn/';
const serviceUrl1 = 'http://v.jspang.com:8088/baixing/';

const servicePath = {
  'getIndexData': serviceUrl + 'getIndex', // 商店首页信息
  'getAllCategoryInfo': serviceUrl + 'getAllCategoryInfo', // 所有分类信息
  'getCategoryGoods': serviceUrl + 'getGoodsListByCategoryId', // 获取分类商品
  'getGoodDetailById': serviceUrl + 'getGoodsDetailById', // 商品详情
  'searchGoods': serviceUrl + 'searchGoods', // 搜索商品
  'login': serviceUrl + 'login', // 登录
  'signin': serviceUrl + 'signin', // 注册
  'updateUserInfo': serviceUrl + 'updateUserInfo', // 修改用户信息
  'getUserOrder': serviceUrl + 'getUserOrder', // 获取用户订单
  'updateOrderStatus': serviceUrl + 'updateOrderStatus', // 修改订单状态
  'createOrder': serviceUrl + 'createOrder', // 创建订单
  'getAddress': serviceUrl + 'getAddress', // 获取地址列表
  'getDefaultAddress': serviceUrl + 'getDefaultAddress', // 获取用户默认地址
  'createAddress': serviceUrl + 'createAddress', // 创建地址
  'deleteAddress': serviceUrl + 'deleteAddress', // 删除地址
  'updateAddress': serviceUrl + 'updateAddress', // 更新地址

  'homePageContent': serviceUrl1 + 'wxmini/homePageContent', // 商店首页信息
  'homePageBelowContent':
      serviceUrl1 + 'wxmini/homePageBelowConten', // 商城首页热卖商品
  'getCategory': serviceUrl1 + 'wxmini/getCategory', //商品类别信息
  'getMallGoods': serviceUrl1 + 'wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailByI': serviceUrl1 + 'wxmini/getGoodDetailById' // 商品详情
};
