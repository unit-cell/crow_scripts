-- diddle
-- input1: clock
-- input2: select diddle
-- output1: left trigger
-- output2: right trigger
-- output3: trigger every 4th beat
-- output4: accent trigger (1/5 chance)

-- single paradiddle
diddle = {1,2,1,1,2,1,2,2}
n = 8
probability = 0.8
probability_check = 0
negative = false

function init()
  input[1].mode('change')
  input[2].mode('window', {-3,-1.5,1.5,3}, 0.2)
  position = 1
end

input[1].change = function(s)
  probability_check = math.random()
  if negative == true then
    if probability_check < probability then output[diddle[position]]( pulse() )
    end
  else output[diddle[position]]( pulse() )
  end
  -- output 3: pulse every 4 beats
  if position == 1 or position == 5 or position == 9 then output[3]( pulse() )
  end
  -- output 4: random accents
  if probability_check < 0.2 then output[4]( pulse() )
  end
  -- advance position
  if position < n then position = position + 1
  else position = 1
  end
end

input[2].window = function(win, is_rising)
  if win == 3 then
    n, position, diddle = 8, 1, {1,2,1,1,2,1,2,2} -- single paradiddle
    negative = false
  end
  if win == 4  then
    n, position, diddle = 12, 1, {1,2,1,2,1,1,2,1,2,1,2,2} -- double paradiddle
    negative = false
  end
  if win == 5 then
    n, position, diddle = 12, 1, {1,2,1,1,2,2,2,1,2,2,1,1} -- paradiddle diddle
    negative = false
  end
  if win == 2  then
    n, position, diddle = 12, 1, {1,2,1,2,1,1,2,1,2,1,2,2} -- double paradiddle
    negative = true
  end
  if win == 1 then
    n, position, diddle = 12, 1, {1,2,1,1,2,2,2,1,2,2,1,1} -- paradiddle diddle
    negative = true
  end
end
