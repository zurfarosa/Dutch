require 'squib'

data = Squib.csv file:'data.csv'
puts data['title']

Squib::Deck.new cards: data['bid_value'].size, layout: 'layout.yml' do
  background color: 'white'
  rect layout: 'suit_band'
  cut_zone margin:36
  safe_zone margin: 72
  # svg file: data['title'].map { |t| "icons/#{t.downcase}.svg"}, layout:'main_image'
  # text str: data['title'], layout:'title'
  text layout:'bid', str: data['bid_value'].map{|i| "#{i} :coins:"} do |embed|
    embed.png key: ':coins:', file: 'icons/roman_coin_2.png', height:140, width:140
  end
  text layout:'vp', str: data['vp_value'].map{|i| "#{i.abs} :laurel:"} do |embed|
    embed.svg key: ':laurel:', file: 'icons/laurel.svg', height:140, width:140
  end
  text layout:'vp negative sign', str: data['vp_value'].map{|i| "-" if i<0}
  text str: data['special_power'].map{|i| "or <span >#{i}</span>" if i != nil}, layout:'special_power'
  save_png
  save_pdf trim: 36, width: '290mm', height: '210mm'
end
