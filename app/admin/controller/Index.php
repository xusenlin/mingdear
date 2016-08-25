<?php

//这个控制器类名字要和文件名一样。负责各种网址的导向
namespace app\admin\controller;
//use app\admin\model;
use think\console\command\make\Controller;
use think\Model;

class Index
{

    public function login()
    {
        return view('login',['name'=>'thinkphp']);
    }
    
    
    /*
     * 后台整体框架首页
     */
    
    public function index()
    {

        return view('index',['name'=>'thinkphp']);
    }
    /*
     * 后台欢迎页面，我的桌面
     */
    public function welcome()
    {

        return view('welcome',[
            'user'=>model('Users')->get_user_total(),
            'admin'=>model('Users')->get_admin_total(),
            'comment'=>model('Comments')->get_comments_total()
        ]);
    }

    /*
     * 后台用户列表
     */
    public function user_list()
    {   $user = model('Users');
       //print_r($user->get_user_list(2));
       return view('user_list',['list'=>$user->get_user_list(3)]);
    }
    /*
    * 后台学生列表
    */
    public function student_list()
    {
        $student = model('Students');
        return view(
            'student_list',
            [
                'list'=>$student->get_students_list(1),
                'school'=>$student->get_school(),
                'professions'=>$student->get_professions()
            ]
        );
        
    }
    /*
    * 主题列表
    */
    public function post_list()
    {
        $post = model('Posts');
        return view('post_list',['list'=>$post->get_post_list(2)]);
    }
    /*
    * 评论列表
    */
    public function comment()
        {
            $comments = model('Comments');
            return view('comment',['list'=>$comments->get_comments_list(2)]);
        }

    /*
    * 学校列表
    */
    public function schools()
    {
        $school = model('Schools');
        return view('schools',['list'=>$school->get_school_list(1)]);
    }

    /*
        * 主题详情
        */
    public function article_details($id=0)
    {
        $post = model('Posts');
        $data = $post::get($id);

        //explode(',',$data->cover)
        $resources = model('Resources');

        $file = $resources->where('id', 'in', explode(",", $data->cover))->select();

        foreach ($file as $k){
            $arr[] = $k->getData();
        }
       
        return view('article_details',['content'=>$data->content,'file'=>$arr]);
    }

}
