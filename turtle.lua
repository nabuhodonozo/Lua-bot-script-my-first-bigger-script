-------************************-------
-----							 -----	
----- 	  Turtle minning bot	 -----
-----	         or              -----	
-----							 -----	
-----	                         -----	
-------************************-------


	-------	************************ -------
-----									 	-----	
----- 				TO DO :				 	-----
-----									  	-----	
-----	Dig up or go down               	-----
-----	Fix dropTrash						-----	
-----	Fix full() works too slow	  		-----	
-----	Clean screen				  		-----	
-----	More funny sentences		  		-----	
-----	Turtle not only diggin down and right----	
	-------	************************ -------


-- DIRECTIONS --

westeast = 0
northsouth = 0
height = 0
direction = 0


--		0
--	3		1
--		2

-- *********** --


goright=function()
	turtle.turnRight()
	direction = direction + 1
end

goleft=function()
	turtle.turnLeft()
	direction = direction - 1
end


goup=function()
	if turtle.up() then
		height = height + 1
	end
end

godown=function()
	if turtle.down() then
		height = height - 1
	end
end


retreat=function()
	mining_direction=direction
	for i=1, -height do
		turtle.up()
	end


	if direction == 1 then
		goright()
		goright()
	elseif direction == 0 then
		goright()
		goright()
		goright()
	elseif direction == 2 then
		goright()
	end

	
	for i=1,westeast do
		turtle.forward()
	end
	
	goleft()

	
	for i=1,northsouth do
		turtle.forward()
	end
end



tryforward=function()
	if turtle.forward() then
		if direction == 0 then
			northsouth = northsouth + 1
		elseif direction == 1 then
			westeast = westeast + 1
		elseif direction == 2 then
			northsouth = northsouth - 1
		elseif direction == 3 then
			westeast = westeast - 1
		end
		return true
	else
		return false
	end
end


digandgo=function()
	while tryforward()==false do
		if turtle.detect() then 
			turtle.dig()
		else 
			turtle.attack()
		end
	end
	refuel()
	full()
end


enoughfueltocomeback=function()
	if turtle.getFuelLevel() > 2*(westeast + northsouth + -height) + length*width then
		return true
	else
		return false
	end
end


gobacktowork=function()

	goright()
	goright()
	for i=1,northsouth do
		turtle.forward()
	end
	goright()

	
	for i=1,westeast do
		turtle.forward()
	end
	
	for i=1,-height do
		turtle.down()
	end

	
	
	if mining_direction == 0 then
		goleft()
	elseif mining_direction == 2 then
		goright()
	elseif mining_direction == 3 then
		goright()
		goright()
		goright()
	end
	direction=mining_direction
end


--------------***************--------------
--				  Funkcje
--				  zyciowe
--				 TURTELA!!!
--------------***************--------------


skrzynka=function()
	turtle.turnRight()
	turtle.turnRight()
	turtle.select(13)
	while not turtle.place() do
		turtle.attack()
	end
		turtle.turnRight()
		turtle.turnRight()
end



dropshit=function()
	for o=1,13 do
		turtle.select(o)
		if turtle.compareTo(16) then
			turtle.drop()
		elseif turtle.compareTo(15) then
			turtle.drop()
		elseif turtle.compareTo(14) then
			turtle.drop()
		end
	end
end


unload=function()
	for o=1,13 do
		turtle.select(o)
		turtle.drop()
	end
end


eatwungielverymuch=function()
	for o=1,13 do
		turtle.select(o)
		turtle.refuel()
	end
end


full=function()
local tempvar = 0
	for o=1,13 do
		if turtle.getItemCount(o) > 0 then
            tempvar
         = tempvar + 1
		end
	end
        if tempvar
     == 13 then
			retreat()
			unload()
			gobacktowork()
		end
end


refuel=function()
	eatwungielverymuch()
	if turtle.getFuelLevel()<(westeast + northsouth + -height+2) then
		retreat()
		while not enoughfueltocomeback() do
			print("Daj jesc!")
			if turtle.refuel() then
				print("Omn nom nom nom")
				print("Mam teraz ".. turtle.getFuelLevel().." mocy")
				if enoughfueltocomeback() then
					print("Wracam do roboty")
				else
					print("Nie badz sknera daj jeszcze")
				end
			end
			sleep(10)
		end
		gobacktowork()
	end
end



size=function()
	choice="n"
	while choice~="Y" and choice~="y" do
		print("Podaj dlugosc")
		length = tonumber(read())
		print("Podaj szerokosc")
		width = tonumber(read())
		print("Podaj glebokosc")
		depth = tonumber(read())-1
		
		print("Dlugosc: "..length.." Szerokosc: "..width.." Glebokosc: "..depth)
		choice2=null
		while choice2~="Y" and choice2~="N" and choice2~="y" and choice2~="n" do
			print("Zgadzasz sie? Y/N")
			choice2=read()
			choice=choice2
		end
	end
end


--------------***************--------------
--					MAIN
--				  PROGRAM
--------------***************--------------



size()

skrzynka()

while turtle.getFuelLevel()<10 do
	print("Za malo energii, aby pracowac!")
	sleep(10)
	turtle.refuel()
end

digandgo()
finish=false
while finish==false do
	level=true
	while level==true do
		for i=2, length do
			digandgo()
		end
		if width%2~=0 then
			if westeast+1==width and northsouth==length then
				level=false
				if height==-depth then
					finish=true
				end
			end
		end
		if(westeast+1<width) then
			goright()
			digandgo()
			goright()
			for i=2, length do
				digandgo()
			end
		end
		
		if westeast+1<width then
			goleft()
			digandgo()
			goleft()
		end
		
		
		if width%2==0 then
			if westeast+1==width and northsouth==1 then
				level=false
				if height==-depth then
					finish=true
				end
			end
		end
		
		
	end
		
	if height<depth then
		
		if direction == 0 then
			goright()
			goright()
			goright()
		elseif direction == 2 then
			goright()
		end
	
		
		for i=1,westeast do
			tryforward()
		end
		
		goleft()
	
		
		for i=2,northsouth do
			tryforward()
		end
		goleft()
		goleft()
	
	
		if height~=-depth then
			turtle.digDown()
			godown()
		end
	end
end


retreat()
print(" Robota skonczona! ")

