<?php

namespace app\admin\model;

use think\Model;

class Students extends Model
{

    /*
     * 获取学生总数
     */
    public function get_user_total(){
        return $this->count();
    }
   
    /*
     * 获取学生列表
     */
    public  function get_students_list($limit){
        return $this->paginate($limit);
    }


    public function get_school()
    {
        $school = $this->hasMany('Schools')->select();
        foreach ($school as $k){
            $arr[$k->getData('id')] = $k->getData('name');
        }
        return $arr;
        
    }

    public function get_professions()
    {
        $professions = $this->hasMany('Professions')->select();
        foreach ($professions as $k){
            $arr[$k->getData('id')] = $k->getData('name');
        }
        return $arr;

    }

}