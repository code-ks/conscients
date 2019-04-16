# frozen_string_literal: true

# Main constant file used to calculate delivery fees in the app
EUROPE = %w[AD AL AT BA BE BG BY CH CY CZ DE DK EE ES FI FO FR GG GI GR HR HU IE IM IS
            IT JE LI LT LU LV MC MD MK MT NL NO PL PT RO RU SE SI SJ SK SM TR UA UK VA YU].freeze

PRINTING_FEES = 80

DELIVERY_FEES = {
  1..250 => {
    france: 400, europe: 950, world: 1000
  },
  251..500 => {
    france: 550, europe: 1300, world: 1400
  },
  501..750 => {
    france: 700, europe: 1500, world: 2200
  },
  751..1000 => {
    france: 800, europe: 1600, world: 2700
  },
  1001..2000 => {
    france: 900, europe: 1700, world: 3700
  },
  2001..5000 => {
    france: 1350, europe: 2200, world: 5400
  },
  5001..BigDecimal('Infinity') => {
    france: 1950, europe: 3550, world: 10_000
  }
}.freeze
