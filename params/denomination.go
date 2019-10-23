package params

const (
	// These are the multipliers for ether denominations.
	// Example: To get the wei value of an amount in 'TenKWei', use
	//
	//    new(big.Int).Mul(value, big.NewInt(params.TenKWei))
	//
	Wei        = 1
	GWei       = 1e9
	QCT	   = 1e18
)
