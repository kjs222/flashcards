$(document).ready(function(){

  $(".statistics.index").ready(function(){
    renderChartOnLoad();
  });

  function renderChartOnLoad(){
    $.ajax({
      method: "GET",
      url: "/api/v1/sessions/statistics.json",
      dataType: "JSON",
      data: {period: 1},
      success: function(chartInfo) {
        renderChart(chartInfo, "week")
      }
    });
  }

  function updatePoints(points, type) {
    var current = parseInt($("#points-" + type).html())
    $("#points-" + type).html(" " + (current + points) + " ")
  }

  function resetDropdowns(type){
    $('#skill-id-' + type).prop('selectedIndex',0);
    $('#num-sessions-' + type).prop('selectedIndex',0);
    $('#session-length-' + type).prop('selectedIndex',0);
  }

  function addSkillToDropdown(skill, type) {
    if (type === "current") {
      $('#skill-id-session')
        .append($('<option>', { value : skill[0].skill_id })
        .text(skill[1].nickname));
    }
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

  $(".chart-button").on('click', function(){
    var type = $(this).attr('target')
    var weeks = $(this).attr('value')
    $.ajax({
      method: "GET",
      url: "/api/v1/sessions/statistics.json",
      dataType: "JSON",
      data: {period: weeks},
      success: function(chartInfo) {
        renderChart(chartInfo, type)
      }
    })
  });

  function renderChart(chartData, type) {
    $(".charts").hide()
    $("#" + type + "-chart").show()
    var options = {
        responsive: true,
        maintainAspectRatio: true
    }
    var data = {
        labels: chartData[0],
        datasets: [
            {
                label: "Total Practice Minutes",
                fill: false,
                lineTension: 0.1,
                backgroundColor: "rgba(75,192,192,0.4)",
                borderColor: "rgba(75,192,192,1)",
                borderCapStyle: 'butt',
                borderDash: [],
                borderDashOffset: 0.0,
                borderJoinStyle: 'miter',
                pointBorderColor: "rgba(75,192,192,1)",
                pointBackgroundColor: "#fff",
                pointBorderWidth: 1,
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(75,192,192,1)",
                pointHoverBorderColor: "rgba(220,220,220,1)",
                pointHoverBorderWidth: 2,
                pointRadius: 1,
                pointHitRadius: 10,
                data: chartData[1],
                spanGaps: false,
            }
        ]
    };

    var element = document.getElementById(type + '-chart').getContext('2d');

    new Chart(element, {
      type: 'line',
      data: data,
      options: options

    });
  }

  $(".create-goal").on('click', function(){
    var type = $(this).attr('target')
    var skillId = $("#skill-id-" + type).val()
    var numSessions = $("#num-sessions-" + type).val()
    var sessionLength = $("#session-length-" + type).val()
    var weekNumber = $("#week_num-" + type).val()
    var points = Math.floor((numSessions * sessionLength)/6)
    $("#new-" + type + "goal").fadeOut(600);
    $.ajax({
      method: "POST",
      url: "/api/v1/goals.json",
      dataType: "JSON",
      data: {goal: {skill_id: skillId, num_sessions: numSessions, session_length: sessionLength, week_number: weekNumber}},
      success: function(newGoal) {
        appendGoal(newGoal, type);
        updatePoints(points, "available-" + type);
        resetDropdowns(type);
        addSkillToDropdown(newGoal, type);
        $(".side-form").hide();
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

  // $("#search-submit").on('click', function(){
  //   var searchTerm = $("#q").val()
  //   var searchUser = $("#created_by").val()
  //   var token = $("#created_by").val()
  //   $.ajax({
  //     method: "GET",
  //     url: https://api.quizlet.com/2.0/search/sets?q="sql",
  //     dataType: "JSON",
  //     data: {session: {skill_id: skillId, duration: duration}},
  //     success: function(newSession) {
  //       appendSession(newSession)
  //       updatePoints(Math.floor(duration/6), "earned")
  //       updatePoints(Math.floor(duration/6), "total")
  //       $('#skill-id-session').prop('selectedIndex',0);
  //       $('#session-length-log').prop('selectedIndex',0);
  //     }
  //   })
  // });

});

(function ($) {
  var ready = $.fn.ready;
  $.fn.ready = function (fn) {
    if (this.context === undefined) {
      ready(fn);
    } else if (this.selector) {
      ready($.proxy(function(){
        $(this.selector, this.context).each(fn);
      }, this));
    } else {
      ready($.proxy(function(){
        $(this).each(fn);
      }, this));
    }
  }
})(jQuery);
