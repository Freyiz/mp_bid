package sys;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;

import org.apache.log4j.Logger;

public class ListenerTest implements ServletRequestListener{
	Logger lg = Logger.getLogger(ListenerTest.class);

	@Override
	public void requestDestroyed(ServletRequestEvent sre) {
		lg.info("请求结束...");
	}

	@Override
	public void requestInitialized(ServletRequestEvent sre) {
		lg.info("请求开始...");
	}
}
