pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
llama = {x=100, y=100, s=16, animating = false, left=true}
spitleft = {16,17,18,16}
spitright = {32,33,34,32}
index = 0
animation_speed = 0.5
animation_timer = 0
spits = {} 

function _init()
make_enm(rnd(126),rnd(126))
make_enm(rnd(126),rnd(126))
end

function _update()
	timer()
	for i, f in pairs(enm) do
		enm_move(f)
	end
	
	if btn(➡️) then 
		llama.x = llama.x+1
		llama.left = false
		llama.s=32
	end
	if btn(⬅️) then 
		llama.x = llama.x-1 
		llama.left = true
		llama.s=16
	end
	if btn(⬇️) then 
		llama.y = llama.y+1
	end
	if btn(⬆️) then 
		llama.y = llama.y-1
	end
	if btnp(❎) then
		spit()
	end
	
	for i = #spits, 1, -1 do
		local llamaspit = spits[i]
		llamaspit.x = llamaspit.x + llamaspit.dx
		
		if llamaspit.x > 128 then
			del(spits, i)

		end
	end
	if llama.animating == true then
		if llama.left == true then
			llama.s = spitleft[index]
			index = index + 1
			
			if index >= #spitleft then
				index = 1     
				llama.s=16
				llama.animating = false
			end
  	elseif llama.left == false then
		llama.s = spitright[index]
		index = index + 1
		
		if index >= #spitright then
			index = 1
			llama.s=32
			llama.animating = false
		end 
		
	end
end
end
	
function spit()
	llama.animating = true
	shootspit()
end	
       
function shootspit()
	add(spits,{x=llama.x, y=llama.y, dx= llama.left and -2 or 2})
end


function _draw()
	cls()
	map(0,0,0,0,128,32)
	spr(llama.s, llama.x, llama.y)
	for llamaspit in all(spits) do
		spr(3, llamaspit.x, llamaspit.y)
	end
	foreach(enm, draw_enm)	
end
		
		
-->8
--enemies
enm={}
function enm_move(f)
	if f.x<=0 then 
		f.x = 125 
	end
	if f.x>=127 then 
		f.x = 0 
	end
	if f.y<=0 then 
		f.y = 125 
	end
	if f.y>=128 then 
		f.y = 0 
	end
	
	if tm==15 or tm==29 then
		f.rn=flr(rnd(4))
	end
	 
	if f.rn==0 then 
		f.x+=f.speed 
	end
	if f.rn==1 then 
		f.x-=f.speed 
	end
	if f.rn==2 then 
		f.y+=f.speed 
	end
	if f.rn==3 then 
		f.y-=f.speed 
	end
	
	lc=0
	col=false
	for llamaspit in all(spits) do
		local dist = sqrt((llamaspit.x - f.x) ^ 2 + (llamaspit.y - f.y) ^ 2)
		if dist < 8 then
			lc += 1
		end
		-- if llamaspit.x <= f.x and f.x <= llamaspit.x+3 or
		-- 	llamaspit.x <= f.x+3 and f.x+3 <= llamaspit.x+3 then 
		-- 	lc += 1
		-- end
		-- if llamaspit.y <= f.y and f.y <= llamaspit.y +3 or
		-- 	llamaspit.y <= f.y+3 and f.y+3 <= llamaspit.y+3 then 
		-- 	lc +=1
		-- end
	
		if lc >=1 then 
			col=true 
		end
		if lc >=3 then 
			dead=true 
		end
	end
	if col == true then 
		f.animating = true
	end
	enmindex = 0
	enminjure = {64,65,64,65,64}
	if f.animating then
		f.sprite = enminjure[enmindex]
		enmindex = enmindex + 1
		if enmindex >= #enminjure then
			enmindex = 1
			f.sprite = 64
			f.animating = false	
		end
		
	end

end
function make_enm(x,y)
	local f = {}
	f.x=x
	f.y=y
	f.speed=1
	f.animating=false
	//f.rn=0
	
	f.rn = flr(rnd(4))
	f.sprite=64
	add(enm,f)
end
function draw_enm(f)
spr(f.sprite,f.x,f.y)
end
function rand()
end
tm=0
function timer()
	tm+=1
	if tm>=30 then tm = 0 end
end
	

__gfx__
00000000bbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbb7b7bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbbbbbbbabbbb00000aaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbbbbbbbb737bbb00000aa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbbbbbbbbb3bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbbbbbbb33bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbbb3bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07070000007070000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07070000007070000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e7e0000007e700007e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07f700000af77000af77000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0077000000770000a077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777007777770077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777007777770077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700007007000070070000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007070000707000000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007070000707000000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000e7e00007e70000007e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007f7000077f00000077fa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007700000777000000770a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777700777777007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777700777777007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000700700007007000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04004000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09999004077770070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a9a9004077770070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49999999777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00909049007070770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00909049007070770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010102010101010102010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101020101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101020101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101020101010101010102010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010201010102010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101020101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010102010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010201010101010201010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010102010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
