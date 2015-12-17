if $('.photo-row').length

  PhotoSwipe = require '../lib/photoswipe.js' 
  PhotoSwipeUI_Default = require '../lib/photoswipe-ui-default.js'

  image = []
  items = []

  addPhoto = (from, to) ->
    for i in [from...to]
      $('.photo-row').append(
        $('<div/>', {class: 'col-md-2 col-sm-4 photo-box'} ).append(
          $('<a/>', {
              class: 'photo-content'
              href: 'img/photo/user' + i + '.jpg'
            } )
            .css 'background-image', 'url("img/photo/user' + i + '.jpg")'
        )
      )      
    initPhotoSwipeFromDOM '.photo-row'


  initPhotoSwipeFromDOM = (gallerySelector) ->

    $(gallerySelector).find('a').each (i) ->
      image[i] = new Image
      image[i].src = $(@).attr 'href'

      $(image[i]).load =>
        # items.push
        #   src: $(@).attr 'href'
        #   w: image[i].width
        #   h: image[i].height  
        #   el = $(@).parent()
        items[i] =
          src: $(@).attr 'href'
          w: parseInt(image[i].width, 10) * 2
          h: parseInt(image[i].height, 10) * 2  
          el: $(@).parent()

        $(@).unbind().click (e) =>
          e.preventDefault()
          options = 
            index: i
            # bgOpacity: 0.7
            # showHideOpacity: true

            getThumbBoundsFn: (i) ->
              # See Options->getThumbBoundsFn section of docs for more info
              thumbnail = $(items[i].el).children()[0]
              pageYScroll = window.pageYOffset or document.documentElement.scrollTop
              rect = thumbnail.getBoundingClientRect()
              {
                x: rect.left
                y: rect.top + pageYScroll
                w: rect.width
              }

            # barsSize: {top:0,bottom:0}
            # captionE: false
            # fullscreenEl: false
            # shareEl: false
            # bgOpacity: 0.85
            # tapToClose: true
            # tapToToggleControls: false

          lightBox = new PhotoSwipe($('.pswp')[0], PhotoSwipeUI_Default, items, options)
          lightBox.init()




  addPhoto(1, 13)

  $('#btn-more-photo').click (e) ->
    e.preventDefault()
    addPhoto(14, 46)
    $(@).hide() 