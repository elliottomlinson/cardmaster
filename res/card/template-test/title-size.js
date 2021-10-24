window.onload=function shrink() {
		textSpan = document.getElementById("title-text")
		textDiv = document.getElementById("title")
		
		textSpan.style.fontSize = "80pt"

		// while(textSpan.offsetHeight > textDiv.offsetHeight)
		// {
		// 		updated_font_size = parseInt(textSpan.style.fontSize) - 1
		// 		textSpan.style.fontSize = updated_font_size + "pt";
		// }
}