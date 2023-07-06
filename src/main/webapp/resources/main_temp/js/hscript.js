function isImage(file) {
	if (file.type.startsWith("image")) {
		return true;
	}
	return false;
}

function displayImg(dploc, file) {
	var reader = new FileReader(); // File 또는 Blob 객체를 읽어서 result 속성에 저장(비동기)
	reader.readAsDataURL(file); // readAsDataURL(file): 컨텐츠를 특정 Blob 이나 File에서 읽어 오는 역할
	reader.onload = function(e) { // onload: 읽기 작업이 완료되면 작동(비동기)
		dploc.attr("src", e.target.result);
	}
}