package util;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.StringUtils;

import pojo.Vehicle;

public class ImportExcelUtil {
	private final static String excel2003 =".xls";  
    private final static String excel2007 =".xlsx";   
    
    public List<List<Object>> getCarListByExcel(InputStream in,String fileName,int sheetnum) throws Exception{
		List<List<Object>> list = null;
		
		Workbook work = this.getWorkbook(in,fileName);
    	if(null == work) {
    		throw new Exception("Excel工作簿为空!");
    	}
    	Sheet sheet = null;
    	Row row = null;
    	Cell cell = null;
    	
    	list = new ArrayList<List<Object>>();
    	
    	//遍历所有的sheet
    	
//    		System.out.println("所有表的数量"+work.getNumberOfSheets());
			sheet = work.getSheetAt(sheetnum);
			/*if(sheet==null){
				continue;
			}*/
			
			//遍历当前sheet的所有行
			for (int j = sheet.getFirstRowNum(); j <= sheet.getLastRowNum(); j++) {
//				System.out.println("所有行的数量"+sheet.getPhysicalNumberOfRows());
//				System.out.println("第一行number"+sheet.getFirstRowNum());
//				System.out.println("最后一行的number"+sheet.getLastRowNum());
				row = sheet.getRow(j);
//				System.out.println(StringUtils.isEmpty(row));
//				System.out.println("j的值为:"+j+"-----------------------");
				System.out.println(row.getFirstCellNum());
				if(row==null || 0==j) {
					continue;
				}
				
				//遍历当前行的所有列
				List<Object> li = new ArrayList<Object>();
				Vehicle v = new Vehicle();
				for (int k = 1; k < row.getLastCellNum(); k++) {
					cell = row.getCell(k);
					if (cell==null) {
						continue;
					}
					Object o =this.getCellvalue(cell);
					
					if (o==null) {
						break;
					}
//					System.out.println("当前为第"+(k+1)+"列");
//					System.out.println("第"+(j+1)+"行的第一列的number"+row.getFirstCellNum());
//					System.out.println("第"+(j+1)+"行的最后一列number"+row.getLastCellNum());
					
//					cell.setCellType(CellType.STRING);
					System.out.println(k+"----"+this.getCellvalue(cell));
					
					li.add(o);
				}
				list.add(li);
					
			}
		
    	work.close();
		return list;
    }

	public Workbook getWorkbook(InputStream in, String fileName) throws Exception {
		Workbook wb = null;
		String fileType = fileName.substring(fileName.lastIndexOf("."));
		if(excel2003.equals(fileType)){  
            wb = new HSSFWorkbook(in);  //2003-  
        }else if(excel2007.equals(fileType)){  
            wb = new XSSFWorkbook(in);  //2007+  
        }else{  
            throw new Exception("解析的文件格式有误！");  
        }  
        return wb; 
		
	}
	
	@SuppressWarnings("deprecation")
	public Object getCellvalue(Cell cell) {
		Object value = null;
		DecimalFormat df = new DecimalFormat("0");  //格式化number String字符  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  //日期格式化  
        DecimalFormat df2 = new DecimalFormat("0");  //格式化数字 
        switch(cell.getCellType()) {
        case Cell.CELL_TYPE_STRING:
        	value = cell.getRichStringCellValue().getString();
        	break;
        case Cell.CELL_TYPE_NUMERIC:
        	if(cell.toString().contains("-") && checkDate(cell.toString())){
                String ans = "";
                try {
                    ans = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue());
                } catch (Exception e) {
                    ans = cell.toString();
                }
                value = ans;
                break;
            }

            
        	
        	if("General".equals(cell.getCellStyle().getDataFormatString())){  
                value = df.format(cell.getNumericCellValue());  
            }else if("yyyy-MM-dd HH:mm:ss".equals(cell.getCellStyle().getDataFormatString())){  
                value = sdf.format(cell.getDateCellValue());  
            }else{  
                value = df2.format(cell.getNumericCellValue());  
            }
        	break;
        case Cell.CELL_TYPE_BOOLEAN:
        	value = cell.getBooleanCellValue();
        	break;
        case Cell.CELL_TYPE_BLANK:
        	value = "";
        	break;
        default:
        		break;
        }
		return value;
	}
	
	
	
	private static boolean checkDate(String str){
        String[] dataArr =str.split("-");
        try {
            if(dataArr.length == 3){
                int x = Integer.parseInt(dataArr[0]);
                String y =  dataArr[1];
                int z = Integer.parseInt(dataArr[2]);
                if(x>0 && x<32 && z>0 && z< 10000 && y.endsWith("月")){
                    return true;
                }
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }
}