
const acept_btn = document.querySelector(".member_agreebtn");


const ck_all = document.querySelectorAll(".ckbox");
let all_control = ck_all[ck_all.length-1];

//document.addEventListener("DOMContentLoaded", function(){
//	ck_all.forEach(checkbox => {
//		const save = localStorage.getItem(checkbox.name);
//		if(save !== null){
//			checkbox.checked = save === "false";
//		}
//	});
//});


const acept = () => {
	let result = true;
	
	for(let i=0; i < ck_all.length-2; i++){
		if(!(ck_all[i].checked)){
			alert("필수 약관을 선택해주세요");
			result=false;
			break;
		}
	}
	if(result){
		//const ckboxs = 'input[name="ckbox"]:checked';
	  	//const Elements = document.querySelectorAll(ckboxs);
		const f = document.createElement("form");
		const section = document.querySelector(".subpage");
		const agree_member = document.querySelector(".member_agree");
		f.setAttribute("method","post");
		f.setAttribute("action","./agree.jsp");
		f.appendChild(agree_member);
		section.appendChild(f);
		f.submit();
	}
};

const ck_all_control = () => {
//	if(all_control.checked){
//		ck_all.forEach((e) => e.checked = true);
//	} else {
//		ck_all.forEach((e) => e.checked = false);
//	}
	const isChecked = all_control.checked;
	ck_all.forEach((e) => e.checked = isChecked);
	
//	ck_all.forEach(checkbox => {
//		localStorage.setItem(checkbox.name, checkbox.checked);	
//	});
};

//ck_all.forEach(checkbox => {
//	checkbox.addEventListener('change', function(){
//		localStorage.setItem(checkbox.name, checkbox.checked);
//	});
//});


acept_btn.addEventListener("click", acept);
all_control.addEventListener("click", ck_all_control);