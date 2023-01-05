import "CoreLibs/timer"
import "CoreLibs/sprites"
import "CoreLibs/graphics"

local gfx = playdate.graphics



local grid
local sDir = 's'
local HEIGHT = 240
local WIDTH = 400
local SEGMENT_SIZE = 40
local SEGMENT_BORDER_SIZE = 8
local SEGMENT_BORDER_SIZE_MULT = 1
local DEBUG = true

local sX = 5
local sY = 5

local tickTimer = nil

gfx.setColor(gfx.kColorBlack)
gfx.setBackgroundColor(gfx.kColorWhite)


function playdate.update()

    gfx.clear()
    local backgroundImg = gfx.image.new('images/brian')
    backgroundImg:draw( WIDTH /2 - backgroundImg.width/2, 0)
    drawGrid()
    --restoreGrid()
    playdate.drawFPS(0,0)
    playdate.timer.updateTimers()

    if DEBUG then
        debugCountGridZeros()
        print("(x,y) ", sX, sY);
    end
    

end

function playdate.leftButtonDown()
	sDir = 'w'
end

function playdate.rightButtonDown()
	sDir = "e"
end

function playdate.upButtonDown()
	sDir = "n"
end

function playdate.downButtonDown()
	sDir = "s"
end





function initGrid()
    grid = {}
    for i = 1, WIDTH / SEGMENT_SIZE do
        grid[i] = {}

        for j = 1, HEIGHT / SEGMENT_SIZE  do
            grid[i][j] = 1 -- Fill the values here
        end
    end
end

initGrid()


function drawGrid()

    for i = 1, WIDTH / SEGMENT_SIZE do
        for j = 1, HEIGHT / SEGMENT_SIZE  do

            if sX == i and sY == j then
                print("here!")
                grid[i][j] = -10;
            end

            

            if grid[i][j] > 0 then
                
                local x_pos = (i - 1) * SEGMENT_SIZE
                local y_pos = (j - 1) * SEGMENT_SIZE
                gfx.setColor(gfx.kColorWhite)
                gfx.fillRect(
                    (x_pos + SEGMENT_BORDER_SIZE / 2) -1, 
                    (y_pos + SEGMENT_BORDER_SIZE / 2) -1, 
                    (SEGMENT_SIZE - (SEGMENT_BORDER_SIZE / 2)) + 2, 
                    (SEGMENT_SIZE - (SEGMENT_BORDER_SIZE / 2)) + 2)
                gfx.setColor(gfx.kColorBlack)
                
                    
                    gfx.fillRect(
                    x_pos + SEGMENT_BORDER_SIZE / 2, 
                    y_pos + SEGMENT_BORDER_SIZE / 2 , 
                    SEGMENT_SIZE - (SEGMENT_BORDER_SIZE / 2), 
                    SEGMENT_SIZE - (SEGMENT_BORDER_SIZE / 2))
                
            end
        end
    end
end




function moveSnake()
    if sDir == "n" then
        sY -= 1
    elseif sDir == "e" then
        sX += 1
    elseif sDir == "s" then
        sY += 1
    elseif sDir == "w" then
        sX -= 1
    end
end

function restoreGrid()
    for i = 1, WIDTH / SEGMENT_SIZE do
        for j = 1, HEIGHT / SEGMENT_SIZE  do
            grid[i][j] += 1
        end
    end
end

function tickEvent()
    moveSnake()
    --restoreGrid()
end


tickTimer = playdate.timer.keyRepeatTimerWithDelay(500,500,tickEvent)


function debugCountGridZeros()
    local count = 0
    for i = 1, WIDTH / SEGMENT_SIZE do
        for j = 1, HEIGHT / SEGMENT_SIZE  do
            if grid[i][j] == 0 then
                count += 1
            end
        end
    end

    print("debugCountGridZeros: ", count)
end




