
local sound = {
  menu = love.audio.newSource("prank.mp3", "stream"),
  morse = love.audio.newSource("morse.wav", "stream"),
  scary = love.audio.newSource("scary.mp3", "stream"),
}
local state = 'ready'
local duration = 0
local songLength = sound.morse:getDuration()
local gameStates = {
  start = 0,
  screen1 = 1,
  screen2 = 2,
  screen3 = 3,
  screen4 = 4,
  screen5 = 5,
  screen6 = 6,
  screen7 = 7,

}
local font = {
  normal = love.graphics.newFont("cookie.ttf", 24, love.graphics.HINT_NORMAL),
  semi = love.graphics.newFont("cookie.ttf", 34, love.graphics.HINT_NORMAL),
  small = love.graphics.newFont("cookie.ttf", 14, love.graphics.HINT_NORMAL),
  festival_normal = love.graphics.newFont("fesival.ttf", 14, love.graphics.HINT_NORMAL),
  font_normal = love.graphics.newFont("buy.ttf", 24, love.graphics.HINT_NORMAL),
  font_semi = love.graphics.newFont("buy.ttf", 30, love.graphics.HINT_NORMAL),
}

local countFalse = 0
local countFalseScreen5 = 0
local finishScreen4 = false
local finishScreen5 = false
local gameState = gameStates.start
local questions = {
  screen1 = {
    q1 = "1. How many gifts you want?",
    q2 = {
      q = "2. Choose present you want $ ",
      a1 = "1. Sth to use daily  ",
      a2 = "2. Sth to decorate",
      a3 = "3. Secret +++"
    },
  },
  screen3 = {
    q1 = "@ Oke. Let 's start!"
  },
  screen4 = {
    q1 = "1. So, what was the first day we met?"
  },
  screen5 = {
    q1 = "2. What day is the anniversary?"
  }
  }
local guideText = {
  a = "---> Press a to start or next",
  b = "---> Press b to back",
  bre = "---> Press b to back, backspace to delele, enter to finish",
  more = "% You can get more",
  nice = "% Nice!",
  really = "% Really? Pls think more carefully",
  number = "---> Press number to choose",
  seriously = "% Seriously ?"
}
local answers = {
  screen1 = {
    q1 = ''
  },
  screen4 = {
    q1 = '',
    ans='01/01/2000'
  },
  screen5 = {
    q1 = '',
    ans='01/01/2000'
  }
}
local images = {
  nine = love.graphics.newImage("9.jpg"),
  eight = love.graphics.newImage("8.jpg"),
  seven = love.graphics.newImage("7.jpg"),
  six = love.graphics.newImage("6.png"),
  five = love.graphics.newImage("5.png"),
  four = love.graphics.newImage("4.jpg"),
  three = love.graphics.newImage("3.jpg"),
  two =  love.graphics.newImage("2.png"),
  one = love.graphics.newImage("1.jpg"),
  zero = love.graphics.newImage("0.jpg"),
  box = love.graphics.newImage("box.jfif"),
  ten = love.graphics.newImage("10.png"),
  twelve = love.graphics.newImage("12.jfif"),
  wait = love.graphics.newImage("wait.jpg"),
  love = love.graphics.newImage("13.jfif"),
  false1 = love.graphics.newImage("false1.jfif"),
  false2 = love.graphics.newImage("false2.jpg"),
  false3 = love.graphics.newImage("false3.jfif"),
  gifts = love.graphics.newImage("gifts.png"),
  couple = love.graphics.newImage("couple.png"),
  morse_code = love.graphics.newImage("morse_code.png")
}

function showEmotionText (text)
  love.graphics.setFont(font.semi)
  love.graphics.setColor(love.math.colorFromBytes(233, 150, 122))
  love.graphics.print(text, 50, 150)
  love.graphics.setColor(1,1,1)
end

function showEmotionText2 (text)
  love.graphics.setFont(font.normal)
  love.graphics.setColor(love.math.colorFromBytes(233, 150, 122))
  love.graphics.print(text, 50, 200)
  love.graphics.setColor(1,1,1)
end

function showEmotionText3 (text)
  love.graphics.setFont(font.semi)
  love.graphics.setColor(love.math.colorFromBytes(233, 150, 122))
  love.graphics.print(text, 50, 200)
  love.graphics.setColor(1,1,1)
end

function showEmotionImage()
  local answers = answers.screen1.q1
  if answers == "0" then
    love.graphics.draw(images.zero, 290, 150, 0, 0.5)
    showEmotionText("% Wait... What?")
  elseif  answers == "1" then
    love.graphics.draw(images.one, 270, 220, 0, 0.5)
    showEmotionText(guideText.more)
  elseif  answers == "2" then
    love.graphics.draw(images.two, 270, 200, 0, 0.5)
    showEmotionText(guideText.really)
  elseif  answers == "3" then
     love.graphics.draw(images.three, 250, 150, 0, 0.5)
     love.graphics.setColor(love.math.colorFromBytes(255, 105, 180))
     love.graphics.print(guideText.nice, 50, 150)
     guide(guideText.a)
     love.graphics.setColor(1,1,1)
  elseif  answers == "4" then
    love.graphics.draw(images.four, 250, 150, 0, 0.5)
    showEmotionText("% Ummm...")
  elseif  answers == "5" then
     love.graphics.draw(images.five, 250, 150, 0, 1.5)
     showEmotionText("% Nope")
  elseif  answers == "6" then
     love.graphics.draw(images.six, 250, 150)
     showEmotionText("% Really???")
  elseif  answers == "7" then
     love.graphics.draw(images.seven, 350, 150, 0, 0.5)
     showEmotionText("% That's a bit much")
  elseif  answers == "8" then
     love.graphics.draw(images.eight, 300, 150, 0, 0.75)
     showEmotionText("% Unbelievable")
  elseif  answers == "9" then
     love.graphics.draw(images.nine, 300, 150, 0, 0.75)
     showEmotionText(guideText.seriously)
  end
end

function drawScreen1()
  love.graphics.setFont(font.semi)
  love.graphics.print(questions.screen1.q1, 30, 50)
  love.graphics.print("-->", 30, 100)
  love.graphics.setFont(font.normal)
  local isNumber = checkNumber(answers.screen1.q1)
  if isNumber then
    setTextColor(answers.screen1.q1, 255, 255, 255, 100, 100, font.semi)
    showEmotionImage()
  end
end

function setTextColor(text, colorR,colorB,colorA, x, y, font)
  love.graphics.setFont(font)
  love.graphics.setColor(love.math.colorFromBytes(colorR, colorB, colorA))
  love.graphics.print(text, x, y)
  love.graphics.setColor(1,1,1)
end

function drawStart(str, x, y)
  love.graphics.setColor(love.math.colorFromBytes(255, 215, 0))
  love.graphics.print(str, x, y)
  love.graphics.setColor(1,1,1)
end

function guide(str)
  setTextColor(str, 152,152,152,50, love.graphics.getHeight()-50, font.normal)
end

function drawScreen2()
  love.graphics.setFont(font.semi)
  love.graphics.print(questions.screen1.q2.q, 30, 50)
  love.graphics.setFont(font.normal)
  love.graphics.print(questions.screen1.q2.a1, 150, 100)
  guide(guideText.number)
  drawStart("*",350, 100 )
  love.graphics.print(questions.screen1.q2.a2, 150, 150)
  drawStart("**",350, 150 )
  love.graphics.print(questions.screen1.q2.a3, 150, 200)
  drawStart("****",350, 200 )
end

function drawScreen3()
  love.graphics.setFont(font.semi)
  love.graphics.print(questions.screen3.q1, 30, 50)
  love.graphics.draw(images.box, love.graphics.getWidth()/2-250, love.graphics.getHeight()/2-150, 0, 0.5)
  guide(guideText.b)
 
end

function drawScreen4()
  love.graphics.setFont(font.font_semi)
  love.graphics.print(questions.screen4.q1, 40, 50)
  love.graphics.setFont(font.font_normal)
  love.graphics.print("--> Ex: 01/01/2020", 30, 100)
  love.graphics.print("-->Ans: ", 30, 150)
  if finishScreen4 == false then
    love.graphics.draw(images.ten, love.graphics.getWidth()/2-150, love.graphics.getHeight()/2-150, 0, 0.5)
    guide(guideText.bre)
  end
  if answers.screen4.q1 ~= "" then
    local text = answers.screen4.q1 
    setTextColor(text, 255, 255, 255, 100, 150, font.font_normal)
    if finishScreen4 then
      if answers.screen4.q1 == answers.screen4.ans then
        if countFalse == 0 then
          showEmotionText3("Excellent! You are right from the first try! ")
          love.graphics.draw(images.love, 250, 250, 0, 1.25)
          guide(guideText.a)
        else
          showEmotionText3("Oke! After "..countFalse .." times don't remember")
          love.graphics.draw(images.twelve, 250, 250, 0, 1)
          guide(guideText.a)
        end
      else 
        if countFalse == 1 then 
          showEmotionText2("Really? Try to remember!")
          love.graphics.draw(images.false1, 250, 250, 0, 1)
        elseif countFalse == 2 then
          showEmotionText2("Wrong again!")
          love.graphics.draw(images.false2, 250, 200, 0, 0.5)
        elseif countFalse == 3 then
          showEmotionText2("Oke I will wait")
          love.graphics.draw(images.false3, 250, 250, 0, 1)
        elseif countFalse >3 then
          showEmotionText2("Still waiting... After wrong "..countFalse.." times")
          love.graphics.draw(images.wait, 250, 230, 0, 0.5)
        end
        guide(guideText.bre)
      end
    else
      love.graphics.draw(images.ten, love.graphics.getWidth()/2-150, love.graphics.getHeight()/2-150, 0, 0.5)
      guide(guideText.bre)
    end
  end
end

function drawScreen5()
  love.graphics.setFont(font.font_semi)
  love.graphics.print(questions.screen5.q1, 40, 50)
  love.graphics.setFont(font.font_normal)
  love.graphics.print("--> Ex: 01/01/2020", 30, 100)
  love.graphics.print("-->Ans: ", 30, 150)
  if finishScreen5 == false then
    love.graphics.draw(images.ten, love.graphics.getWidth()/2-150, love.graphics.getHeight()/2-150, 0, 0.5)
    guide(guideText.bre)
  end
  if answers.screen5.q1 ~= "" then
    local text = answers.screen5.q1 
    setTextColor(text, 255, 255, 255, 100, 150, font.font_normal)
    if finishScreen5 then
      if answers.screen5.q1 == answers.screen5.ans then
        if countFalse == 0 then
          showEmotionText3("Excellent! You are right from the first try! ")
          love.graphics.draw(images.love, 250, 250, 0, 1.25)
          guide(guideText.a)
        else
          showEmotionText3("Oke! After "..countFalse .." times don't remember")
          love.graphics.draw(images.twelve, 250, 250, 0, 1)
          guide(guideText.a)
        end
      else 
        if countFalseScreen5 == 1 then 
          showEmotionText2("Really? Try to remember!")
          love.graphics.draw(images.false1, 250, 250, 0, 1)
        elseif countFalseScreen5 == 2 then
          showEmotionText2("Wrong again!")
          love.graphics.draw(images.false2, 250, 200, 0, 0.5)
        elseif countFalseScreen5 == 3 then
          showEmotionText2("Oke I will wait")
          love.graphics.draw(images.false3, 250, 250, 0, 1)
        elseif countFalseScreen5 >3 then
          showEmotionText2("Still waiting... After wrong "..countFalseScreen5.." times")
          love.graphics.draw(images.wait, 250, 230, 0, 0.5)
        end
        guide(guideText.bre)
      end
    else
      love.graphics.draw(images.ten, love.graphics.getWidth()/2-150, love.graphics.getHeight()/2-150, 0, 0.5)
      guide(guideText.bre)
    end
  end

end

function drawScreen6()
  love.graphics.setFont(font.semi)
  love.graphics.print("Find blue backpack in the door ", 30, 50)
  love.graphics.print("to the right of the wardrobe", 70, 100)
  love.graphics.draw(images.gifts, love.graphics.getWidth()/2-150, love.graphics.getHeight()/2-100, 0, 0.25)
  guide(guideText.b)
end

function drawScreen7()
  sound.menu:stop()
   sound.scary:play()
  love.graphics.setFont(font.font_normal)
  love.graphics.print("3. Are you ready? Press space to play or replay", 30, 50)
  drawProgressBar()
  love.graphics.draw(images.morse_code, love.graphics.getWidth()/2-290, love.graphics.getHeight()/2-30, 0, 1)
  guide(guideText.b)
end

function drawProgressBar()
  love.graphics.print(string.sub(duration, 1, 4), 200, love.graphics.getHeight()/2-70)
  love.graphics.print(string.sub(songLength, 1, 4), love.graphics.getWidth()/2+170, love.graphics.getHeight()/2-70)
  local progress = duration / songLength
  local progressShow = progress*100
 if progressShow < 10 then
  progressShow = string.sub(progressShow, 1, 1)
 elseif progressShow >=10 and progress<100 then
  progressShow = string.sub(progressShow, 1, 2)
 else
  progressShow = string.sub(progressShow, 1, 3)
 end

  love.graphics.print("Loading... ".. progressShow .. " %", love.graphics.getWidth()/2-30, love.graphics.getHeight()/2-150)
  love.graphics.setColor(love.math.colorFromBytes(87, 87, 87))
  love.graphics.rectangle("fill", love.graphics.getWidth()/2-200, love.graphics.getHeight()/2-100, 404, 14)

  love.graphics.setColor(1, 1, 1)

  if duration >= songLength then
    startPlay = false
    duration = 0
    sound.morse:stop()
    state = 'ready'
  else
    love.graphics.setColor(love.math.colorFromBytes(168, 50, 117))
    love.graphics.rectangle("fill", love.graphics.getWidth()/2-198, love.graphics.getHeight()/2-98, 400 * progress, 10)
    love.graphics.setColor(1, 1, 1)
  end
end

function drawMenu()
    local center = (love.graphics.getWidth() / 2 ) - 100
    local menu = {
      one = "# Start game (a)",
      two = "$ Quit game (q)"
    }
    sound.menu:play()
    love.graphics.setFont(font.semi)
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.print(menu.one, center, 200)
    love.graphics.print(menu.two,center, 300)
    guide(guideText.a)
end

function checkNumber(input )
  local isNumber = true
  for i = 1, #input do
    if not (input:sub(i, i) >= "0" and input:sub(i, i) <= "9") then
      isNumber = false
      break
    end
  end
  return isNumber
end

function love.load()
  love.window.setTitle('Find gifts')
  sound.menu:setLooping(true)
end

function love.draw()
  if gameState == gameStates.start then
    drawMenu()
  elseif gameState == gameStates.screen1 then
    drawScreen1()
  elseif gameState == gameStates.screen2 then
    drawScreen2()
  elseif gameState == gameStates.screen3 then
    drawScreen3()
  elseif gameState == gameStates.screen4 then
    drawScreen4()
  elseif gameState == gameStates.screen5 then
    drawScreen5()
  elseif gameState == gameStates.screen6 then
    drawScreen6()
  elseif gameState == gameStates.screen7 then
    drawScreen7()
  end
  
end

function love.keypressed(key, scancode, isrepeat)
  if gameState == gameStates.start then
    if key == 'q' then
      love.event.quit()
    end
    if key == 'a' then
      gameState =  gameStates.screen1
      return
    end
  end
  if gameState ==  gameStates.screen1 then
    if key == 'a' then
      gameState = gameStates.screen2
      return
    end
    if answers.screen1.q1 then
      answers.screen1.q1 = key
    else
      answers.screen1.q1 = string.concat(answers.screen1.q1,key)
    end
    -- love.event.quit()
  end
  if gameState == gameStates.screen2 then
    if key == '1' then 
      gameState = gameStates.screen3
      return
    end
    if key == '2' then 
      gameState = gameStates.screen4
      return
    end
    if key == '3' then 
      gameState = gameStates.screen7
      return
    end
  end
  if gameState == gameStates.screen3 then
    if key == 'b' then
      gameState = gameStates.screen2
    end
  end
  if gameState == gameStates.screen4 then
    if key == 'backspace' then
      answers.screen4.q1 = answers.screen4.q1:sub(1, -2)
    elseif key == 'b' then
      gameState = gameStates.screen2
    elseif key == 'a' then
      if answers.screen4.q1 == answers.screen4.ans then
        gameState = gameStates.screen5
      end
    elseif key == 'return' then
      finishScreen4 = true
      if answers.screen4.q1 ~= answers.screen4.ans then
        countFalse = countFalse + 1
      end
    else
      if finishScreen4 == true then
        answers.screen4.q1 = ''
      end
      finishScreen4 = false
      answers.screen4.q1 = answers.screen4.q1 .. key
    end
  end
  if gameState == gameStates.screen5 then
    if key == 'backspace' then
      answers.screen5.q1 = answers.screen5.q1:sub(1, -2)
    elseif key == 'b' then
      gameState = gameStates.screen4
    elseif key == 'a' then
      if answers.screen5.q1 == answers.screen5.ans then
        gameState = gameStates.screen6
      end
    elseif key == 'return' then
      finishScreen5 = true
      if answers.screen5.q1 ~= answers.screen5.ans then
        countFalseScreen5 = countFalseScreen5 + 1
      end
    else
      if finishScreen5 == true then
        answers.screen5.q1 = ''
      end
      finishScreen5 = false
      answers.screen5.q1 = answers.screen5.q1 .. key
    end
  end
  if gameState == gameStates.screen6 then
    if key == 'b' then
      gameState = gameStates.screen2
    end
  end
  if gameState == gameStates.screen7 then
    if key == 'space' then
      sound.scary:stop()
      if state == 'ready' then
        sound.morse:play()
        state = 'play'
        return
      elseif state == 'play' then
        state = 'stop'
        sound.morse:pause()
      elseif state == 'stop' then
        state = 'play'
        sound.morse:play()
      end
    end
    if key == 'b' then
      gameState = gameStates.screen2
      sound.menu:play()
    end
  end
end

function love.update(dt)
  if state ~= 'ready' and state ~='stop' then
    duration = duration + dt
  end
end



