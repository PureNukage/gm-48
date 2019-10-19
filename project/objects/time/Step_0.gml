frames++
stream++

if frames >= 60 {
	seconds++
	frames = 0
}

if seconds >= 60 {
	minutes++
	seconds = 0
}