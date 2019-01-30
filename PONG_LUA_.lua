function love.load(arg)
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
  
  screen_height = love.graphics.getHeight()
  screen_width = love.graphics.getWidth()
  
  --Left Paddle
  L_Paddle = {} -- new table for the hero
  L_Paddle.x = 25-- x,y coordinates of the hero
  L_Paddle.y = 200
  L_Paddle.width = 25
  L_Paddle.height = 150
  L_Paddle.dy = .5
  
  --Right Paddle
  R_Paddle = {} -- new table for the hero
  R_Paddle.x = 750 -- x,y coordinates of the hero
  R_Paddle.y = 200
  R_Paddle.width = 25
  R_Paddle.height = 150
  R_Paddle.dy = .5

    --ball
    ball = {}
    ball.size = 20
    ball.x = 380
    ball.y = 300
    ball.dx = 1
    ball.dy = 1

  -- in v0.9.2 and earlier space is represented by the actual space character ' ', so check for both
  if (key == " " or key == "space") then
    shoot()
  end
end

function love.update(dt)
  
  --ball collision with left or right screen
  if(ball.x <= 0 or ball.x >= screen_width - ball.size) then
    ball.x = 380
    ball.y = 300
  end
  --ball collision with top or bottom screen
  if(ball.y <= 0 or ball.y >= screen_height - ball.size) then
    ball.dy = ball.dy * -1
  end
  
  ball.x = ball.x + ball.dx
  ball.y = ball.y + ball.dy
  
  L_Paddle.y = L_Paddle.y + L_Paddle.dy
  R_Paddle.y = R_Paddle.y + R_Paddle.dy
  
  if(L_Paddle.y <= 0 or L_Paddle.y >= screen_height - L_Paddle.height) then
    L_Paddle.dy = L_Paddle.dy * -1
  end
  
  if(R_Paddle.y <= 0 or R_Paddle.y >= screen_height - R_Paddle.height) then
    R_Paddle.dy = R_Paddle.dy * -1
  end
  --collision with left paddle
  if(ball.x <= L_Paddle.x + L_Paddle.width and ball.y >= L_Paddle.y and ball.y + ball.size <= L_Paddle.y + L_Paddle.height) then
    ball.dx = ball.dx * -1
  end
  --collision with right paddle
  if(ball.x + ball.size >= R_Paddle.x and ball.y + ball.size >= R_Paddle.y and ball.y + ball.size <= R_Paddle.y + R_Paddle.height) then
    ball.dx = ball.dx * -1
  end
  
  --if ball is in top left corner of screen
  if(ball.x < screen_width / 2 and ball.y < screen_height / 2 and ball.y < L_Paddle.y and ball.y + ball.size < L_Paddle.y) then
    L_Paddle.dy = L_Paddle.dy - .05
  end
  --if ball is in bottom left corner of screen
  if(ball.x < screen_width / 2 and ball.y + ball.size > L_Paddle.y + L_Paddle.height) then
    L_Paddle.dy = L_Paddle.dy + .05
  end
  --if ball is in top right corner of screen 
  if(ball.x > screen_width / 2 and ball.y + ball.size < R_Paddle.y) then
    R_Paddle.dy = R_Paddle.dy - .05
  end
  --if ball is in bottom right corner of screen
  if(ball.x > screen_width / 2 and ball.y > screen_height / 2 and ball.y > R_Paddle.y + R_Paddle.height and ball.y + ball.size > R_Paddle.y + R_Paddle.height) then
    R_Paddle.dy = R_Paddle.dy + .05
  end
  
  
  
end

function love.draw()
  -- let's draw a background
  love.graphics.setColor(255,255,255,255)

  -- let's draw our left paddle
  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle("fill", L_Paddle.x, L_Paddle.y, L_Paddle.width, L_Paddle.height)
  
    -- let's draw our right paddle
  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle("fill", R_Paddle.x, R_Paddle.y, R_Paddle.width, R_Paddle.height)
  
   -- let's draw our ball
  love.graphics.setColor(255,255,255,255)
  love.graphics.rectangle("fill", ball.x, ball.y, ball.size, ball.size)

end
