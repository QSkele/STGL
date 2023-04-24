package cn.com.scitc.graduationproject.controller;

import cn.com.scitc.graduationproject.dao.ClassDao;
import cn.com.scitc.graduationproject.dao.UsersDao;
import cn.com.scitc.graduationproject.model.Pjclass;
import cn.com.scitc.graduationproject.model.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/")
public class LoginController {
    HttpSession session;
    @Autowired
    ClassDao classDao;
    @Autowired
    UsersDao usersDao;
    @RequestMapping("/login")
    private String login(){
        return "/student/login";
    }
    @PostMapping("/CanLogin")
    private String CanLogin(String username, String userpwd,HttpServletRequest request){
        Iterable<Users> users = usersDao.findAll();
        String errorInfo = "";
        //用for循环分析用户类型
        for (Users lis : users){
            if(lis.getUsername().equals(username) && lis.getUserpwd().equals(userpwd)){
                //用户权限为教师
               if (lis.getRoleid().equals(1)){
                   //获得班级信息
                   request.getSession().setAttribute("Tlis",lis);
                   Integer id = lis.getClassid();
                   request.getSession().setAttribute("Tclassid",id);
                   //进入教师主页
                   return "redirect:/TeacherManage";
               } else if (lis.getRoleid().equals(2)){
                   //用户权限为学生
                   request.getSession().setAttribute("lis",lis);
                   Integer usid = lis.getUserid();
                   Integer id = lis.getClassid();
                   request.getSession().setAttribute("classid",id);
                   request.getSession().setAttribute("userid",usid);
                   //进入学生主页
                   return "redirect:/StuMan";
               }else if (lis.getRoleid().equals(3)){
                   //用户权限为管理员
                   request.getSession().setAttribute("Alis",lis);
                   request.getSession().setMaxInactiveInterval(30 * 60);
                   //进入管理员主页
                   return "redirect:/AdminManage";
               }
            }else {
                //错误返回login页面，并显示错误信息
                errorInfo = "账号或密码错误,错误代码:SMJCC_LoginController";
                request.getSession().setAttribute("errorInfo",errorInfo);
            }

        }
        //返回student的login页面
        return "redirect:/login";
    }
    @GetMapping("/register")
    private  String register(Model model){
        Iterable<Pjclass> list = classDao.findAll();
        model.addAttribute("list",list);
        return "/student/register";
    }
    @PostMapping("/CanRegister")
    private  String CanRegister(Integer roleid,String username,String userpwd,String truename ,Integer classid ,HttpServletRequest request){
        System.out.println(roleid+":"+username+":"+userpwd+":"+truename+":"+classid);
        String wk = "";
        String cz = "";
        String cg = "";
        Users users = new Users();
        users.setRoleid(roleid);
        users.setUsername(username);
        users.setUserpwd(userpwd);
        users.setTruename(truename);
        users.setClassid(classid);
       //学生注册账号
       Users byUsername = usersDao.findByUsername(username);//查询学生学号
       System.out.println(byUsername);//打印所输入学号
       // 若学生不存在
           if (byUsername==null){
               //判断密码是否符合要求
               if(userpwd.equals("")){
                   wk = "密码或密码不能为空！错误代码:SMJCC_LoginController";
                   request.getSession().setAttribute("wk",wk);
               }else {
                   //判断学生真实姓名是否符合要求
                   if (truename.equals("")){
                       wk = "学生真实姓名不能为空！错误代码:SMJCC_LoginController";
                       request.getSession().setAttribute("wk",wk);
                   }
                   else {
                       //将学生信息加入用户表中，返回注册页面
                       usersDao.save(users);
                       cg = "注册成功，请登陆！";
                       request.getSession().setAttribute("cg",cg);
                   }
               }
           }else {
               //若学生存在
               System.out.println("cz");
               //打印错误信息
               cz = "该用户名以存在！错误代码:SMJCC_LoginController";
               request.getSession().setAttribute("cz",cz);
               //返回注册页面
               return "redirect:/register";
           }
       return "redirect:/register";
    }
    @RequestMapping("/StuMan")
    private String StuMan(){
        return "/student/StuMan";
    }
    //学生注销
    @RequestMapping("/logout")
    private String logout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        System.out.println("注销");
        session.removeAttribute("lis");
        session.removeAttribute("classid");
        session.removeAttribute("classid");
        session.removeAttribute("errorInfo");
        session.removeAttribute("cxdl");
        return  "redirect:/login";
    }
    //老师注销
    @RequestMapping("/Tlogout")
    private  String Tlogout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.removeAttribute("Tlis");
        session.removeAttribute("Tclassid");
        session.removeAttribute("Tuserid");
        //返回login页面
        return  "redirect:/login";
    }
    //管理员注销
    @RequestMapping("/Alogout")
    private  String Alogout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.removeAttribute("Alis");
        //返回login页面
        return  "redirect:/login";
    }
    //登录SESSION
    @RequestMapping("/llogout")
    private  String llogout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.removeAttribute("errorInfo");
        session.removeAttribute("cxdl");
        //返回login页面
        return  "redirect:/login";
    }
    //注册清除session
    @RequestMapping("/zclogout")
    private String zclogout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        System.out.println("注册清除ssesion成功！");
        session.removeAttribute("wk");
        session.removeAttribute("wk");
        return "redirect:/register";
    }
    //修改密码
    @PostMapping("/xiugai")
    private String xiugai( Integer userid,String userpwd,HttpServletRequest request){
       Integer u = usersDao.updatepwd(userpwd, userid);
        String cxdl ="";
        if (u==1){
            cxdl = "cxdl";
            request.getSession().setAttribute("cxdl",cxdl);
            return "redirect:/login";
        }
        return "redirect:/logout";
    }
}
