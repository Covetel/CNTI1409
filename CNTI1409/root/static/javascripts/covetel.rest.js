/* 
Archivo: 		covetel.rest.js
Autor: 			Walter Vargas <walter@covetel.com.ve>, Juan Mesa <juan@covetel.com.ve>, Jochen
Descripción:	Métodos para hacer posible el uso de REST con jQuery. 
*/

function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
        });
}

jQuery.extend({
    put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});
