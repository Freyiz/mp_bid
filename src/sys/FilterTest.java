package sys;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.log4j.Logger;

public class FilterTest implements Filter {
	Logger lg = Logger.getLogger(FilterTest.class);

	@Override
	public void destroy() {
		lg.info("服务器关闭：销毁filter...");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		lg.info("进入过滤器...");
		chain.doFilter(request, response);
		lg.info("完成过滤...");
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		lg.info("服务器启动:初始化filter...");
	}
}
