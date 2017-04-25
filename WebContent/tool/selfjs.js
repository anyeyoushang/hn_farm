serializeObject = function(form){/*将form表单的值序列化成对象*/
	var o = {};
	$.each(form.serializeArray(), function(index){// 表单序列化为数组然后遍历
		if(o[this['name']]){
			o[this['name']] = o[this['name']] + "," + this['value'];
		}else{
			o[this['name']] = this['value'];
		}
	});
	return o;
};