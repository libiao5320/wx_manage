package cc.royao.utils;

public class AdminConfig {

	//center url
	public static String httpUrl = Config.get("http_url");
	
	//event图片存放路劲
	public static String eventUploadPath = Config.get("eventUploadPath");
	
	//goods图片存放路劲
	public static String goodsUploadPath = Config.get("goodsUploadPath");
	
	//store图片存放路劲
	public static String storeUploadPath = Config.get("storeUploadPath");
	
	//techie图片存放路劲
	public static String techieUploadPath = Config.get("techieUploadPath");
	
	//public图片存放路劲
	public static String publicUploadPath = Config.get("publicUploadPath");
	
	//请求商家图片路劲
	public static String storeImgUrl = Config.get("STORE_IMG_URL");
	
	//请求商品图片路劲
	public static String goodsImgUrl = Config.get("GOODS_IMG_URL");
	
	//顶级域名，用于B端图片上传
	public static String bHostUrl = Config.get("B_HOST_URL");
	
	//recharge card url
	public static String rechargeCardUrl = Config.get("RECHARGE_CARD_URL");
}
