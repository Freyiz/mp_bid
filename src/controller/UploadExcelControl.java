package controller;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import pojo.Vehicle;
import service.VehicleService;
import util.ImportExcelUtil;

@Controller
@RequestMapping("/vehicle")
public class UploadExcelControl {
	@Autowired
	private VehicleService vehicleService;
	

	@RequestMapping(value = "/upload", method = { RequestMethod.POST })
	public ModelAndView uploadExcel(HttpServletRequest request) throws Exception {
		Connection conn = null;
		PreparedStatement pre = null;
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		System.out.println("---------------------");
		String message = "这个是要传递的数据";
		InputStream in = null;
		List<List<Object>> listob = null;
		List<Vehicle> list = null;
		MultipartFile file = multipartRequest.getFile("upfile");
		
		/*
		 * Iterator<String> it = multipartRequest.getFileNames(); while(it.hasNext()) {
		 * System.out.println(it.next()); }
		 */
		if (file.isEmpty()) {
			throw new Exception("文件不存在！");
		}
		in = file.getInputStream();
 		listob = new ImportExcelUtil().getCarListByExcel(in, file.getOriginalFilename(), 0);
		System.out.println(in);
		System.out.println(file.getOriginalFilename());
		System.out.println(listob.size());

		conn = getConnection();
		System.out.println("连接成功!");

//		testMethod(listob, conn, pre);
		
		boolean b =  testMethod2(listob);

		conn.close();
		
		ModelAndView mad = new ModelAndView("vehicle/uploadVehicle");
		String msg = b?"上传成功！":"上传失败！";
		
		mad.addObject("msg", msg);
		return mad;
	}

	private boolean testMethod2(List<List<Object>> list) throws Exception {
		boolean b = true;
//		List<Vehicle> v = new ArrayList<Vehicle>();
		for (int i = 0; i < list.size(); i++) {
			List<Object> lo = list.get(i);
			// System.out.println("实体"+Integer.valueOf((String) lo.get(0)));
			Vehicle ve = new Vehicle();
			// System.out.println((String) lo.get(0));
			// System.out.println((String) lo.get(6));
			// System.out.println((String) lo.get(8));
			// System.out.println(((String) lo.get(8)).getClass());
			// ve.setId_veh(Integer.valueOf((String) lo.get(0)));
			// ve.setBatch_num(String.valueOf(lo.get(1)));
			ve.setBatch_num(String.valueOf(lo.get(0)));
			ve.setLicense_num(String.valueOf(lo.get(1)));
			ve.setVeh_id_num(String.valueOf(lo.get(2)));
			ve.setEngine_num(String.valueOf(lo.get(3)));
			ve.setBrand(String.valueOf(lo.get(4)));
			ve.setBrand_model(String.valueOf(lo.get(5)));
			ve.setIntro(String.valueOf(lo.get(6)));
			// ve.setVeh_stamp(Date.valueOf((String) lo.get(8)));
			 ve.setVeh_stamp(Timestamp.valueOf((String) lo.get(7)));
			// ve.setVeh_stamp(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse((String)
			// lo.get(8)));
			// ve.setStart_price(Long.valueOf((String) lo.get(9)));
			// ve.setCurr_price(Long.valueOf((String) lo.get(10)));
			// ve.setExpir_bid_time(Date.valueOf((String) lo.get(11)));
			// ve.setExpir_bid_time(new SimpleDateFormat("yyyy/MM/dd
			// HH:mm:ss").parse((String) lo.get(11)));
			// ve.setVeh_state(String.valueOf(lo.get(12)));
			// new VehicleController().insertVehicle(ve);

//			v.add(ve);
			try {
				vehicleService.insertSelective(ve);
			} catch (Exception e) {
				b = false;
			}
		}
		return b;
	}

	private void testMethod(List<List<Object>> list, Connection conn, PreparedStatement pre) throws Exception {
		// TODO Auto-generated method stub
		List<Vehicle> v = new ArrayList<Vehicle>();
		for (int i = 0; i < list.size(); i++) {
			List<Object> lo = list.get(i);
			// System.out.println("实体"+Integer.valueOf((String) lo.get(0)));
			Vehicle ve = new Vehicle();
			// System.out.println((String) lo.get(0));
			// System.out.println((String) lo.get(6));
			// System.out.println((String) lo.get(8));
			// System.out.println(((String) lo.get(8)).getClass());
			// ve.setId_veh(Integer.valueOf((String) lo.get(0)));
			// ve.setBatch_num(String.valueOf(lo.get(1)));
			ve.setLicense_num(String.valueOf(lo.get(0)));
			ve.setVeh_id_num(String.valueOf(lo.get(1)));
			ve.setEngine_num(String.valueOf(lo.get(2)));
			ve.setBrand(String.valueOf(lo.get(3)));
			ve.setBrand_model(String.valueOf(lo.get(4)));
			ve.setIntro(String.valueOf(lo.get(5)));
			// ve.setVeh_stamp(Date.valueOf((String) lo.get(8)));
			// ve.setVeh_stamp(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse("2100/2/2
			// 22:22:22"));
			// ve.setVeh_stamp(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse((String)
			// lo.get(8)));
			// ve.setStart_price(Long.valueOf((String) lo.get(9)));
			// ve.setCurr_price(Long.valueOf((String) lo.get(10)));
			// ve.setExpir_bid_time(Date.valueOf((String) lo.get(11)));
			// ve.setExpir_bid_time(new SimpleDateFormat("yyyy/MM/dd
			// HH:mm:ss").parse((String) lo.get(11)));
			// ve.setVeh_state(String.valueOf(lo.get(12)));
			// new VehicleController().insertVehicle(ve);

			v.add(ve);

		}

		for (Vehicle veup : v) {
			try {
				System.out.println("-----插入数据-----");
				System.out.println(v.size());
				pre = conn.prepareStatement(
						"insert into MP_VEH (license_num,veh_id_num, engine_num, brand,brand_model, intro) "
								+ "values (?,?,?,?,?,?)");
				// pre.setInt(1, veup.getId_veh());
				// pre.setLong(2, veup.getBatch_num());
				pre.setString(1, veup.getLicense_num());
				pre.setString(2, veup.getVeh_id_num());
				pre.setString(3, veup.getEngine_num());
				pre.setString(4, veup.getBrand());
				pre.setString(5, veup.getBrand_model());
				pre.setString(6, veup.getIntro());
				// pre.setTimestamp(9, new Timestamp(veup.getVeh_stamp().getTime()));
				// pre.setLong(10, veup.getStart_price());
				// pre.setLong(11, veup.getCurr_price());
				// pre.setTimestamp(12, new Timestamp(veup.getExpir_bid_time().getTime()));
				// pre.setString(13, veup.getState());

				int count = pre.executeUpdate();
				System.out.println(count);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}

		pre.close();
	}

	private Connection getConnection() throws Exception {

		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("开始尝试连接数据库");
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:ORCL";
		String user = "scott";
		String password = "asd";
		Connection conn = DriverManager.getConnection(url, user, password);
		return conn;
	}

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="ajaxUpload.do",method={RequestMethod.GET,RequestMethod
	 * .POST}) public void ajaxUploadExcel(HttpServletRequest
	 * request,HttpServletResponse response) throws Exception {
	 * MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)
	 * request;
	 * 
	 * System.out.println("通过 jquery.form.js 提供的ajax方式上传文件！");
	 * 
	 * InputStream in =null; List<List<Object>> listob = null; MultipartFile file =
	 * multipartRequest.getFile("upfile"); if(file.isEmpty()){ throw new
	 * Exception("文件不存在！"); }
	 * 
	 * in = file.getInputStream(); listob = new
	 * ImportExcelUtil().getCarListByExcel(in,file.getOriginalFilename());
	 * 
	 * //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出 for (int i = 0; i < listob.size(); i++)
	 * { List<Object> lo = listob.get(i); Vehicle ve = new Vehicle();
	 * ve.setId_veh(Integer.valueOf((String) lo.get(1)));
	 * ve.setBatch_num(Long.valueOf((String) lo.get(2)));
	 * ve.setLicense_num(String.valueOf(lo.get(3)));
	 * ve.setVeh_id_num(String.valueOf(lo.get(4)));
	 * ve.setEngine_num(String.valueOf(lo.get(5)));
	 * ve.setBrand(String.valueOf(lo.get(6)));
	 * ve.setBrand_model(String.valueOf(lo.get(7))); ve.setIntro(lo.get(8));
	 * ve.setVeh_stamp(Date.valueOf((String) lo.get(9)));
	 * ve.setStart_price(Long.valueOf((String) lo.get(10)));
	 * ve.setCurr_price(Long.valueOf((String) lo.get(11)));
	 * ve.setExpir_bid_time(Date.valueOf((String) lo.get(12)));
	 * ve.setState(String.valueOf(lo.get(13))); System.out.println(
	 * ve.getId_veh()+"#"+ ve.getBatch_num()+"#"+ ve.getLicense_num()+"#"+
	 * ve.getVeh_id_num()+"#"+ ve.getEngine_num()+"#"+ ve.getBrand()+"#"+
	 * ve.getBrand_model()+"#"+ ve.getIntro()+"#"+ ve.getVeh_stamp()+"#"+
	 * ve.getStart_price()+"#"+ ve.getCurr_price()+"#"+ ve.getExpir_bid_time()+"#"+
	 * ve.getState() ); }
	 * 
	 * PrintWriter out = null; response.setCharacterEncoding("utf-8");
	 * //防止ajax接受到的中文信息乱码 out = response.getWriter(); out.print("文件导入成功！");
	 * out.flush(); out.close(); }
	 */
}