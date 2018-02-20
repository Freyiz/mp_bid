package sys;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class AspectTest {
	Logger lg = Logger.getLogger(AspectTest.class);

	@Pointcut("within(controller.*)")
	void f() {
	}

	@Before("f()")
	void f1() {
		lg.info("方法执行之前...");
	}

	@After("f()")
	void f2() {
		lg.info("方法执行之后...");
	}

	@AfterReturning(pointcut = "f()", returning = "result")
	void f3(Object result) {
		lg.info("方法执行之后，返回" + result + "...");
	}

	@AfterThrowing(pointcut = "f()", throwing = "e")
	void f4(Exception e) {
		lg.info("方法执行之后，异常" + e + "...");
	}

	@Around("within(controller.*)")
	Object f5(ProceedingJoinPoint jp) throws Throwable {
		Object o = null;
		lg.info("方法执行之前，环绕...");
		// try {
		o = jp.proceed();
		// lg.info("方法执行之后，环绕...");
		// } catch (Throwable e) {
		// lg.info("方法执行之后，环绕异常" + e + "...");
		// }
		lg.info("方法执行之后，环绕返回...");
		return o;
	}
}
