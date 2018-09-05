require 'squib'
require 'game_icons'

data = Squib.csv file:'data.csv'

for colour in ['light pink','light blue', '#228B22', '#CD2626','burnt orange']
  Squib::Deck.new cards: data['bid'].size, layout: 'layout.yml', width:'62.4mm', height:'92.4mm' do
    background color: :white
    rect layout: 'suit_band', fill_color: colour
    png layout: 'bid_circle'
    # rect layout: 'power_box'
    rect layout: 'bleed'
    # safe_zone layout:'safe'
    text layout:'bid', str: data['bid'].map{|i| "#{i}"}

    svg layout:'vp_frame'
    text layout:'vp', str: data['vp'].map{|i| "#{i}"}
    text layout:'power', str: data['power'].map{|i| "#{i}" if i != nil}
    save_png prefix:"card_ #{colour}_", trim:'3.2mm', trim_radius:'2mm'
    save_pdf file: "card_ #{colour}.pdf", width: '210mm', height: '297mm', trim: '3.2mm'
  end
end
