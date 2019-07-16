///接口url
class UrlPath{
static const orderInfoPath="/app/order/";//{orderId}/info";//根据orderId获取订单详情∂

static const orderConfirmPath="/app/order/confirm";//午餐/晚餐确认∂

static const drinkConfirmPath="/app/order/drinks/confirm";//酒水分类下单

static const orderNeedServicePath="/app/order/needService/confirm";//点需要服务接口

static const orderDetailPath="/app/order/queryOrderDetail";//根据orderId/roundId分页查询订单详情列表

static const orderRoundConfirmPath="/app/order/round/confirm";//每轮点餐确认下单,

static const productListPath="/app/product/queryListByPage";//分页查询菜品列表,

static const getCategoryByPidPath="/app/getCategorysByPid";//获取菜单分类

static const signInPath="/app/signin";//App登录接口
}