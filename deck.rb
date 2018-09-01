require 'squib'
require 'game_icons'

data = Squib.csv file:'data.csv'

Squib::Deck.new cards: data['bid'].size, layout: 'layout.yml', width:'62.4mm', height:'92.4mm' do
  rect layout: 'suit_band'
  rect layout: 'bleed', radius: '2mm'
  safe_zone layout:'safe'
  text layout:'bid', str: data['bid'].map{|i| ":bid:  #{i}"} do |embed|
      embed.svg key: ':bid:', file: GameIcons.get('thor-hammer').file, layout:'description_icon'
  end

  text layout:'vp', str: data['vp'].map{|i| ":vp:  #{i}"} do |embed|
      embed.svg key: ':vp:', file: GameIcons.get('laurel-crown').file, layout:'description_icon'
  end

  text layout:'power', str: data['power'].map{|i| ":power:  #{i}" if i != nil} do |embed|
      embed.svg key: ':power:', file: GameIcons.get('swiss-army-knife').file, layout:'description_icon'
  end

  # text layout:'vp negative sign', str: data['vp_value'].map{|i| "-" if i<0}
  # text str: data['special_power'].map{|i| " <span >#{i}</span>" if i != nil}, layout:'special_power'
  save_png
  save_pdf width: '210mm', height: '297mm', trim: '3.2mm'
end
