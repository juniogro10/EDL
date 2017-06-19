screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()


--Trabalho 05
	-- Nome: default_block_size
  -- Binding time: compilação
  -- Propriedade: endereco
	-- Explicação: Sendo uma variavel global ,seu endereco é alocando em tempo de compilação

-- Tamanho padrão dos Blocos.
default_block_size = 20

-- Pontuação máxima.
--high_score = 0

-- Flag de Gameover.
gameover = false

-- Flag de Debug.
debug = false

-- Variavel splashscreen
local splash
o_ten_one = require "o-ten-one"

-- Flag de Carregamento
loading = true

-- Trabalho 06: hight_score é uma Tupla - Guardando uma string e um inteiro.
high_score = {'Hight Score' , 0}


-- Trabalho 08 - Closure e coroutine
function f_food (x,y,live)
    local food;
    food = {
        move = function (new_x,new_y)
             x = new_x
             y = new_y
             return x, y
        end,
        get = function ()
             return x, y
        end,
        isAlive = function()
          return live
        end,
        setLive = function (_live)
          live = _live
          return live
        end,
        -- Trabalho 08: anda com a comida da morte,caso somente a cabeça colide com a comida o jogo acaba
        walk_deatch = coroutine.create(function (dt)
            while true do
              for i=1, 5 do
                food.move( x + (player.body.speed*dt),  y+ 0)
                dt = coroutine.yield()
              end
              for i=1, 5 do
                food.move(x+ 0, y + player.body.speed*dt)
                dt = coroutine.yield()
              end
              for i=1, 5 do
                food.move( -player.body.speed*dt + x, y+0)
                dt = coroutine.yield()
              end
              for i=1, 5 do
                food.move(x+ 0, -player.body.speed*dt + y)
                dt = coroutine.yield()
              end

            end
        end),
    }
    return food
end

function love.load ()

  -- Carregamento da Lib de splashscreen
  splash = o_ten_one({fill="lighten",delay_after = 3})
  splash.onDone = function() loading = false end

  -- Título do Jogo.
  love.window.setTitle("Snake Game" )

  -- Sons do Jogo.
  sound_eating =  love.audio.newSource("eating.wav", "static")

  -- Trabalho 06: "static" é uma Enumeracao
  sound_gameover = love.audio.newSource("gameover.wav", "static")

  -- Inicializa a Cor do Cenário
  love.graphics.setBackgroundColor(255,255,255)

  -- Inicializa a Cor das Linhas de Demarcação do Cenário.
  love.graphics.setColor(0,0, 0)

  -- Define os limites do cenário na tela. ( Xi , Yi )


  scenarioLimits = {
    10,20,
    10,screenHeight-10,
    screenWidth-10,screenHeight-10,
    screenWidth-10,20,
    10,20
  }

  -- Iniciliza o Jogador.
  player = {
    pos = {
      current = {
        x = screenWidth/2,
        y = screenHeight/2
      },
      previous = {
        x = nil,
        y = nil
      }
    },
    direction = {
      x = 1,
      y = 0,
    },
    body = {
      size = 0,
      speed = 1500,
      gap = 1,


  -- Trabalho 07 :   --[[ blocks = {} Um array que está sendo construído, onde guardará o corpo do snake --]]
  --[[
  Escopo: O array blocks é uma variável global, que pode ser visto em qualquer parte do código.
  Tempo de vida: O array é zerado toda vezes que a função load é carrega , sendo sua duração enquanto o programa estiver em execução
  Alocação: Aumentada dinamicamente quando ocorre a colisão com a comida.Sua alocação ocorre na função na love.load()
  Desalocação: Ocorre o desalocamento quando o programa é encerrado.
  --]]
	-- Trabalho 06: blocks é um Array, podendo conter indeterminadas posições com blocos(Parte do corpo do snake).
      blocks = {}
    }
  }


  -- food = {
  --   -- Trabalho 06: pos é um registro .Tendo acesso ao pos.x e pos.y.
  --   pos = {
  --     x = nil,
  --     y = nil
  --   },
  --   isAlive = false
  -- }

  -- Trabalho 08 : Criação da comida usando o closure
  food = f_food(nil,nil,false)
  food_deatch = f_food(50,150,true);

  print("Criei Corpo do Player! : " .. tostring(player.body.size) .. "    x: " .. tostring(player.pos.current.x) .. "    y: " .. tostring(player.pos.current.y))

    -- Inicializa dois blocos ao Jogador e Inicializa comida no cenário.
    for i = 1,4 do

      initialPosX = player.pos.current.x - ( ( default_block_size + player.body.gap ) * ( player.body.size + 1 ) ) * player.direction.x

      new_block = playerAddBlock(initialPosX,player.pos.current.y)

      table.insert(player.body.blocks, new_block)
    end

    -- Inicializa a comida no cenário.
    respawnPlayerFood()

    -- Inicializa o limitador de tickRate.
    accumulator = {
      current = 0,
      limit= 0.1
    }

  end

  function love.keypressed (key)

    if key == 'left' or key == 'd' then
      if player.direction.x ~=1 and player.direction.y ~=0 then
        player.direction.x = -1
        player.direction.y = 0
      end
    elseif key == 'right' then
      if player.direction.x ~=-1 and player.direction.y ~=0 then
        player.direction.x = 1
        player.direction.y = 0
      end
    elseif key == 'up' then
      if player.direction.x ~= 0 and player.direction.y ~=1 then
        player.direction.x = 0
        player.direction.y = -1
      end
    elseif key == 'down' then
      if player.direction.x ~= 0 and player.direction.y ~=-1 then
        player.direction.y = 1
        player.direction.x = 0
      end
    elseif key == 'f' then
      playerAddBlock()
    elseif key == '2' then
      player.body.speed = player.body.speed + 50
    elseif key == '1' then
      player.body.speed = player.body.speed - 50
    elseif key == 'r' and gameover then
      gameover = false
      love.load()
    end
  end

  -- Adiciona um bloco ao Jogador.
  function playerAddBlock(x,y)
    --Trabalho 05
      -- Nome: x
      -- Binding time: Execução
      -- Propriedade: endereco
      -- Explicação: Por ser um varievel local , tendo o seu  escopo limitado a playerAddBlock.Seu endereço somente é definido em tempo execução

    -- Estrutura do Novo Bloco.
    new_block = { -- Trabalho 07 : Função responsável pela a criação de um novo objeto para a coleção.
      pos = {
        x = x,
        y = y
      }
    }

    player.body.size = player.body.size + 1


    print("Criei Corpo no Player! : " .. tostring(player.body.size) .. "    x: " .. tostring(new_block.pos.x) .. "    y: " .. tostring(new_block.pos.y))

    return new_block

    --Trabalho 05
      -- Nome: then
      -- Binding time: desing
      -- Propriedade: semantica
      -- Explicação: Como sendo uma palavra reservada na linguagem para execução de retorno de função .  Então é deifinido no tempo de desing da linguagem


  end

  -- Atualiza a posição da Comida.
  function respawnPlayerFood()


    -- Trabalho 08 : Utilizando o closure para mover e atualizar o status da Comida
    food.move(love.math.random(20, screenWidth - 30),love.math.random(20, screenHeight - 30))
    food.setLive(true);
    -- food.pos.x = love.math.random(20, screenWidth - 30)
    -- food.pos.y = love.math.random(20, screenHeight - 30)

    -- food.isAlive = true

  end

  -- Ativa o modo gameOver no Jogo.
  function gameOver()

    --Trabalho 05
    	-- Nome: then
    	-- Binding time: desing
      -- Propriedade: semantica
    	-- Explicação: Definida durante a implementação da linguaguem como palavra reservada , definicido inicio de bloco de instrução. Então é deifinido no tempo de desing da linguagem

    if not gameover then
      love.audio.play( sound_gameover )
      gameover = true
      player_movement_speed = 0
      --Trabalho 05
        -- Nome: player_movement_speed
        -- Binding time: execução
        -- Propriedade: valor
        -- Explicação: Seu valor é alterado em tempo de execução , pois cada vez que o player morre seu valor é modificado
      high_score[2] = player.body.size
    end


  end

  -- Atualiza o placar do jogo.
  function updatescore()
    if(player.body.size > high_score[2]) then
      high_score[2] = player.body.size
    end
  end

  -- Jogador colidindo com as paredes.
  function playerWallCollision ()

    --Trabalho 05
    	-- Nome: '-'
      -- Binding time: compilação
      -- Propriedade: semantica
    	-- Explicação: A subtração é definido em tempo de compilação do programa de acordo com o tipo valores da subtração

    if player.pos.current.x <= 10 or player.pos.current.x >= screenWidth-10 - default_block_size  or player.pos.current.y <= 20  or player.pos.current.y >= screenHeight-10 -default_block_size then
      player.body.speed = 0
      gameOver()
    end
  end

  --Jogador colidindo com alguma comida
  function foodCollision(player , food)
    -- Trabalho 08
    local _x_food,_y_food = food.get()
    return ( player.pos.current.x + default_block_size >= _x_food ) and ( player.pos.current.x <= _x_food + default_block_size) and ( player.pos.current.y + default_block_size >= _y_food) and ( player.pos.current.y <= _y_food + default_block_size )
  end

  -- Jogador colidindo com algum outro bloco
  function blockCollision (player, block)

    return ( player.pos.current.x + default_block_size >= block.pos.x ) and ( player.pos.current.x <= block.pos.x + default_block_size) and ( player.pos.current.y + default_block_size >= block.pos.y) and ( player.pos.current.y <= block.pos.y + default_block_size )
  end

  function love.update (dt)

    -- Splash Screen sendo executada
    if loading then

      splash:update(dt)
      return true
    end

    -- Acumulador do dt.
    accumulator.current = accumulator.current + dt

    -- Limita o tickRate do jogo e verifica gameOver.
    if (accumulator.current >= accumulator.limit and gameover == false) then

      accumulator.current = accumulator.current-accumulator.limit;

      -- Guarda a posição antiga do jogador.
      player.pos.previous.x = player.pos.current.x
      player.pos.previous.y = player.pos.current.y

      -- Atualiza a posição atual do jogador.
      player.pos.current.x = player.pos.current.x + ( player.direction.x * player.body.speed * dt )
      player.pos.current.y = player.pos.current.y + ( player.direction.y * player.body.speed * dt )

      -- Verifica a colisão entre player e parede.
      playerWallCollision()

      -- Verifica a colisão entre player e seus blocos do corpo.
      for i,block in ipairs(player.body.blocks) do -- Trabalho 07: Esse loop corre a verificação se o snake colide com o objeto.
        if (blockCollision(player,block) == true) then
          player.body.speed = 0
          gameOver()
        end
      end

      -- Trabalho 08 :  Executa a coroutine
      coroutine.resume(food_deatch.walk_deatch, dt)

      if(foodCollision(player,food_deatch)) then
        player.body.speed = 0
        gameOver()
      end

      -- Colisão entre player e comida.
      if (foodCollision(player,food)) then

        tail = playerAddBlock(player.pos.previous.x , player.pos.previous.y) -- Trabalho 07 : Função responsável por criação de um novo objeto , quando ocorre a colisão do snake com a comida.

        love.audio.play( sound_eating )
        respawnPlayerFood()

      else

        tail = table.remove(player.body.blocks,player.body.size) -- Trabalho 07 : Nesta linha ocorre o desalocamento do objeto para o deslocamento do corpo na tela

        tail.pos.x = player.pos.previous.x
        tail.pos.y = player.pos.previous.y
      end



      -- Funcionamento do FILO ( First In Last Out )
      table.insert(player.body.blocks,1,tail) -- Trabalho 07 : Nesta linha ocorre adição do objeto na coleção
        --[[
        Escopo: Como o array que o objeto sera inserido é global , por consequencia ele tambem será global.
        Tempo de vida: Os objetos presente no array blocks duram ate ocorra o encerramento do programa ou o deslocamento do snake na tela.
        Alocação: A alocação ocorre na linha
          tail = playerAddBlock(player.pos.previous.x , player.pos.previous.y)  ou tail.pos.x = player.pos.previous.x , tail.pos.y = player.pos.previous.y
          Dependendo da situação do if , ja inserção ocrre na linha table.insert(player.body.blocks,1,tail).
        Desalocação: O desalocamento ocorre quando ocorre um deslocamento do snake na tela.No codigo : tail = table.remove(player.body.blocks,player.body.size).
        --]]
      -- Atualiza a pontuação.
      updatescore()


    end
  end

  -- Desenha o Jogador e seus blocos.
  function drawPlayer()

    love.graphics.setColor(255, 0, 0, 180)

    -- Desenho do Jogador. ( Cabeça )
    love.graphics.rectangle( "fill", player.pos.current.x, player.pos.current.y, default_block_size, default_block_size )

    love.graphics.setColor(0, 0, 0, 255)

    -- Desenho do Corpo.
    for i,block in ipairs(player.body.blocks) do
      love.graphics.rectangle( "fill", block.pos.x, block.pos.y, default_block_size, default_block_size )
    end

    --Desenho do status
    love.graphics.print("Body Size " .. tostring(player.body.size) , 5, 5)
    love.graphics.print("Speed " .. tostring(player.body.speed) , 150, 5)
    love.graphics.print(tostring(high_score[1]) .. ' '.. tostring(high_score[2]) , screenWidth-150, 5)

    -- Mostra a posição do Jogador.
    if (debug == true) then
      love.graphics.print("x " .. tostring(player.pos.current.x) , screenWidth-150, 20)
      love.graphics.print("y " .. tostring(player.pos.current.y) , screenWidth-150, 30)
    end
  end

  function love.draw()

    -- Verifica se não é a SplashScreen que tem que desenhar.
    if not loading then
      -- Desenho do Cenário.
      love.graphics.line(scenarioLimits)

      -- Desenha o Jogador.
      drawPlayer()

      -- Desenho da Comida.
      if (food_deatch.isAlive()) then
        -- Trabalho 08
        local _x_food,_y_food = food_deatch.get()
        love.graphics.setColor(105,0,3)
        love.graphics.rectangle( "fill", _x_food, _y_food, default_block_size, default_block_size )
      end


      -- Desenho da Comida.
      if (food.isAlive()) then
        -- Trabalho 08
        local _x_food,_y_food = food.get()
        love.graphics.setColor(0,0,255)
        love.graphics.rectangle( "fill", _x_food, _y_food, default_block_size, default_block_size )
      end

      if(gameover) then
        love.graphics.print("Press R to restart game", screenWidth/2 - 70, screenHeight/2)
      end
    else
      -- Desenho da splashscreen
      splash:draw()
    end

  end
