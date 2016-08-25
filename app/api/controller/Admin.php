<?php
namespace app\api\controller;
use think\Exception;
use think\Model;
use think\Session;


class Admin  //这个控制器类名字要和文件名一样
{
    public function index()
    {

        return '后台admin数据调用！';
    }

    // 通过ID获取用户信息
    //接口/api/admin/read_id/
    public function read_id($id = 0)
    {
        $model =model('Users');
        $user = $model::get($id);
        if ($user) {
            return json($user);
        } else {
            return json(['error' => '用户不存在']);
        }
    }
    //登录接口
    //接口/api/admin/login/
    public function login($login_name='',$pwd='',$verif='')
    {
        if(empty($login_name)){return json(['msg'=>'用户名不能为空！','success'=>false]);}
        if(empty($pwd)){return json(['msg'=>'用户密码不能为空！','success'=>false]);}
        if($verif!= Session::get('LoginVerifyCode')){return json(['msg'=>'验证码出错！','success'=>false]);}
        $model =model('Users');
        $user = $model->where('login_name',$login_name)->where("login_pwd", md5($pwd))->find();
        if(!$user){ return json(['msg'=>'用户不存在或密码错误！','success'=>false]);}
        if(!$user->enabled){return json(['msg'=>'用户已经被锁定！','success'=>false]);}

        Session::set("user",$user);
        return json(['msg'=>'用户验证成功！','success'=>true]);

    }





    // 用户锁定切换
    //接口/api/admin/enabled/
    public function enabled($id=0)
    {
        if(empty($id)){return json(['msg'=>'用户名ID不能为空！','success'=>false]);}
        $model =model('Users');
        $user           = $model::get($id);
        $userdata       = $user->getData();

        if($user){
            if (0==$userdata['enabled']){$user->enabled = 1;}else{$user->enabled = 0;}
        }
        if (false !== $user->save()) {
            return json(['msg'=>'锁定切换成功！','success'=>true]);

        } else {
            return json(['msg'=>$user->getError(),'success'=>false]);
        }
    }
    // 删除主题
    //接口/api/admin/post_delete/
    public function post_delete($id=0){
        if(empty($id)){return json(['msg'=>'主题ID不能为空！','success'=>false]);}

        try{

            $model =model('Posts');
            $con = $model->where('id',$id)->delete();
        }catch (Exception $e){
            $error = $e->getMessage();
            $con = false;

        }


        if($con){
            return json(['msg'=>'主题删除成功！','success'=>true]);
        }else{
            return json(['msg'=>$error,'success'=>false]);
        }
    }
    // 删除评论
    //接口/api/admin/comment_delete/
    public function comment_delete($id=0){
        if(empty($id)){return json(['msg'=>'评论ID不能为空！','success'=>false]);}
        $comment = model('Comments')->where('id',$id)->delete();
        if ($comment){
            return json(['msg'=>'评论删除成功！','success'=>true]);
        }else{
            return json(['msg'=>'评论删除失败！','success'=>false]);
        }


    }





    
}

