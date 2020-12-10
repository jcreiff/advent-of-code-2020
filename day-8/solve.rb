def find_loop(list, index = 0, total = 0)
  return total if list[index].last == 'complete!'
  return [total, true] if index == list.length-1
  action, distance = list[index]
  list[index].push('complete!')
  if action == 'jmp'
    index += distance.to_i
  else
    total += (action == 'acc' ? distance.to_i : 0)
    index += 1
  end
  find_loop(list, index, total)
end

def instructions
  File.readlines('input.txt').map { |line| line.split(' ') }
end

def try_modified(list, i)
  list[i][0] = (list[i][0] == 'jmp' ? 'nop' : 'jmp')
  find_loop(list)
end

def find_success
  (0...instructions.length).to_a.each do |i|
    next if instructions[i][0] == 'acc'
    result, success = try_modified(instructions, i)
    return result if success
  end
end

find_loop(instructions)
find_success
