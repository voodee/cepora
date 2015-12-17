(($) ->

  $.fn.teamslider = ->


    # Default Values
    defaults = times: 300
    customopt = $.extend(defaults, customopt)
    slideLeft = if $(window).width() < 992 then 152.5 else 182.5
    allImage = @find('.team-img-wrap').length
    currentImage = 0
    teamimgslider = @find('.team-img')
    teamimgslider_children = teamimgslider.children('.team-img-wrap')
    teamtextslider = @find('.team-text')
    teamtextinner = teamtextslider.children('.team-text-inner')
    imginnerwrap = @find('.team-img-wrap')
    # Default Values end

    $('.team-wrap').find('.arrow-left').click ->
      setPosition currentImage = Math.max(--currentImage, -1)
    $('.team-wrap').find('.arrow-right').click ->
      setPosition currentImage = Math.min(++currentImage, allImage - 2)

    teamtextinner.eq(1).css 'display', 'block'
    imginnerwrap.eq(1).addClass 'team-shadow'



    setPosition = (pos) ->
      px = slideLeft * pos
      indexImg = pos + 1
      imginnerwrap.removeClass 'team-shadow'
      imginnerwrap.eq(indexImg).addClass 'team-shadow'
      teamimgslider.stop().animate { left: -px }, duration: customopt.times

      teamimgslider_children.find('div').stop().animate {
        width: 150
        height: 150
      }, duration: 250

      teamimgslider_children.eq(indexImg).find('div').stop().animate {
        width: 350
        height: 440
      },
        duration: 250
        step: ->
          teamimgslider.freetile()

      if $(window).width() < 1200
        teamimgslider_children.eq(indexImg).find('div').stop().animate {
          width: 320
          height: 397
        },
          duration: 250
          step: ->
            teamimgslider.freetile()

      if $(window).width() < 992
        teamimgslider_children.find('div').stop().animate {
          width: 120
          height: 120
        }, duration: 250
        teamimgslider_children.eq(indexImg).find('div').stop().animate {
          width: 300
          height: 370
        },
          duration: 250
          step: ->
            teamimgslider.freetile()

      if currentImage < 0
        teamtextinner.eq(0).fadeIn(300).animate { marginLeft: 0 },
          duration: 300
          queue: false
        teamtextinner.eq(1).stop().fadeOut(300).css 'display', 'none'
      else if currentImage == allImage - 2
        teamtextinner.eq(allImage - 1).fadeIn(500).animate { marginLeft: 0 },
          duration: 300
          queue: false
        teamtextinner.eq(allImage - 2).fadeOut(300).css 'display', 'none'
      else
        teamtextinner.stop().css
          marginLeft: 60
          display: 'none'
        teamtextinner.eq(indexImg).stop().fadeIn(500).animate { marginLeft: 0 },
          duration: 300
          queue: false


) jQuery