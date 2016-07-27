$(document).ready(function(){

  function appendSkill(skill) {
    $("#skills").append(
      "<div class='skill'><h4>" + skill.nickname + "</h4><p>" + skill.description + "</p></div>")
  }

  function appendGoal(goal_skill) {
    $("#goals").append(
      "<div class='goal'><h4>" + goal_skill[1].nickname + "</h4><p>" + goal_skill[0].num_sessions + " sessions</p><p>" + goal_skill[0].session_length + " minutes</p></div>")
  }

  $(function(){
    var $select = $("#num-sessions");
    for (i=1;i<=10;i++){
        $select.append($('<option id=option-' + i +' ></option>').val(i).html(i))
    }
  })

  $(function(){
    var $select = $("#session-length");
    for (i=15;i<=60;i+=15){
        $select.append($('<option id=option-' + i +'></option>').val(i).html(i))
    }
  })

  $("#create-goal").on('click', function(){
    var skillId = $("#skill-id").val()
    var numSessions = $("#num-sessions").val()
    var sessionLength = $("#session-length").val()
    $.ajax({
      method: "POST",
      url: "http://127.0.0.1:3000/api/v1/goals.json",
      dataType: "JSON",
      data: {goal: {skill_id: skillId, num_sessions: numSessions, session_length: sessionLength}},
      success: function(newGoal) {
        appendGoal(newGoal)
        $('#skill-id').prop('selectedIndex',0);
        $('#num-sessions').prop('selectedIndex',0);
        $('#session-length').prop('selectedIndex',0);
      }
    })
  });

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

        appendSkill(newSkill);
        $('#skill-id')
          .append($('<option>', { value : newSkill.id })
          .text(newSkill.nickname));
        $('.form-control, textarea').val('');
      }
    })
  });

});
