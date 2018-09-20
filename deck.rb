require 'squib'
require 'rubygems'
require 'rmagick'



suits = CSV.read 'suits.csv'
data = CSV.read 'data.csv'

# open up data.csv, and add a 'suit' and 'colour' value to each card
new_data = [data[0]]
for j in 1..suits.length-1 do
  for i in 1..data.length-1 do
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

# create the main deck of cards
Squib::Deck.new cards: data['bid'].size, layout: 'layout.yml', width:'62.4mm', height:'92.4mm' do
  background color: :white
  rect layout: 'suit_band', fill_color: data['colour']
  bid_circle_file = data['bid'].map do |default|
    default.nil? ? nil : 'icons/noun_coin_938416.png'
  end
  png layout: 'bid_circle', file: bid_circle_file
  # rect layout: 'bleed'
  # safe_zone layout:'safe'
  text layout:'bid_value', str: data['bid'].map{|i| "#{i}"}
  vp_frame_file = data['vp'].map do |default|
    default.nil? ? nil : 'icons/noun_Laurel Wreath_499498.svg'
  end
  svg layout:'vp_frame', file: vp_frame_file
  text layout:'vp_value', str: data['vp'].map{|i| "#{i}"}
  power_frame_file = data['power'].map do |default|
    default.nil? ? nil : 'icons/noun_Frame_1755979_v3.svg'
  end
  svg layout:'power_frame', file: power_frame_file
  text layout:'power_text', str: data['power'].map{|i| "#{i}" if i != nil}
  save_png prefix:"card_", layout:'png_dims'
  save_png dir:"mini_cards", prefix:"card_", layout:'mini_png_dims'
  save_pdf file: "cards.pdf", width: '210mm', height: '297mm', trim: '3.2mm'#layout:'pdf_dims'
end

#Create smaller gifs from the pngs for use in my RULES.md, then delete the pngs
Dir.glob('mini_cards/*.png') do |path|
  img = Magick::Image::read(path)[0]
  file_stem = path[-11..-5]
  processed_img = img.scale(0.33).border(1,1,'black')
  processed_img.write("mini_cards/mini_" + file_stem + '.gif')
  processed_img = img.scale(0.165).border(1,1,'black')
  processed_img.write("mini_cards/super_mini_" + file_stem + '.gif')
  File.delete path
end
