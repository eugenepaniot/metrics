local metrics = require('metrics')

local TNT_PREFIX = 'tnt_'
local utils = {}

function utils.set_gauge(name, description, value, labels, prefix)
    prefix = prefix or TNT_PREFIX
    local gauge = metrics.gauge(prefix .. name, description)
    gauge:set(value, labels or {})
    return gauge
end

function utils.set_counter(name, description, value, labels, prefix)
    prefix = prefix or TNT_PREFIX
    local counter = metrics.counter(prefix .. name, description)
    counter:reset(labels or {})
    counter:inc(value, labels or {})
    return counter
end

function utils.box_is_configured()
    local is_configured = type(box.cfg) ~= 'function'
    if is_configured then
        utils.box_is_configured = function() return true end
    end
    return is_configured
end

return utils
