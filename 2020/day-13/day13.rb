INPUT_FILE = "input_13.txt"

def one
    data = File.read(INPUT_FILE).lines.map(&:strip)
    earliest_departure = data[0].to_i
    buses = data[1].split(",").filter {|v| v != "x"}.map(&:to_i)
    buses.map { |bus| [bus, bus - (earliest_departure % bus)]}.sort_by {|obj| obj[-1]}[0].reduce(:*)
end


def find_for_pair(items, dep, counter)
    while true
        current_result = items.map {|bus, index| ((dep+index) % bus)}
        break if current_result.filter{|obj| obj!=0}.count == 0
        dep += counter
    end
    [items.reduce{|x, y| x[0]*y[0]}, dep]
end

def two
    data = File.read(INPUT_FILE).lines.map(&:strip)
    buses = data[1].strip.split(",").each_with_index.filter {|b, i| b != "x"}.map {|b, i| [b.to_i, i]}
    leastcm, dep = find_for_pair(buses[0..1], 0, buses[0][0])
    # 14 => 91 - 77
    buses[2..].each do |bus|
        leastcm, dep = find_for_pair([[leastcm, leastcm - dep], bus], dep, leastcm)
    end
    dep
end

p one
p two