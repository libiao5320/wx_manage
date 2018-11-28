package cc.royao.mana.ctrl;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cc.royao.utils.AdminConfig;

import com.alibaba.fastjson.JSONArray;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by libia on 2016/2/27.
 */


@Controller
@RequestMapping("/imgView")
public class ImgViewCtrl  {

	Logger logger = Logger.getLogger(this.getClass());
	
    @RequestMapping(value = "/readGoodImage.htm")
    public void readGoodImage(HttpServletRequest request, HttpServletResponse response){
        String imagePath = request.getSession().getServletContext().getRealPath("/")+ AdminConfig.goodsUploadPath+request.getParameter("imagePath");
        try{
            File file = new File(imagePath);
            if (file.exists()) {
                DataOutputStream temps = new DataOutputStream(response
                        .getOutputStream());

                DataInputStream in = new DataInputStream(
                        new FileInputStream(imagePath));
                byte[] b = new byte[2048];
                while ((in.read(b)) != -1) {
                    temps.write(b);

                }
                temps.flush();
                in.close();
                temps.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/readStoreImage.htm")
    public void readStoreImage(HttpServletRequest request, HttpServletResponse response){
        String imagePath = request.getSession().getServletContext().getRealPath("/")+ AdminConfig.storeUploadPath+request.getParameter("imagePath");
        try{
            File file = new File(imagePath);
            if (file.exists()) {
                DataOutputStream temps = new DataOutputStream(response
                        .getOutputStream());

                DataInputStream in = new DataInputStream(
                        new FileInputStream(imagePath));
                byte[] b = new byte[2048];
                while ((in.read(b)) != -1) {
                    temps.write(b);

                }
                temps.flush();
                in.close();
                temps.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/readTechieImage.htm")
    public void readTechieImage(HttpServletRequest request, HttpServletResponse response){
        String imagePath = request.getSession().getServletContext().getRealPath("/")+ AdminConfig.techieUploadPath+request.getParameter("imagePath");
        try{
            File file = new File(imagePath);
            if (file.exists()) {
                DataOutputStream temps = new DataOutputStream(response
                        .getOutputStream());

                DataInputStream in = new DataInputStream(
                        new FileInputStream(imagePath));
                byte[] b = new byte[2048];
                while ((in.read(b)) != -1) {
                    temps.write(b);

                }
                temps.flush();
                in.close();
                temps.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @RequestMapping(value = "/readPubImage.htm")
    public void readPubImage(HttpServletRequest request, HttpServletResponse response){
        String imagePath = request.getSession().getServletContext().getRealPath("/")+ AdminConfig.publicUploadPath+request.getParameter("imagePath");
        try{
            File file = new File(imagePath);
            if (file.exists()) {
                DataOutputStream temps = new DataOutputStream(response
                        .getOutputStream());

                DataInputStream in = new DataInputStream(
                        new FileInputStream(imagePath));
                byte[] b = new byte[2048];
                while ((in.read(b)) != -1) {
                    temps.write(b);

                }
                temps.flush();
                in.close();
                temps.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 
     * @Description: B端Logo图片
     * @param @param request
     * @param @param response   
     * @return void  
     * @throws
     * @author Liu Pinghui
     * @date 2016年3月8日
     */
    @ResponseBody
    @RequestMapping(value = "/bStoreLogoImage.htm")
    public String bStoreLogoImage(HttpServletRequest request, HttpServletResponse response){
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String fileName = "";
		String uploadPath = AdminConfig.storeUploadPath;
		String path = request.getSession().getServletContext().getRealPath("/")+uploadPath;
		File uploadPathFile = new File(path);
		
		if (!uploadPathFile.exists()) {
		   uploadPathFile.mkdir();
		}
		List<Map> list = new ArrayList<Map>();
		List<MultipartFile> files = multipartRequest.getFiles("storeLabelFile");
		if(files.size() == 0){
			files = multipartRequest.getFiles("wangEditorH5File");
		}
		for(int i=0;i<files.size();i++){
			MultipartFile mulfile = files.get(i);
			fileName = mulfile.getOriginalFilename();
			fileName = handlerFileName(fileName);
			File file = new File(path + fileName);
			
			try {
				mulfile.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("imagePath", fileName);
			map.put("url", AdminConfig.storeImgUrl);
			map.put("html", "<script>document.domain = '"+AdminConfig.bHostUrl+"';</script>");
			list.add(map);
		}
		multipartRequest = null;
		
		return JSONArray.toJSONString(list);
    }
    
    /**
     * 
     * @Description: B端goods图片
     * @param @param request
     * @param @param response   
     * @return void  
     * @throws
     * @author Liu Pinghui
     * @date 2016年3月8日
     */
    @ResponseBody
    @RequestMapping(value = "/bGoodsImage.htm")
    public String bGoodsImage(HttpServletRequest request, HttpServletResponse response){
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String fileName = "";
		String uploadPath = AdminConfig.goodsUploadPath;
		String path = request.getSession().getServletContext().getRealPath("/")+uploadPath;
		File uploadPathFile = new File(path);
		
		if (!uploadPathFile.exists()) {
		   uploadPathFile.mkdir();
		}
		List<Map> list = new ArrayList<Map>();
		List<MultipartFile> files = multipartRequest.getFiles("img");
		if(files.size() == 0){
			files = multipartRequest.getFiles("wangEditorH5File");
		}
		for(int i=0;i<files.size();i++){
			MultipartFile mulfile = files.get(i);
			fileName = mulfile.getOriginalFilename();
			fileName = handlerFileName(fileName);
			File file = new File(path + fileName);
			try {
				mulfile.transferTo(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("imagePath", fileName);
			map.put("url", AdminConfig.goodsImgUrl);
			map.put("html", "<script>document.domain = '"+AdminConfig.bHostUrl+"';</script>");
			list.add(map);
		}
		multipartRequest = null;
		return JSONArray.toJSONString(list);
    }
    
    //文件名称处理
  	private String handlerFileName(String fileName) {
  		//处理名称start
  		fileName = (new Date()).getTime()+"_"+fileName;
  		//时间戳+文件名，防止覆盖重名文件
  		String pre = StringUtils.substringBeforeLast(fileName, ".");
  		String end = StringUtils.substringAfterLast(fileName, ".");
  		fileName = pre+"."+end;//用MD5编码文件名，解析附件名称
  		//处理名称end
  		return fileName;
  	}
  	
}
