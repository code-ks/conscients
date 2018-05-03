# frozen_string_literal: true

EUROPE = %w[AD AL AT BA BE BG BY CH CY CZ DE DK EE ES FI FO FR GG GI GR HR HU IE IM IS
            IT JE LI LT LU LV MC MD MK MT NL NO PL PT RO RU SE SI SJ SK SM TR UA UK VA YU].freeze

PRINTING_FEES = Money.new(80, 'EUR')

DELIVERY_FEES = {
  1..250 => {
    france: Money.new(400, 'EUR'), europe: Money.new(950, 'EUR'), world: Money.new(1000, 'EUR')
  },
  251..500 => {
    france: Money.new(550, 'EUR'), europe: Money.new(1300, 'EUR'), world: Money.new(1400, 'EUR')
  },
  501..750 => {
    france: Money.new(700, 'EUR'), europe: Money.new(1500, 'EUR'), world: Money.new(2200, 'EUR')
  },
  751..1000 => {
    france: Money.new(800, 'EUR'), europe: Money.new(1600, 'EUR'), world: Money.new(2700, 'EUR')
  },
  1001..2000 => {
    france: Money.new(900, 'EUR'), europe: Money.new(1700, 'EUR'), world: Money.new(3700, 'EUR')
  },
  2001..5000 => {
    france: Money.new(1350, 'EUR'), europe: Money.new(2200, 'EUR'), world: Money.new(5400, 'EUR')
  },
  5001..BigDecimal('Infinity') => {
    france: Money.new(1950, 'EUR'), europe: Money.new(3550, 'EUR'), world: Money.new(10_000, 'EUR')
  }
}.freeze
