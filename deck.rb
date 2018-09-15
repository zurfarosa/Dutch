require 'squib'

suits = CSV.read 'suits.csv'
data = CSV.read 'data.csv'

# open up data.csv, and add a 'suit' and 'colour' value to each card
new_data = [data[0]]

for i in 1..data.length-1 do
  for j in 1..suits.length-1 do
    new_row = data[i].dup
    new_row[3] = suits[j][0]
    new_row[4] = suits[j][1]
    new_data << new_row
  end
end
# write the expanded card data to a new csv
CSV.open('data_expanded.csv', 'w') do |csv|
  new_data.each { |ar| csv << ar }
end

data = Squib.csv file:'data_expanded.csv'

#create the main deck of cards
# Squib::Deck.new cards: data['bid'].size, layout: 'layout.yml', width:'62.4mm', height:'92.4mm' do
#   background color: :white
#   rect layout: 'suit_band', fill_color: data['colour']
#   png layout: 'bid_circle'
#   rect layout: 'bleed'
#   # rect layout: 'inner_border'
#   # safe_zone layout:'safe'
#   text layout:'bid_value', str: data['bid'].map{|i| "#{i}"}
#
#   svg layout:'vp_frame'
#   text layout:'vp_value', str: data['vp'].map{|i| "#{i}"}
#   text layout:'power_text', str: data['power'].map{|i| "#{i}" if i != nil}
#   save_png prefix:"card_", layout:'png_dims'
#   save_pdf file: "cards.pdf", width: '210mm', height: '297mm', trim: '3.2mm'#layout:'pdf_dims'
# end

#now create the mini-cards without power text for creating diagrams for the instructions
Squib::Deck.new cards: data['bid'].size, layout: 'layout.yml', width:'31.2mm', height:'46.2mm'  do
  background color: :white
  rect layout: 'mini_suit_band', fill_color: data['colour']
  png layout: 'mini_bid_circle'
  rect layout: 'mini_border'
  text layout:'mini_bid_value', str: data['bid'].map{|i| "#{i}"}
  #
  svg layout:'mini_vp_frame'
  text layout:'mini_vp_value', str: data['vp'].map{|i| "#{i}"}
  text layout:'mini_power_text', str: data['power'].map{|i| "#{i}" if i != nil}

  save_png prefix:"mini_card_"
end
