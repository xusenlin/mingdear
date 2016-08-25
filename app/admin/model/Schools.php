<?php

namespace app\admin\model;

use think\Model;

class Schools extends Model
{
    public function get_school_list($limit){
        return $this->paginate($limit);
    }
}