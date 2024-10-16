const acept_btn = document.querySelector(".member_agreebtn");
const member = document.querySelectorAll(".member_agree input[class='join_input1']");
const secu = document.querySelectorAll(".join_input2");
let number = "";

const acept = () => {
	let result = false;
//	member.forEach((e)=>{
//		if(e.value !== null){
//			msg = e.name + " 을 입력하세요";
//			result = false;
//		}
//			return result;
//	});
	
	const msg = ["ID를 입력하세요","이름을 입력하세요","패스워드를 입력하세요","동일한 패스워드를 입력하세요","이메일을 입력하세요","연락처를 입력하세요"];
	let count = 0;
	do{
		let mail = member[4].value;
		let mail_ck = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}/;
		let tel = member[5].value.replace(/[^0-9]/g, ' ');
		let tel_ck = /^(010)-?[0-9]{3,4}-?[0-9]{4}$/;

		if(member[count].value == ""){
			//alert(member[count].name + " 입력해야 합니다.");
			alert(msg[count]);
			break;
		} 
		if(count == 3 && member[2].value != member[3].value){
			alert("비밀번호가 동일하지 않습니다.");
			break;
		} else if (member[count].name == "email" && !mail_ck.test(mail)){
			alert("이메일이 잘못입력되었습니다."); 
			break;
		} else if (member[count].name == "tel" && !tel_ck.test(tel)){
			alert("전화번호가 잘못입력되었습니다.");
			break;
		} 
		count++;
	}while(member.length > count);
	if(count == member.length){
		if(number != secu[1].value){
			alert("보안코드를 제대로 입력해야합니다.");
			secu_code();			
		} else {
			result = true;
		}
	} 
	if(result){
		//const ckboxs = 'input[name="ckbox"]:checked';
	  	//const Elements = document.querySelectorAll(ckboxs);
		const f = document.createElement("form");
		const section = document.querySelector(".subpage");
		const agree_member = document.querySelector(".member_agree");
		f.setAttribute("method","post");
		f.setAttribute("action","./signupok.do");
		f.appendChild(agree_member);
		section.appendChild(f);
		f.submit();
	}
};

acept_btn.addEventListener("click", acept);


const secu_code = () => {
	number = "";
	let w = 0;
	let count = 6;
		
	do{
		number+=Math.ceil(Math.random()*9);
		w++;
	}while(w < count);	
	secu[0].value = number;
};

window.onload = secu_code;