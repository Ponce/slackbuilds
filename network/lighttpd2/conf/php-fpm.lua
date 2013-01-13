local function phpfpm(act)
	return action.when(physical.path:suffix(".php"),
		action.when(physical.is_file:is(), act),
		action.when(request.path:eq("/fpm-status"), act)
	)
end

actions = {
	["phpfpm"] = phpfpm,
}
