package cc.royao.mana.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by libia on 2016/1/19.
 */

@RequestMapping("/customer")
@Controller
public class CustomerCtrl  {



        @RequestMapping( value = "/customerMana.htm")
        public String customerMana(HttpServletRequest request , HttpServletResponse response , ModelMap modelMap)
        {



            return "/customer/customer";
        }


}
