-- Dev: Mike016
-- while loop
print("While Loop:")
local i = 1
while i <= 5 do
    print(i)
    i = i + 1
end

-- for loop (numeric)
print("\nFor Loop (Numeric):")
-- i = start until
for i = 1, 5 do
    print(i)
end

-- for loop (numeric with step)
print("\nFor Loop (Numeric with Step):")
-- i = start stop step
for i = 1, 10, 2 do
    print(i)
end

-- ipairs for loop (iterating over an array/table)
print("\nFor Loop (Iterating over basic Array/Table):")
-- index start 1
local array = {"apple", "banana", "cherry"}
for index, v in ipairs(array) do
    print(index, v)
end

-- pairs loop (iterating over key-value pairs in a table)
print("\nPairs Loop (Iterating over Key-Value Pairs):")
local table = {name = "John", age = 30, city = "New York"}
for k, v in pairs(table) do 
    --[[
        --Credit:basbas1234 
        table ที่เป็น dict (key-value) เวลาใช้ pairs มันเรียง key ใหม่ตามตัวอักษร a-z กับ for loop 
        และก็ใน table key ก็สามารถใส่เป็น table ซัอนกันได้เป็นทริค แต่ๆๆ key มันจะไม่เรียง
        สุ่มตาม address ของ ram table คือ address เวลาประกาศ
        code: Ex.
        local a = {}
        local b = {}
        print(a == b) มันจะเป็น false เพราะ address ต่างกัน
    ]]--
    print(k, v)
end


-- repeat...until loop
print("\nRepeat...Until Loop:")
local x = 1
repeat
    print(x)
    x = x + 1
until x > 5 -- condition == true it wil stop
--[[
    while loop ใช้เพื่อรันบล็อกโค้ดซ้ำ ๆ ตราบใดที่เงื่อนไขเป็นจริง
    for loop (ตัวเลข) ใช้เพื่อวนซ้ำช่วงของค่าตัวเลข
    for loop (ตัวเลขพร้อมขั้นตอน) ใช้เพื่อวนซ้ำช่วงของค่าตัวเลขตามขั้นตอนที่ระบุ
    for loop (การวนซ้ำบนอาร์เรย์/ตาราง) ใช้เพื่อวนซ้ำองค์ประกอบของอาร์เรย์หรือคู่คีย์-ค่าของตารางโดยใช้ ipair
    ipairs loop ใช้เพื่อวนซ้ำ basic table ex. local array = {"apple", "banana", "cherry"} use only index to access value
    pairs loop ใช้เพื่อวนซ้ำ key-value in table ex. local table = {name = "John", age = 30, city = "New York"} use index and key to access value
    repeat...until loop ใช้เพื่อดำเนินการบล็อกโค้ดซ้ำ ๆ จนกว่าเงื่อนไขจะเป็นจริง มันจะดำเนินการบล็อกอย่างน้อยหนึ่งครั้งเสมอคล้าย Do while loop

]]--

-- use nested Loop for some data patterns
local keyValueTable = {{name = 'mike',age = 21},{name = 'bass' , age = 21}} -- is different with local table = {name = "John", age = 30, city = "New York"}
for i = 1 , #keyValueTable do
    for key, value in pairs(keyValueTable[i]) do
       print("index =  "..key.." value = "..value)
    
    end
end

