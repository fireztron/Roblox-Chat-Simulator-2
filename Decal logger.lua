--[[
    Logs will look like this:

        exampleplayer 07:49 PM: this is message 1
        rbxthumb://type=Asset&id=1522361034&w=420&h=420

        exampleplayer 07:50 PM: this is message 2
        rbxthumb://type=Asset&id=1522361034&w=420&h=420
]]

--// Log text function
local function logText(fileName, txt)
    if isfile(fileName) then
        appendfile(fileName, txt)
    else
        writefile(fileName, txt)
    end
end

--// Checks for new messages
game:GetService("Players").LocalPlayer.PlayerGui.Screen.Background.Server.ChannelFrame.ChatZone.ChildAdded:Connect(function(msg)
    local authortext = msg:WaitForChild("AuthorText")
    local Content = authortext:FindFirstChild("Content")
    if Content then
        local ImageFrame = Content:FindFirstChild("Image")
        if ImageFrame then
            local ImageLabel = ImageFrame:FindFirstChild("ImageLabel")
            if ImageLabel then
                --// Wait until image ID is loaded
                while not ImageLabel.IsLoaded do wait() end

                --// Logs the message + id
                local imageId = ImageLabel.Image
                if string.find(imageId, "://") then
                    logText("loggedImages.txt", authortext.Text .. ": " .. Content.Text .. "\n" .. imageId .. "\n\n")
                end
            end
        end
    end
end)
print("loaded decal logger")
