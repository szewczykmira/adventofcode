INPUT_FILE = "input_9.txt"


def one(preambula = 5)
    data = File.read(INPUT_FILE).lines.map(&:to_i)
    data[preambula..].each_with_index do |value, index|
        sums = data[(index)..(index+preambula - 1)].permutation(2).map{ |x,y| x+y}
        return value unless sums.include? value
    end
end

def two(preambula = 5)
    data = File.read(INPUT_FILE).lines.map(&:to_i)
    result = one(preambula)
    data.each_with_index do |value, index|
        items = [value]
        data[(index+1)..].each do |elem|
            sum = items.reduce(:+)
            items << elem
            break if sum > result
            
            return (items.min + items.max) if sum == result 
        end
        items = []
    end
end

p one(25)
p two(25)