package controller;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pojo.Vehicle;
import service.VehicleService;

@Controller
public class ExportExcelController {
	@Autowired
	private VehicleService vehicleService;
	
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/export", method = { RequestMethod.GET })
	public void exportExcel(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		/*Connection conn = null;
		PreparedStatement pre = null;
		ResultSet rs = null;*/
		OutputStream os = null;
		List<Vehicle> list = null;
		Vehicle ve = new Vehicle();
		String batch_num = req.getParameter("batch_num");
		System.out.println(batch_num);
		ve.setBatch_num(batch_num);
		list = vehicleService.selectVehicle(ve, "precise", 0, 100);
		XSSFWorkbook xb = new XSSFWorkbook();
		
		XSSFCellStyle cellstyle = xb.createCellStyle();
		XSSFDataFormat df = xb.createDataFormat();
		
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("application/x-download");
		String filename = URLEncoder.encode("第"+batch_num+"批车辆信息.xlsx", "utf-8");
		resp.addHeader("Content-Disposition", "attachment; filename="+filename); 
		XSSFSheet sheet = xb.createSheet("第"+batch_num+"批");
		XSSFRow row = sheet.createRow(0);
		XSSFCell cell = null;
		row.createCell(0).setCellValue("ID_VEH");
		row.createCell(1).setCellValue("BATCH_NUM");
		row.createCell(2).setCellValue("LICENSE_NUM");
		row.createCell(3).setCellValue("VEH_ID_NUM");
		row.createCell(4).setCellValue("ENGINE_NUM");
		row.createCell(5).setCellValue("BRAND");
		row.createCell(6).setCellValue("BRAND_MODEL");
		row.createCell(7).setCellValue("INTRO");
		row.createCell(8).setCellValue("VEH_STAMP");
		row.createCell(9).setCellValue("START_BID_TIME");
		row.createCell(10).setCellValue("EXPIR_BID_TIME");
		row.createCell(11).setCellValue("EXPIR_PAY_TIME");
		row.createCell(12).setCellValue("START_PRICE");
		row.createCell(13).setCellValue("CURR_PRICE");
		row.createCell(14).setCellValue("REMARK");
		row.createCell(15).setCellValue("VEH_STATE");
		int count = 1;
		for (Vehicle v : list) {
			row = sheet.createRow(count);
			for (int i = 0; i < 16; i++) {
				cell = row.createCell(i);
				switch(i){
				case 0:
					cell.setCellValue(v.getId_veh());
					cell.setCellType(Cell.CELL_TYPE_NUMERIC);
					break;
				case 1:
					cell.setCellValue(v.getBatch_num());
					break;
				case 2:
					cell.setCellValue(v.getLicense_num());
					break;
				case 3:
					cell.setCellValue(v.getVeh_id_num());
					break;
				case 4:
					cell.setCellValue(v.getEngine_num());
					break;
				case 5:
					cell.setCellValue(v.getBrand());
					break;
				case 6:
					cell.setCellValue(v.getBatch_num());
					break;
				case 7:
					cell.setCellValue(v.getIntro());
					break;
				case 8:
					cellstyle.setDataFormat(df.getFormat("yyyy-MM-dd HH:mm:ss"));
					cell.setCellValue(v.getVeh_stamp());
					cell.setCellStyle(cellstyle);
					break;
				case 9:
					cellstyle.setDataFormat(df.getFormat("yyyy-MM-dd HH:mm:ss"));
					cell.setCellValue(v.getStart_bid_time());
					cell.setCellStyle(cellstyle);
					break;
				case 10:
					cellstyle.setDataFormat(df.getFormat("yyyy-MM-dd HH:mm:ss"));
					cell.setCellValue(v.getExpir_bid_time());
					cell.setCellStyle(cellstyle);
					break;
				case 11:
					cellstyle.setDataFormat(df.getFormat("yyyy-MM-dd HH:mm:ss"));
					cell.setCellValue(v.getExpir_pay_time());
					cell.setCellStyle(cellstyle);
					break;
				case 12:
					if(v.getStart_price()==null) {
						break;
					}
					cell.setCellValue(v.getStart_price());
					cell.setCellType(Cell.CELL_TYPE_NUMERIC);
					break;
				case 13:
					if(v.getCurr_price()==null) {
						break;
					}
					cell.setCellValue(v.getCurr_price());
					cell.setCellType(Cell.CELL_TYPE_NUMERIC);
					break;
				case 14:
					cell.setCellValue(v.getRemark());
					break;
				case 15:
					if(v.getVeh_state()==null) {
						break;
					}
					cell.setCellValue(v.getVeh_state());
					cell.setCellType(Cell.CELL_TYPE_NUMERIC);
					break;	
				default:
					break;
				}
				
			}
			count++;
		}
		for (int i = 0; i < row.getPhysicalNumberOfCells(); i++) {
			sheet.setColumnWidth(i, 255*20);
		}
		os = resp.getOutputStream();
		xb.write(os);
		os.flush();
		os.close();
		xb.close();
		
		/*conn = getConnection();
		System.out.println("连接成功");
		try {
			pre = (PreparedStatement) conn.prepareStatement("select * from emp");
			rs = pre.executeQuery();
			
			XSSFWorkbook xb = new XSSFWorkbook();
			req.setCharacterEncoding("UTF-8");
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("application/x-download");
			String filename = "emp名单.xlsx";
			filename = URLEncoder.encode(filename, "UTF-8");
			resp.addHeader("Content-Disposition", "attachment; filename="+filename);
			XSSFSheet sheet = xb.createSheet("第一批");
			XSSFRow row = sheet.createRow(0);
			
			row.createCell(0).setCellValue("empno");
			row.createCell(1).setCellValue("ename");
			row.createCell(2).setCellValue("job");
			row.createCell(3).setCellValue("mgr");
			row.createCell(4).setCellValue("hiredate");
			row.createCell(5).setCellValue("sal");
			row.createCell(6).setCellValue("comm");
			row.createCell(7).setCellValue("deptno");
			int count = 1;
			while(rs.next()) {
				row = sheet.createRow(count);
				for (int i=0;i<8;i++) {
					row.createCell(i).setCellValue(rs.getString(i+1));
				}
				count++;
			}
			for (int i = 0; i < row.getPhysicalNumberOfCells(); i++) {
				sheet.setColumnWidth(i, 255*20);
			}
			os = resp.getOutputStream();
			xb.write(os);
			
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {
				if(os != null) {
					os.flush();
					os.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}*/
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
}
