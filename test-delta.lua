-- Delta Diagnostic Test
print("=== DELTA DIAGNOSTIC ===")

-- Test 1: HttpGet
local httpSuccess, httpResult = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/akiwserverus-prog/akiw/main/maw-farm-minimal.lua")
end)
print("HttpGet:", httpSuccess, type(httpResult))

-- Test 2: loadstring
local loadSuccess, loadResult = pcall(function()
    return loadstring("print('test')")
end)
print("loadstring:", loadSuccess, type(loadResult))

-- Test 3: Combined
if httpSuccess and type(httpResult) == "string" then
    local combined = pcall(function()
        local func = loadstring(httpResult)
        if func then
            func()
        else
            print("loadstring return nil")
        end
    end)
    print("Combined:", combined)
end

print("=== END DIAGNOSTIC ===")
