var _random = irandom_range(6,9)
wait_time = time.seconds + _random

debug_log("I am waiting for "+string(_random)+" seconds until "+string(wait_time))