$(document).ready(function(){
  $(".termList").hide();
  $(".collapseTerms").hide();
  $(".side-form").hide();
  $(".next").hide();

  function updatePoints(points, type) {
    var current = parseInt($("#points-" + type).html())
    $("#points-" + type).html(" " + (current + points) + " ")
  }


  function appendSkill(skill) {
    $("#skills").append(
      "<div class='skill'><tr><td><h4>" + skill.nickname + "</h4><p>" + skill.description + "</p></td><td><p>Added 1 minute ago</p></td><td></td></tr></div>")
  }

  function appendGoal(goal_skill, type) {
    $("#" + type + "-goals").append(
      "<tr><div class='goal'><td><b>" + goal_skill[1].nickname + "</b></td><td>" + goal_skill[0].num_sessions + " practice session(s)</td><td>" + goal_skill[0].session_length + " minutes each</td></div></tr>")
  }

  function appendSession(session_skill) {
    $("#current-sessions").append(
      "<tr><div class='session'><td><b>" + session_skill[1].nickname + "</b></td><td>" + session_skill[0].duration + " minutes</td><td>less than a minute ago</td></div></tr>")
  }

  $(function(){
    var $select = $('.num-sessions');
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
    var points = Math.floor((numSessions * sessionLength)/6)
    $("#new-current-goal").fadeOut(600);
    $.ajax({
      method: "POST",
      url: "/api/v1/goals.json",
      dataType: "JSON",
      data: {goal: {skill_id: skillId, num_sessions: numSessions, session_length: sessionLength, week_number: weekNumber}},
      success: function(newGoal) {
        appendGoal(newGoal, "current")
        updatePoints(points, "available")
        $('#skill-id-session')
          .append($('<option>', { value : newGoal[0].skill_id })
          .text(newGoal[1].nickname));
        $('#skill-id-current').prop('selectedIndex',0);
        $('#num-sessions-current').prop('selectedIndex',0);
        $('#session-length-current').prop('selectedIndex',0);
      }
    })
  });
  // dry this up - can just take in current/next i think
  $("#create-next-goal").on('click', function(){
    var skillId = $("#skill-id-next").val()
    var numSessions = $("#num-sessions-next").val()
    var sessionLength = $("#session-length-next").val()
    var weekNumber = $("#week_num-next").val()
    var points = Math.floor((numSessions * sessionLength)/6)
    $("#new-next-goal").fadeOut(600);
    $.ajax({
      method: "POST",
      url: "/api/v1/goals.json",
      dataType: "JSON",
      data: {goal: {skill_id: skillId, num_sessions: numSessions, session_length: sessionLength, week_number: weekNumber}},
      success: function(newGoal) {
        appendGoal(newGoal, "next")
        updatePoints(points, "available-next")
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
    $("#new-skill").fadeOut(600);
    $.ajax({
      method: "POST",
      url: "/api/v1/skills.json",
      dataType: "JSON",
      data: {skill: {nickname: skillNickname, description: skillDescription, user_id: skillUserId}},
      success: function(newSkill) {
        appendSkill(newSkill);
        $('#skill-id-current')
          .append($('<option>', { value : newSkill.id })
          .text(newSkill.nickname));
        $('#skill-id-next')
          .append($('<option>', { value : newSkill.id })
          .text(newSkill.nickname));
        $('.form-control, textarea').val('');
      }
    })
  });

  $("#create-session").on('click', function(){
    var skillId = $("#skill-id-session").val()
    var duration = $("#session-length-log").val()
    $.ajax({
      method: "POST",
      url: "/api/v1/sessions.json",
      dataType: "JSON",
      data: {session: {skill_id: skillId, duration: duration}},
      success: function(newSession) {
        appendSession(newSession)
        updatePoints(Math.floor(duration/6), "earned")
        updatePoints(Math.floor(duration/6), "total")
        $('#skill-id-session').prop('selectedIndex',0);
        $('#session-length-log').prop('selectedIndex',0);
      }
    })
  });

  $(function(){
     $('.expandTerms').click(function(){
        $('#set-'+$(this).attr('target')).show();
        $('#show-'+$(this).attr('target')).hide();
        $('#hide-'+$(this).attr('target')).show();
      });
  });

  $(function(){
    $('.collapseTerms').click(function(){
        $('#set-'+$(this).attr('target')).hide();
        $('#hide-'+$(this).attr('target')).hide();
        $('#show-'+$(this).attr('target')).show();
    });
  });

  $(".arrow-down").on('click', function(){
      $('#'+$(this).attr('target')).fadeIn(600);
  });

  $(".tab").on('click', function(){
      $('.tab').removeClass("active-tab")
      $(this).addClass("active-tab")
      $('.current').hide();
      $('.next').hide();
      $('.'+$(this).attr('target')).show();
  });

  $('.flashcard').on('click', function() {
    $(this).toggleClass('flipped');
  });

});
