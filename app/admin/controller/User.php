<?php

//这个控制器类名字要和文件名一样。负责用户的相关操作
namespace app\admin\controller;

use app\admin\model\Users;
//use \think\Controller;


class User
{
    /*
     *用户添加
     * http://mingdear.com/admin/user/add
     */
    public function add()
    {
        $user           = model('Users');
        $user->login_name = '徐森林';
        $user->login_pwd    = md5(123456);
        $user->type = 'admin';
        if ($user->save()) {
            return '用户[ ' . $user->login_name . ':' . $user->id . ' ]新增成功';
        } else {
            return $user->getError();
        }
    }



//        $user['nickname'] = '看云';
//        $user['email']    = 'kancloud@qq.com';
//        $user['birthday'] = strtotime('2015-04-02');
//        if ($result = UserModel::create($user)) {
//        return '用户[ ' . $result->nickname . ':' . $result->id . ' ]新增成功';
//        } else {
//            return '新增出错';
//        }





}
