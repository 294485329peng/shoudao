package com.wp.project.util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.wp.project.message.AccessToken;
import com.wp.project.message.MediaId;
import com.wp.project.message.Menu;
import com.wp.project.message.WeiXinNewsMessage;

/**
 * 公众平台通用接口工具类
 * 
 */
public class WeiXinUtil {
	private static Logger log = LoggerFactory.getLogger(WeiXinUtil.class);
	// 获取access_token的接口地址（GET） 限200（次/天）
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?"
			+ "grant_type=client_credential&appid=APPID&secret=APPSECRET";
	// 菜单创建（POST） 限100（次/天）
	public static String menu_create_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
	// 新增永久图文素材
	public static String addForeverNewsMessage_url = "https://api.weixin.qq.com/cgi-bin/material/add_news?access_token=ACCESS_TOKEN";
	// 新增永久图片素材（不占用5000名额）
	public static String addImage_url = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=ACCESS_TOKEN&type=TYPE";
	// 新增其它类型永久素材
	public static String addMaterial_url = "https://api.weixin.qq.com/cgi-bin/material/add_material?access_token=ACCESS_TOKEN&type=TYPE";
	// 根据mediaID获取永久素材
	public static String getMaterial_url = "https://api.weixin.qq.com/cgi-bin/material/get_material?access_token=ACCESS_TOKEN";
	// 群发
	public static String sendMass_url = "https://api.weixin.qq.com/cgi-bin/message/mass/sendall?access_token=ACCESS_TOKEN";
	// 获取
	public static String getUser_url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
	// 删除永久素材
	public static String deleteMaterial_url = "https://api.weixin.qq.com/cgi-bin/material/del_material?access_token=ACCESS_TOKEN";
	// 修改永久图文素材
	public static String updateMaterial_url = "https://api.weixin.qq.com/cgi-bin/material/update_news?access_token=ACCESS_TOKEN";
	// 第三方平台token获取
	public static String getCompoment_access_token = "https://api.weixin.qq.com/cgi-bin/component/api_component_token";
	// 第三方平台获取预授权码
	public static String getPre_Auth_Code = "https://api.weixin.qq.com/cgi-bin/component/api_create_preauthcode?component_access_token=xxx";
	// 第三方平台根据授权码获取授权token和刷新token
	public static String getAuth_Token = "https://api.weixin.qq.com/cgi-bin/component/api_query_auth?component_access_token=xxxx";
	// 第三方平台刷新token
	public static String refreshAuth_Token = "https://api.weixin.qq.com/cgi-bin/component/api_authorizer_token?component_access_token=xxxxx";
	// 获取授权方的公众号帐号基本信息
	public static String getAuthGzhInfoUrl = "https://api.weixin.qq.com/cgi-bin/component/api_get_authorizer_info?component_access_token=xxxx";
	//客服接口-发消息
	public static String sendMsg="https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";
	//撤销自定义菜单
	public static String cancelMenu="https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";
	public static InputStream getInputStreamFromUrl(String urlStr)
			throws IOException {
		URL url = new URL(urlStr);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		InputStream inputStream = urlConn.getInputStream();
		return inputStream;
	}

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequest(String requestUrl,
			String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url
					.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			System.out.println("error");
			log.error("Weixin server connection timed out.");
		} catch (Exception e) {
			System.out.println("error1");
			log.error("https request error:{}", e);
		}
		return jsonObject;
	}

	public static JSONObject httpRequestCurlByInputStream(String requestUrl,
			String requestMethod, InputStream inputStreamNet) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url
					.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();
			/**
			 * 请求头
			 */
			httpUrlConn.setRequestProperty("Connection", "Keep-Alive");
			httpUrlConn.setRequestProperty("Charset", "UTF-8");
			String BOUNDARY = "----------" + System.currentTimeMillis();
			httpUrlConn.setRequestProperty("Content-Type",
					"multipart/form-data; boundary=" + BOUNDARY);
			StringBuilder sb = new StringBuilder();
			sb.append("--"); // 必须多两道线
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("Content-Disposition: form-data;name=\"media\";filename=\""
					+ "wpFile.jpg" + "\"\r\n");
			sb.append("Content-Type:application/octet-stream\r\n\r\n");
			byte[] head = sb.toString().getBytes("utf-8");
			// 获得输出流
			OutputStream out = new DataOutputStream(
					httpUrlConn.getOutputStream());
			// 输出表头
			out.write(head);
			DataInputStream in = new DataInputStream(inputStreamNet);
			int bytes = 0;
			byte[] bufferOut = new byte[1024];
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}

			in.close();
			byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
			out.write(foot);
			out.flush();
			out.close();
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			System.out.println("error");
			log.error("Weixin server connection timed out.");
		} catch (Exception e) {
			System.out.println("error1");
			log.error("https request error:{}", e);
		}
		return jsonObject;
	}

	public static JSONObject httpRequestCurl(String requestUrl,
			String requestMethod, String filePath) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		File file = new File(
				"C://wp//fileUpload//gh_82dd7c0576d5//image//20151222//20151222094415_878.jpg");
		if (!file.exists() || !file.isFile()) {
			return null;
		}
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url
					.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();
			/**
			 * 请求头
			 */
			httpUrlConn.setRequestProperty("Connection", "Keep-Alive");
			httpUrlConn.setRequestProperty("Charset", "UTF-8");
			String BOUNDARY = "----------" + System.currentTimeMillis();
			httpUrlConn.setRequestProperty("Content-Type",
					"multipart/form-data; boundary=" + BOUNDARY);
			StringBuilder sb = new StringBuilder();
			sb.append("--"); // 必须多两道线
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("Content-Disposition: form-data;name=\"media\";filename=\""
					+ file.getName() + "\"\r\n");
			System.out.println(file.getName());
			sb.append("Content-Type:application/octet-stream\r\n\r\n");
			System.out.println(sb.toString());
			byte[] head = sb.toString().getBytes("utf-8");
			// 获得输出流
			OutputStream out = new DataOutputStream(
					httpUrlConn.getOutputStream());
			// 输出表头
			out.write(head);
			DataInputStream in = new DataInputStream(new FileInputStream(file));
			int bytes = 0;
			byte[] bufferOut = new byte[1024];
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}

			in.close();
			byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
			out.write(foot);
			out.flush();
			out.close();
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			System.out.println("error");
			log.error("Weixin server connection timed out.");
		} catch (Exception e) {
			System.out.println("error1");
			log.error("https request error:{}", e);
		}
		return jsonObject;
	}

	/**
	 * 获取access_token
	 * 
	 * @param appid
	 *            凭证
	 * @param appsecret
	 *            密钥
	 * @return
	 */
	public static AccessToken getAccessToken(String appid, String appsecret) {
		AccessToken accessToken = null;
		String requestUrl = access_token_url.replace("APPID", appid).replace(
				"APPSECRET", appsecret);
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				accessToken = new AccessToken();
				accessToken.setToken(jsonObject.getString("access_token"));
				accessToken.setExpiresIn(jsonObject.getInt("expires_in"));
			} catch (JSONException e) {
				accessToken = null;
				// 获取token失败
				log.error("获取token失败 errcode:{} errmsg:{}",
						jsonObject.getInt("errcode"),
						jsonObject.getString("errmsg"));
			}
		}
		return accessToken;
	}

	/**
	 * 新增永久图文素材
	 * 
	 * @return
	 */
	public static String addForeverNewsMessage(WeiXinNewsMessage newsMessage,
			String accessToken) {
		String url = addForeverNewsMessage_url.replace("ACCESS_TOKEN",
				accessToken);
		Gson gson = new GsonBuilder().disableHtmlEscaping().create();
		// 调用接口上传图文消息
		JSONObject jsonObject = httpRequest(url, "POST",
				gson.toJson(newsMessage));
		if (null != jsonObject) {
			return jsonObject.getString("media_id");
		}
		return "";
	}

	/**
	 * 新增其他类型永久素材(本地)
	 */
	public static int addForeverMaterial(String picUrl, String accessToken) {
		int result = 0;
		String url = addMaterial_url.replace("ACCESS_TOKEN", accessToken)
				.replace("TYPE", "image");
		JSONObject jsonObject = httpRequestCurl(url, "POST", picUrl);
		if (null != jsonObject) {
			if (jsonObject.toString().contains("40007")) {
				return -1;
			}
		}
		return result;
	}

	/**
	 * 新增其他类型永久素材(网络)
	 * 
	 * @return
	 */
	public static List addForeverMaterial(InputStream inputStream,
			String materialType, String accessToken) {
		String url = WeiXinUtil.addMaterial_url.replace("ACCESS_TOKEN",
				accessToken).replace("TYPE", materialType);
		JSONObject jsonObject = httpRequestCurlByInputStream(url, "POST",
				inputStream);
		if (null != jsonObject) {
			System.out.println(jsonObject.toString());
			List<String> list = new ArrayList<>();
			list.add(jsonObject.getString("media_id"));
			list.add(jsonObject.getString("url"));
			return list;
		}
		return null;
	}

	/**
	 * 上传网络图片到微信
	 * 
	 * @return
	 */
	public static String addForeverImage(InputStream inputStream,
			String urlType, String accessToken) {
		String url = urlType.replace("ACCESS_TOKEN", accessToken).replace(
				"TYPE", "image");
		JSONObject jsonObject = httpRequestCurlByInputStream(url, "POST",
				inputStream);
		if (null != jsonObject) {
			return jsonObject.getString("url");
		}
		return "";
	}

	public static List getMarterialByMediaId(String mediaId, String accessToken) {
		JSONObject jsonObject = null;
		String url = getMaterial_url.replace("ACCESS_TOKEN", accessToken);
		MediaId mediaId2 = new MediaId();
		mediaId2.setMedia_id(mediaId);
		Gson gson = new Gson();
		jsonObject = httpRequest(url, "POST", gson.toJson(mediaId2));
		if (null != jsonObject) {
			List<String> urlList = new ArrayList<>();
			JSONArray jsonArray = jsonObject.getJSONArray("news_item");
			for (int i = 0; i < jsonArray.size(); i++) {
				urlList.add(jsonArray.getJSONObject(i).getString("url"));
			}
			return urlList;
		}
		return null;
	}

	/**
	 * 创建菜单
	 * 
	 * @param menu
	 *            菜单实例
	 * @param accessToken
	 *            有效的access_token
	 * @return 0表示成功，其他值表示失败
	 */
	public static int createMenu(String menuString, String accessToken) {
		// 拼装创建菜单的url
		String url = menu_create_url.replace("ACCESS_TOKEN", accessToken);
		System.out.println(menuString);
		// 调用接口创建菜单
		JSONObject jsonObject = httpRequest(url, "POST", menuString);
		String ur1l = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx9e04ac316f0f52d6&redirect_uri="
				+ "http://www.wxplatform/wp/TWeb/bs/home.html&response_type=code&scope=(snsapi_base)&state=666"
				+ "&component_appid=wxaa2727c6564bd038#wechat_redirect";
		if (null != jsonObject) {
			if (!"0".equals(jsonObject.getString("errcode"))) {
				System.out.println(jsonObject.getInt("errcode")+
						jsonObject.getString("errmsg"));
				return -1;
			} else {
				return 0;// 正确返回0
			}
		}
		return -1;
	}

	/**
	 * 群发
	 */
	public static int SendMass(String massString, String accessToken) {
		String url = sendMass_url.replace("ACCESS_TOKEN", accessToken);
		// 调用接口群发消息
		JSONObject jsonObject = httpRequest(url, "POST", massString);
		if (null != jsonObject) {
			if (!"0".equals(jsonObject.getString("errcode"))) {
				return -1;
			} else {
				return 0;// 正确返回0
			}
		}
		return -1;
	}

	/**
	 * 获取用户信息
	 */
	public static Map<String, String> getUserInfo(String openid, String gzhid,
			String accessToken) {
		String url = getUser_url.replace("ACCESS_TOKEN", accessToken).replace(
				"OPENID", openid);
		JSONObject jsonObject = httpRequest(url, "GET", null);
		if (null != jsonObject) {
			if (jsonObject.containsKey("errcode")) {
				return null;
			} else {
				Map<String, String> map = new HashMap<String, String>();
				map.put("OPEN_ID", jsonObject.getString("openid"));
				map.put("GZH_ID", gzhid);
				map.put("NICKNAME", jsonObject.getString("nickname"));
				map.put("SEX", jsonObject.getString("sex"));
				map.put("CITY", jsonObject.getString("city"));
				map.put("COUNTRY", jsonObject.getString("country"));
				map.put("PROVINCE", jsonObject.getString("province"));
				map.put("LANGUAGE", jsonObject.getString("language"));
				map.put("HEADIMGURL", jsonObject.getString("headimgurl"));
				map.put("SUBSCRIBE_TIME",
						jsonObject.getString("subscribe_time"));
				// map.put("UNION_ID",jsonObject.getString("union_id"));
				map.put("REMARK", jsonObject.getString("remark"));
				map.put("GROUP_ID", jsonObject.getString("groupid"));
				map.put("SUBSCRIBE", jsonObject.getString("subscribe"));
				return map;// 正确返回数据
			}
		}
		return null;
	}

	/**
	 * 更新永久图文素材
	 */
	public static int updateMaterial(WeiXinNewsMessage newsMessage,
			String accessToken) {
		String url = updateMaterial_url.replace("ACCESS_TOKEN", accessToken);
		Gson gson = new GsonBuilder().disableHtmlEscaping().create();
		String requeString=gson.toJson(newsMessage);
		requeString=requeString.replace("ABCarticleCBA","articles");
		JSONObject jsonObject = httpRequest(url, "POST",
				requeString);
		if (!"0".equals(jsonObject.getString("errcode"))) {
			System.out.println(jsonObject.getString("errcode")+jsonObject.getString("errmsg"));
			return -1;
		} else {
			return 0;// 正确返回0
		}
	}

	/**
	 * 删除永久素材
	 */
	public static int deleteMaterial(String mediaId, String accessToken) {
		String url = deleteMaterial_url.replace("ACCESS_TOKEN", accessToken);
		MediaId mediaId2 = new MediaId();
		mediaId2.setMedia_id(mediaId);
		Gson gson = new Gson();
		JSONObject jsonObject = httpRequest(url, "POST", gson.toJson(mediaId2));
		if (null != jsonObject) {
			if (!"0".equals(jsonObject.getString("errcode"))) {
				return -1;
			} else {
				return 0;// 正确返回0
			}
		}
		return -1;
	}

	// 获取第三方平台accesstoken
	public static String getCAT(String request) {
		JSONObject jsonObject = httpRequest(getCompoment_access_token, "POST",
				request);
		if (null != jsonObject) {
			if (jsonObject.containsKey("errcode")) {
				return "";
			} else {
				return jsonObject.getString("component_access_token");// 正确返回0
			}
		}
		return "";
	}

	// 获取预授权码（10分钟有效）
	public static String getPAC(String compomentAT, String request) {
		String url = getPre_Auth_Code.replace("xxx", compomentAT);
		JSONObject jsonObject = httpRequest(url, "POST", request);
		if (null != jsonObject) {
			if (jsonObject.containsKey("errcode")) {
				return "";
			} else {
				return jsonObject.getString("pre_auth_code");
			}
		}
		return "";
	}

	// 获取授权token
	public static JSONObject getAuthToken(String compomentAT, String request) {
		String url = getAuth_Token.replace("xxxx", compomentAT);
		JSONObject jsonObject = httpRequest(url, "POST", request);
		if (null != jsonObject) {
			if (jsonObject.containsKey("errcode")) {
				return null;
			} else {
				return jsonObject;
			}
		}
		return null;
	}

	// 刷新授权token
	public static JSONObject refreshAuthToken(String compomentAT, String request) {
		String url = refreshAuth_Token.replace("xxxxx", compomentAT);
		JSONObject jsonObject = httpRequest(url, "POST", request);
		if (null != jsonObject) {
			if (jsonObject.containsKey("errcode")) {
				return null;
			} else {
				return jsonObject;
			}
		}
		return null;
	}

	// 获取用户信息
	public static JSONObject getAuthGzhInfo(String compomentAT, String request) {
		String url = getAuthGzhInfoUrl.replace("xxxx", compomentAT);
		JSONObject jsonObject = httpRequest(url, "POST", request);
		if (null != jsonObject) {
			if (jsonObject.containsKey("errcode")) {
				return null;
			} else {
				return jsonObject;
			}
		}
		return null;
	}
	//发送客服消息
	public static int SendMsg(String msg, String accessToken) {
		String url = sendMsg.replace("ACCESS_TOKEN", accessToken);
		// 调用接口群发消息
		JSONObject jsonObject = httpRequest(url, "POST",msg);
		if (null != jsonObject) {
			if (!"0".equals(jsonObject.getString("errcode"))) {
				return -1;
			} else {
				return 0;// 正确返回0
			}
		}
		return -1;
	}
	//撤销自定义菜单
	public static int cancelMenu(String accessToken) {
		String url = cancelMenu.replace("ACCESS_TOKEN", accessToken);
		JSONObject jsonObject = httpRequest(url, "GET", null);
		if (null != jsonObject) {
			if (!"0".equals(jsonObject.getString("errcode"))) {
				return -1;
			} else {
				return 0;// 正确返回0
			}
		}
		return -1;
	}
}