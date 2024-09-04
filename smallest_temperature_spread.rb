file_path = 'w_data.dat'

day_with_smallest_spread = nil
smallest_spread = Float::INFINITY

# Regex pattern to extract day number, max temperature, and min temperature
pattern = /^\s*(\d+)\s+(\d+)\*?\s+(\d+)\*?/

# Read the file line by line
File.foreach(file_path) do |line|
  match_data = line.match(pattern)

  if match_data
    day = match_data[1].to_i
    max_temp = match_data[2].to_i
    min_temp = match_data[3].to_i

    # Calculate the temperature spread
    spread = (max_temp - min_temp).abs

    if spread < smallest_spread
      smallest_spread = spread
      day_with_smallest_spread = day
    end
  else
    # Skip the line if it's not matching expected data rows
    next if line.strip.empty? || line.strip.start_with?('<pre>', 'MMU', 'Dy')

    puts "Skipping line due to unexpected format: #{line.strip}"
  end
end

puts "The day with the smallest temperature spread is: Day #{day_with_smallest_spread}" if day_with_smallest_spread
