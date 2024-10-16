const btn = document.querySelector("input[type='submit']");
const id = document.querySelector("input[name='id']");
const pw = document.querySelector("input[name='pw']");
const lo = document.querySelector(".login");

/*
document.addEventListener("DOMContentLoaded", function(){
	if(btn.value == "로그아웃"){
		let switching = document.querySelectorAll(".top_menu img")[2];
		const div = document.createElement("div");
		switching.parentNode.append(div);
		const profile = document.querySelector(".top_menu div");
		switching.remove();
		profile.innerText = "<a href='./logout.jsp'>로그아웃";
	}
});
*/


const btn_event = () => {
	
	if(id.value == "" ){
		alert("아이디를 입력해주세요");
	} else if (pw.value == "") {
		alert("비밀번호를 입력해주세요");
	}else if(btn.value == "로그인"){
		const f = document.createElement("form");
		const popup = document.querySelector(".popup");
		f.setAttribute("method","post");
		f.setAttribute("action","./loginok.do");
		f.append(lo);
		popup.appendChild(f);
		f.submit();
	} else {
		location.href='./logout.jsp';
	}	
};


btn.addEventListener("click",btn_event);