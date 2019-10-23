package qctclient

import "github.com/quickchainproject/quickchain"

// Verify that Client implements the quickchain interfaces.
var (
	_ = quickchain.ChainReader(&Client{})
	_ = quickchain.TransactionReader(&Client{})
	_ = quickchain.ChainStateReader(&Client{})
	_ = quickchain.ChainSyncReader(&Client{})
	_ = quickchain.ContractCaller(&Client{})
	_ = quickchain.GasEstimator(&Client{})
	_ = quickchain.GasPricer(&Client{})
	_ = quickchain.LogFilterer(&Client{})
	_ = quickchain.PendingStateReader(&Client{})
	// _ = quickchain.PendingStateEventer(&Client{})
	_ = quickchain.PendingContractCaller(&Client{})
)
