window.jQuery     = window.$ = require 'jquery'
plugin            = require 'plugin'

 



$(document).ready ->
  require './lib/bootstrap.js'

  # Team
  if $('.team-slider').length
    window.EventEmitter = require './lib/eventEmitter.js'
    window.imagesLoaded = require './lib/imagesloaded.js' 
    require './lib/freetile.js'
    require './partials/teamSliders.coffee'
    $('.team-img').freetile()
    $('.team-slider').teamslider()
  # Team end


  require './partials/photoswipe.coffee'


  window.Handlebars = require './lib/handlebars.js'
  require './lib/handlebars-helper.coffee'

  products = [
    # Pure
    {
      name: 'Браслет PureStrength'
      price: '749'
      price_old: '1 200'
      sex: 'he she'
      img: [
        { name: 'pure/black-green.jpg' }
        { name: 'pure/red-black.jpg' }
        { name: 'pure/black-grey.jpg' }
        { name: 'pure/white-blue.jpg' }
        { name: 'pure/white-gray.jpg' }
        { name: 'pure/gray-green.jpg' }
        { name: 'pure/white-pink.jpg' }
        { name: 'pure/white-turquoise.jpg' }
      ]
      color: [
        { name: 'black-green' }
        { name: 'red-black' }
        { name: 'black-grey' }
        { name: 'white-blue' }
        { name: 'white-gray' }
        { name: 'gray-green' }
        { name: 'white-pink' }
        { name: 'white-turquoise' }
      ]
      size: [
        { name: '17,5см' }
        { name: '19см' }
        { name: '20,5см' }
      ]
    }
    # Rainso
    {
      name: 'Браслет Rainso'
      price: '1250'
      sex: 'he'
      img: [
        { name: 'Rainso/7.jpg' }
        { name: 'Rainso/12.jpg' }
      ]
      color: [
        { name: 'grey-gold' }
        { name: 'black-gold' }
      ]
      size: [
        { name: '22см' }
      ]
    }
    # Fat Love
    {
      name: 'Браслет Fate Love'
      price: '920'
      sex: 'he'
      img: [
        { name: 'FateLove/1.jpg' }
      ]
      color: [
        { name: 'black-grey' }
      ]
      size: [
        { name: '22см' }
      ]
    }
    # RadiationProtection
    {
      name: 'Radiation Protection'
      price: '700'
      sex: 'he'
      img: [
        { name: 'RadiationProtection/1.jpg' }
      ]
      color: [
        { name: 'black' }
      ]
      size: [
        { name: '22см' }
      ]
    }
    # TwoTone
    {
      name: 'Браслет Two Tone'
      price: '3 499'
      sex: 'he'
      img: [
        { name: 'TwoTone/1.jpg' }
        { name: 'TwoTone/2.jpg' }
        { name: 'TwoTone/3.jpg' }
        { name: 'TwoTone/4.jpg' }
        { name: 'TwoTone/5.jpg' }
        { name: 'TwoTone/6.jpg' }
      ]
      color: [
        { name: 'black' }
        { name: 'grey-gold' }
        { name: 'black-grey' }
        { name: 'grey' }
        { name: 'black-grey' }
        { name: 'grey-gold' }
      ]
      size: [
        { name: '22см' }
      ]
    }
    # NY
    {
      name: 'Браслет Jewerly'
      price: '1 299'
      price_old: '1 600'
      sex: 'she'
      img: [
        { name: 'ny/CuteBraceletMagneticHealth/1.jpg' }
      ]
      color: [
        { name: 'gold' }
      ]
      size: [
        { name: '21см' }
      ]
    }
    # # NY
    # {
    #   name: 'Браслет Gold Plated'
    #   price: '1 399'
    #   sex: 'she he'
    #   img: [
    #     { name: 'GoldPlated/1.jpg' }
    #   ]
    #   color: [
    #     { name: 'grey-gold' }
    #   ]
    #   size: [
    #     { name: '21см' }
    #   ]
    # }
    # RoseGoldPlaned
    {
      name: 'Rose Gold Plated'
      price: '2 199'
      sex: 'she he'
      img: [
        { name: 'RoseGoldPlaned/1.jpg' }
      ]
      color: [
        { name: 'grey-gold' }
      ]
      size: [
        { name: '21см' }
      ]
    }
    # GermaniumTourmalineInfrared
    {
      name: 'Турмалиновый браслет'
      price: '2 599'
      sex: 'she he'
      img: [
        { name: 'GermaniumTourmalineInfrared/1.jpg' }
      ]
      color: [
        { name: 'grey-gold' }
      ]
      size: [
        { name: '21см' }
      ]
    }
  ]

  template = Handlebars.compile($("#entry-template").html())
  $.each products, (i, product) ->
    $('.grid-items').append template(product)

  require './partials/grid.coffee'





  require './lib/dialogFx.coffee'


  # do ->
  #   dlgtrigger = document.querySelector('[data-dialog]')
  #   somedialog = document.getElementById(dlgtrigger.getAttribute('data-dialog'))
  #   dlg = new DialogFx(somedialog)
  #   dlgtrigger.addEventListener 'click', dlg.toggle.bind(dlg)
  #   dlg.toggle.bind(dlg)

  require './lib/textInputEffects.js'

  require './lib/toggle_panel.js'
  console.log 'Hi! I\'m Cepora.'