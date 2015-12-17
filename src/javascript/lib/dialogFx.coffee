###*
# dialogFx.js v1.0.0
# http://www.codrops.com
#
# Licensed under the MIT license.
# http://www.opensource.org/licenses/mit-license.php
# 
# Copyright 2014, Codrops
# http://www.codrops.com
###

do (window) ->

  extend = (a, b) ->
    for key of b
      if b.hasOwnProperty(key)
        a[key] = b[key]
    a

  DialogFx = (el, options) ->
    @el = el
    @options = extend({}, @options)
    extend @options, options
    @ctrlClose = @el.querySelector('[data-dialog-close]')
    @isOpen = false
    @_initEvents()

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


  DialogFx::options =
    onOpenDialog: ->
      false
    onCloseDialog: ->
      false

  DialogFx::_initEvents = ->
    self = this
    # close action
    @ctrlClose.addEventListener 'click', @toggle.bind(this)
    # esc key closes dialog
    document.addEventListener 'keydown', (ev) ->
      keyCode = ev.keyCode or ev.which
      if keyCode == 27 and self.isOpen
        self.toggle()
    @el.querySelector('.dialog__overlay').addEventListener 'click', @toggle.bind(this)


  DialogFx::toggle = ->
    self = this
    if @isOpen
      classie.remove @el, 'dialog--open'
      classie.add self.el, 'dialog--close'
      onEndAnimation @el.querySelector('.dialog__content'), ->
        classie.remove self.el, 'dialog--close'

      # callback on close
      @options.onCloseDialog this
    else
      classie.add @el, 'dialog--open'
      # callback on open
      @options.onOpenDialog this
    @isOpen = !@isOpen


  # add to global namespace
  window.DialogFx = DialogFx
