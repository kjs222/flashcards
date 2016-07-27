$(document).ready(function(){

  function appendSkill(skill) {
    $("#skills").append(
      "<div class='skill'><h4>" + skill.nickname + "</h4><p>" + skill.description + "</p></div>")
  }

  $("#create-skill").on('click', function(){
    var skillNickname = $("#skill-nickname").val()
    var skillDescription = $("#skill-description").val()
    var skillUserId = $("#skill-user").val()
    $.ajax({
      method: "POST",
      url: "http://127.0.0.1:3000/api/v1/skills.json",
      dataType: "JSON",
      data: {skill: {nickname: skillNickname, description: skillDescription, user_id: skillUserId}},
      success: function(newSkill) {
        appendSkill(newSkill)
      }
    })
  });

});
