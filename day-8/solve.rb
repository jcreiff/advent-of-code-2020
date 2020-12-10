instructions = File.readlines('input.txt').map { |line| line.split(' ') }

def find_loop(list, index = 0, total = 0)
  return total if list[index].last == 'complete!'
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

p find_loop(instructions)