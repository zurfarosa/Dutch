require 'squib'
require 'game_icons'

data = Squib.csv file:'data.csv'

Squib::Deck.new cards: data['bid'].size, layout: 'layout.yml', width:'62.4mm', height:'92.4mm' do
  rect layout: 'suit_band'
  png layout: 'bid_circle'
  # rect layout: 'power_box'
  rect layout: 'bleed', radius: '2mm'
  # safe_zone layout:'safe'
  text layout:'bid', str: data['bid'].map{|i| "#{i}"}
  # svg file: GameIcons.get('thor-hammer').file, layout:'bid_icon'

  svg layout:'vp_frame'
  text layout:'vp', str: data['vp'].map{|i| "#{i}"}
  # svg file: GameIcons.get('laurel-crown').file, layout:'vp_icon'

  text layout:'power', str: data['power'].map{|i| "#{i}" if i != nil}
  # svg file: GameIcons.get('swiss-army-knife').file, layout:'power_icon'

  # text layout:'vp negative sign', str: data['vp_value'].map{|i| "-" if i<0}
  # text str: data['special_power'].map{|i| " <span >#{i}</span>" if i != nil}, layout:'special_power'
  save_png
  save_pdf width: '210mm', height: '297mm', trim: '3.2mm'
end
