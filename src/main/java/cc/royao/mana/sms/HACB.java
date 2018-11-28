package cc.royao.mana.sms;

import org.apache.http.HttpHost;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.impl.conn.DefaultProxyRoutePlanner;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.apache.http.impl.nio.conn.PoolingNHttpClientConnectionManager;
import org.apache.http.impl.nio.reactor.DefaultConnectingIOReactor;
import org.apache.http.impl.nio.reactor.IOReactorConfig;
import org.apache.http.nio.conn.NoopIOSessionStrategy;
import org.apache.http.nio.conn.SchemeIOSessionStrategy;
import org.apache.http.nio.reactor.ConnectingIOReactor;
import org.apache.http.nio.reactor.IOReactorException;

/**
 * httpAsyncClient创建器
 * 
 * @author jk
 * @Description
 * @date 2016年1月30日
 */
public class HACB extends HttpAsyncClientBuilder {
	private boolean isSetPool = false; // 记录是否设置了连接池
	private boolean isNewSSL = false; // 记录是否设置了更新了ssl

	// 用于配置ssl
	private SSLs ssls = SSLs.getInstance();

	private HACB() {
	}

	public static HACB custom() {
		return new HACB();
	}

	/**
	 * 设置超时时间
	 * 
	 * @Description
	 * @author jk
	 * @param timeout
	 *            超时时间，单位-毫秒
	 * @return
	 * @return HACB
	 * @date 2016年1月30日
	 */
	public HACB timeout(int timeout) {
		// 配置请求的超时设置
		RequestConfig config = RequestConfig.custom()
				.setConnectionRequestTimeout(timeout)
				.setConnectTimeout(timeout).setSocketTimeout(timeout).build();
		return (HACB) this.setDefaultRequestConfig(config);
	}

	/**
	 * 设置ssl安全链接
	 * 
	 * @Description
	 * @author jk
	 * @return
	 * @throws HttpProcessException
	 * @return HACB
	 * @date 2016年1月30日
	 */
	public HACB ssl() throws HttpProcessException {
		if (isSetPool) {// 如果已经设置过线程池，那肯定也就是https链接了
			if (isNewSSL) {
				throw new HttpProcessException("请先设置ssl，后设置pool");
			}
			return this;
		}
		// Create a registry of custom connection session strategies for
		// supported
		// protocol schemes.
		Registry<SchemeIOSessionStrategy> sessionStrategyRegistry = RegistryBuilder
				.<SchemeIOSessionStrategy> create()
				.register("http", NoopIOSessionStrategy.INSTANCE)
				.register("https", ssls.getSSLIOSS()).build();
		// 配置io线程
		IOReactorConfig ioReactorConfig = IOReactorConfig.custom()
				.setIoThreadCount(Runtime.getRuntime().availableProcessors())
				.build();
		// 设置连接池大小
		ConnectingIOReactor ioReactor;
		try {
			ioReactor = new DefaultConnectingIOReactor(ioReactorConfig);
		} catch (IOReactorException e) {
			throw new HttpProcessException(e);
		}
		PoolingNHttpClientConnectionManager connManager = new PoolingNHttpClientConnectionManager(
				ioReactor, null, sessionStrategyRegistry, null);
		return (HACB) this.setConnectionManager(connManager);
	}

	/**
	 * 设置自定义sslcontext
	 * 
	 * @param keyStorePath
	 *            密钥库路径
	 * @return
	 * @throws HttpProcessException
	 */
	public HACB ssl(String keyStorePath) throws HttpProcessException {
		return ssl(keyStorePath, "nopassword");
	}

	/**
	 * 设置自定义sslcontext
	 * 
	 * @Description
	 * @author jk
	 * @param keyStorePath
	 *            密钥库路径
	 * @param keyStorepass
	 *            密钥库密码
	 * @return
	 * @throws HttpProcessException
	 * @return HACB
	 * @date 2016年1月30日
	 */
	public HACB ssl(String keyStorePath, String keyStorepass)
			throws HttpProcessException {
		this.ssls = SSLs.custom().customSSL(keyStorePath, keyStorepass);
		this.isNewSSL = true;
		return ssl();
	}

	/**
	 * 设置连接池（默认开启https）
	 * 
	 * @Description
	 * @author jk
	 * @param maxTotal
	 *            最大连接数
	 * @param defaultMaxPerRoute
	 *            每个路由默认连接数
	 * @return
	 * @throws HttpProcessException
	 * @return HACB
	 * @date 2016年1月30日
	 */
	public HACB pool(int maxTotal, int defaultMaxPerRoute)
			throws HttpProcessException {
		if (isSetPool) {// 如果已经设置过线程池，那肯定也就是https链接了
			return this;
		}
		// Create a registry of custom connection session strategies for
		// supported
		// protocol schemes.
		Registry<SchemeIOSessionStrategy> sessionStrategyRegistry = RegistryBuilder
				.<SchemeIOSessionStrategy> create()
				.register("http", NoopIOSessionStrategy.INSTANCE)
				.register("https", ssls.getSSLIOSS()).build();
		// 配置io线程
		IOReactorConfig ioReactorConfig = IOReactorConfig.custom()
				.setIoThreadCount(12).build();
		// 设置连接池大小
		ConnectingIOReactor ioReactor;
		try {
			ioReactor = new DefaultConnectingIOReactor(ioReactorConfig);
		} catch (IOReactorException e) {
			throw new HttpProcessException(e);
		}
		PoolingNHttpClientConnectionManager connManager = new PoolingNHttpClientConnectionManager(
				ioReactor, null, sessionStrategyRegistry, null);
		connManager.setMaxTotal(maxTotal);
		connManager.setDefaultMaxPerRoute(defaultMaxPerRoute);
		isSetPool = true;
		return (HACB) this.setConnectionManager(connManager);
	}

	/**
	 * 设置代理
	 * 
	 * @Description
	 * @author jk
	 * @param hostOrIP
	 * @param port
	 * @return
	 * @return HACB
	 * @date 2016年1月30日
	 */
	public HACB proxy(String hostOrIP, int port) {
		// 依次是代理地址，代理端口号，协议类型
		HttpHost proxy = new HttpHost(hostOrIP, port, "http");
		DefaultProxyRoutePlanner routePlanner = new DefaultProxyRoutePlanner(
				proxy);
		return (HACB) this.setRoutePlanner(routePlanner);
	}

}
