document.getElementsByName("date[scope]")[1].addEventListener("change", function(e) {
  if (e.target.checked == true) {
    document.getElementById('date_day').style.display = "block";
  } else {
    document.getElementById('date_day').style.display = "none";
  }
})
document.getElementsByName("date[scope]")[0].addEventListener("change", function(e) {
  if (e.target.checked == true) {
    document.getElementById('date_day').style.display = "none";
  } else {
    document.getElementById('date_day').style.display = "block";
  }
})