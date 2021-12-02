local joinTable = function (t)
	local s = ""
	for i = 1, #t do
		if i == 1 then
			s = s .. (t[i])
		else
			s = s .. (t[i]:gsub("^%l", string.upper))
		end
	end
	return s
end

ConvertWord = function (word, shouldReturn)
	local v = vim.split(word, "_")
	local s = ""
	local isFirst = true
	if #v == 1 then
		for i in word:gmatch"." do
			if i == string.upper(i) then
				if isFirst then
					s = s .. i
					isFirst = false
				else
					s = s .. "_" .. string.lower(i)
				end
			else
				s = s .. i
			end
		end
		if shouldReturn then
			return s
		else
			vim.cmd("normal! ciw" .. s)
			return nil
		end
	else
		local vi = joinTable(v)
		if shouldReturn then
			return vi
		else
			vim.cmd("normal! ciw" .. vi)
			return nil
		end
	end
end

return {
	ConvertWord = ConvertWord
}
