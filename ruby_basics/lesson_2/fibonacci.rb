def fibonacci(num)
    nums = [0, 1]
  
    while nums[-1] + nums[-2] <= num
      nums << nums[-1] + nums[-2]
    end
  
    nums
end

puts fibonacci(100).inspect