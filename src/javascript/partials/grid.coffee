###*
# main.js
# http://www.codrops.com
#
# Licensed under the MIT license.
# http://www.opensource.org/licenses/mit-license.php
# 
# Copyright 2015, Codrops
# http://www.codrops.com
###

do (window) ->
  # sliders - flickity
  sliders = [].slice.call(document.querySelectorAll('.slider'))
  flkties = []
  grid = document.querySelector('.grid')
  iso = undefined
  filterCtrls = [].slice.call(document.querySelectorAll('.filter > button'))

  # Select Color and Size
  productCustomization = [].slice.call($('.cd-customization'))
  dlg = []
  cart = $('.cd-cart')
  animating = false
  # from http://www.sberry.me/articles/javascript-event-throttling-debouncing

  throttle = (fn, delay) ->
    allowSample = true
    (e) ->
      if allowSample
        allowSample = false
        setTimeout (->
          allowSample = true
        ), delay
        fn e

  init = ->
    # preload images
    imagesLoaded grid, ->
      initFlickity()
      initIsotope()
      initEvents()
      initCustomization productCustomization

  initFlickity = ->
    sliders.forEach (slider, i) ->
      flkty = new Flickity(slider,
        prevNextButtons: false
        wrapAround: true
        cellAlign: 'left'
        contain: true
        resize: false)
      flkty.select 1
      flkty.on 'settle', () ->
        #console.log flkty.selectedIndex
        #$(productCustomization[i]).find('.color li').eq(flkty.selectedIndex).click().click()
        $(productCustomization[i]).find('.color').length and selectCustomItem $(productCustomization[i]).find('.color'), flkty.selectedIndex + 1
      # store flickity instances
      flkties.push flkty

      # $(slider).closest('.slider').find('.dot').each (i, el) ->
      #   console.log el
      #   $(@).addClass( 'color-' + $('.color').find('li').eq(i).data('color') )

  initIsotope = ->
    iso = new Isotope(grid,
      isResizeBound: false
      itemSelector: '.grid__item'
      percentPosition: true
      # masonry: columnWidth: '.grid__sizer'
      transitionDuration: '0.6s')

  initEvents = ->
    filterCtrls.forEach (filterCtrl) ->
      filterCtrl.addEventListener 'click', ->
        classie.remove filterCtrl.parentNode.querySelector('.filter__item--selected'), 'filter__item--selected'
        classie.add filterCtrl, 'filter__item--selected'
        iso.arrange filter: filterCtrl.getAttribute('data-filter')
        recalcFlickities()
        iso.layout()

    # window resize / recalculate sizes for both flickity and isotope/masonry layouts
    window.addEventListener 'resize', throttle(((ev) ->
      recalcFlickities()
      iso.layout()
    ), 50)


    $('body').on 'click', (event) ->
      #if user clicks outside the .cd-gallery list items - remove the .hover class and close the open ul.size/ul.color list elements
      if $(event.target).is('body') or $(event.target).is('.grid')
        deactivateCustomization()



  recalcFlickities = ->
    i = 0
    len = flkties.length
    while i < len
      flkties[i].resize()
      ++i



  'use strict'
  support = animations: Modernizr.cssanimations
  animEndEventNames = 
    'WebkitAnimation': 'webkitAnimationEnd'
    'OAnimation': 'oAnimationEnd'
    'msAnimation': 'MSAnimationEnd'
    'animation': 'animationend'
  animEndEventName = animEndEventNames[Modernizr.prefixed('animation')]

  onEndAnimation = (el, callback) ->

    onEndCallbackFn = (ev) ->
      if support.animations
        if ev.target != this
          return
        @removeEventListener animEndEventName, onEndCallbackFn
      if callback and typeof callback == 'function'
        callback.call()

    if support.animations
      el.addEventListener animEndEventName, onEndCallbackFn
    else
      onEndCallbackFn()


  changeSelectDropDown = (selected, event, i) ->
    #open/close options list
    selected.toggleClass 'is-open'
    resetCustomization selected
    if $(event.target).is('li')
      # update selected option
      activeItem = $(event.target)
      index = activeItem.index() + 1
      # activeItem.addClass('active').siblings().removeClass 'active'

      selectCustomItem selected, index

      # if color has been changed, update the visible product image 
      selected.hasClass('color') and flkties[i].select index - 1
    

  selectCustomItem = (selected, index) ->
    selected.find('li').eq(index - 1).addClass('active').siblings().removeClass 'active'

    selected.removeClass(
      (selected[0].className.match(/\b(selected-\d{1,3})\b/g) || []).join(' ')
    ).addClass 'selected-' + index


  initCustomization = (items) ->
    items.forEach (el, i) ->
      actual = $(el)
      selectOptions = actual.find('[data-type="select"]')
      addToCartBtn = actual.find('.add-to-cart')
      dlg = new DialogFx($('#dialog-cart')[0])
      touchSettings = actual.next('.cd-customization-trigger')
      #detect click on ul.size/ul.color list elements 
      selectOptions.on 'click', (event) ->
        changeSelectDropDown $(@), event, i

      #detect click on the add-to-cart button
      addToCartBtn.on 'click', ->
        unless animating
          animating = true
          resetCustomization addToCartBtn
          addToCartBtn.addClass('is-added').find('path').eq(0).animate { 'stroke-dashoffset': 0 }, 300, =>
            setTimeout (=>
              updateCart()
              addToCartBtn.removeClass('is-added').find('em').on 'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', ->
                #wait for the end of the transition to reset the check icon
                addToCartBtn.find('path').eq(0).css 'stroke-dashoffset', '19.79'
                animating = false
              if $('.no-csstransitions').length > 0
                # check if browser doesn't support css transitions
                addToCartBtn.find('path').eq(0).css 'stroke-dashoffset', '19.79'
                animating = false

              dlg.toggle()
              

            ), 600



  resetCustomization = (selectOptions) ->
    #close ul.clor/ul.size if they were left open and user is not interacting with them anymore
    #remove the .hover class from items if user is interacting with a different one
    selectOptions.siblings('[data-type="select"]').removeClass('is-open').end().parents('.grid__item').addClass('hover').parent('li').siblings('li').find('.grid__item').removeClass('hover').end().find('[data-type="select"]').removeClass 'is-open'

  deactivateCustomization = ->
    productCustomization.find('[data-type="select"]').removeClass 'is-open'

  updateCart = ->
    #show counter if this is the first item added to the cart
    !cart.hasClass('items-added') and cart.addClass('items-added')
    cartItems = cart.find('span')
    text = parseInt(cartItems.text()) + 1
    cartItems.text text


  init()