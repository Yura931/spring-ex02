// console.log("reply module...");

var replyService = (function() {

	function add(reply, callback, error) {
		// console.log("add1 method");
		console.log(reply);
		
		$.ajax({
			type: "post",
			url: "/controller/replies/new",  // context root로 변경
			data: JSON.stringify(reply),     // form data를 json
			contentType: "application/json; charset=utf-8",
			success: function(result, stauts, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
				
			}
		});
	}

	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		// javascript 
		// boolean false : 0, "", null, undefined
		
		$.getJSON("/controller/replies/pages/" + bno + "/" + page, function(data) {
			if (callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}
	
	function remove(rno, callback, error) {
		$.ajax({
			type: 'delete',
			url: '/controller/replies/' + rno,
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	function update(reply, callback, error) {
		$.ajax({
			type: 'put',
			url: '/controller/replies/' + reply.rno,
			data: JSON.stringify(reply),
			contentType: 'application/json; charset=utf-8',
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	return {
//		name:"AAAA",
		add: add,
		getList: getList,
		remove: remove,
		update: update
	};
})();






