$(document).ready(function(){

  function appendSkill(skill) {
    $("#skills").append(
      "<div class='skill'><h4>" + skill.nickname + "</h4><p>" + skill.description + "</p></div>")
  }

  function appendCurrentGoal(goal_skill) {
    $("#current-goals").append(
      "<div class='goal'><h4>" + goal_skill[1].nickname + "</h4><p>" + goal_skill[0].num_sessions + " sessions</p><p>" + goal_skill[0].session_length + " minutes</p></div>")
  }

  function appendNextGoal(goal_skill) {
    $("#next-goals").append(
      "<div class='goal'><h4>" + goal_skill[1].nickname + "</h4><p>" + goal_skill[0].num_sessions + " sessions</p><p>" + goal_skill[0].session_length + " minutes</p></div>")
  }

  $(function(){
    var $select = $(".num-sessions");
    for (i=1;i<=10;i++){
        $select.append($('<option id=option-' + i +' ></option>').val(i).html(i))
    }
  })

  $(function(){
    var $select = $(".session-length");
    for (i=15;i<=60;i+=15){
        $select.append($('<option id=option-' + i +'></option>').val(i).html(i))
    }
  })

  $("#create-current-goal").on('click', function(){
    var skillId = $("#skill-id-current").val()
    var numSessions = $("#num-sessions-current").val()
    var sessionLength = $("#session-length-current").val()
    var weekNumber = $("#week_num-current").val()
    $.ajax({
      method: "POST",
      url: "/api/v1/goals.json",
      dataType: "JSON",
      data: {goal: {skill_id: skillId, num_sessions: numSessions, session_length: sessionLength, week_number: weekNumber}},
      success: function(newGoal) {
        appendCurrentGoal(newGoal)
        $('#skill-id-current').prop('selectedIndex',0);
        $('#num-sessions-current').prop('selectedIndex',0);
        $('#session-length-current').prop('selectedIndex',0);
      }
    })
  });
  // dry this up
  $("#create-next-goal").on('click', function(){
    var skillId = $("#skill-id-next").val()
    var numSessions = $("#num-sessions-next").val()
    var sessionLength = $("#session-length-next").val()
    var weekNumber = $("#week_num-next").val()
    $.ajax({
      method: "POST",
      url: "/api/v1/goals.json",
      dataType: "JSON",
      data: {goal: {skill_id: skillId, num_sessions: numSessions, session_length: sessionLength, week_number: weekNumber}},
      success: function(newGoal) {
        //NEEDS TO APPEND TO NEXT
        appendNextGoal(newGoal)
        $('#skill-id-next').prop('selectedIndex',0);
        $('#num-sessions-next').prop('selectedIndex',0);
        $('#session-length-next').prop('selectedIndex',0);
      }
    })
  });

  $("#create-skill").on('click', function(){
    var skillNickname = $("#skill-nickname").val()
    var skillDescription = $("#skill-description").val()
    var skillUserId = $("#skill-user").val()
    $.ajax({
      method: "POST",
      url: "/api/v1/skills.json",
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
