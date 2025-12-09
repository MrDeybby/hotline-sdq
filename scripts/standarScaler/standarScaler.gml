function standarScaler(max_value, min_value, value) {
	if max_value == min_value{
		return 0
	}
    return (value - min_value) / (max_value - min_value)
}