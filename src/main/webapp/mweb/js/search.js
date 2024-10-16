const search_id_btn = document.querySelector(".member_agreebtn");
const id_data = document.querySelectorAll(".w_input1");
const search_pw_btn = document.querySelectorAll(".member_agreebtn")[1];


const id_search = () => {
    
    const xhr = new XMLHttpRequest();
    xhr.open('POST', './search_id.do', true);
    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
        	const id = JSON.parse(xhr.responseText);
        	if(id.search_id != ''){
        		const msg = "<p>고객의 아이디: " + id.search_id + "</p>";
	            document.querySelector('.id_searchview').innerHTML = msg;
        	} else {
        		document.querySelector('.id_searchview').innerHTML = `
	                <p>해당 고객의 정보는 확인이 되지않습니다.</p>
	            `;
        	}
        }
    };
    
	const data = {
		name: id_data[0].value,
		tel: id_data[1].value,
		email: id_data[2].value
	};    
    xhr.send(JSON.stringify(data));

};



const pw_search = () => {
	if(id_data[3].value == ''){
		alert("id를 입력해주세요.");
	}else if(id_data[4].value == ''){
		alert("고객명을 입력해주세요.");
	}else if(id_data[5].value == ''){
		alert("연락처를 입력해주세요.");
	}else if(id_data[6].value == ''){
		alert("비밀번호를 입력해주세요.");
	} else {
	    const xhr = new XMLHttpRequest();
	    xhr.open('POST', './search_pw.do', true);
	    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	        	const pw = JSON.parse(xhr.responseText);
	        	if(pw.search_result != 0){
	        		alert("정상적으로 패스워드가 변경되었습니다.");
	        		location.href="./index.jsp";
	        	} else {
	        		alert("해당 고객정보는 확인이되지 않습니다.");
	        	}
	        }
	    };
	    
		const data = {
			id: id_data[3].value,
			name: id_data[4].value,
			tel: id_data[5].value,
			pw: id_data[6].value
		};    
	    xhr.send(JSON.stringify(data));
	}
};


search_id_btn.addEventListener("click",id_search);
search_pw_btn.addEventListener("click",pw_search);
