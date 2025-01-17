// Copyright The Linux Foundation and each contributor to CommunityBridge.
// SPDX-License-Identifier: MIT

package utils

// StringValue function convert string pointer to string
func StringValue(input *string) string {
	if input == nil {
		return ""
	}
	return *input
}

// StringRef function convert string to string reference
func StringRef(input string) *string {
	return &input
}

// Int64Value function convert int64 pointer to string
func Int64Value(input *int64) int64 {
	if input == nil {
		return 0
	}
	return *input
}

// Int64 returns a pointer to the int64 value passed in.
func Int64(v int64) *int64 {
	return &v
}

// BoolValue function convert boolean pointer to boolean
func BoolValue(input *bool) bool {
	if input == nil {
		return false
	}
	return *input
}

// Bool function convert boolean to boolean pointer
func Bool(input bool) *bool {
	return &input
}

// GetNilSliceIfEmpty returns a nil reference is the specified slice is empty, otherwise returns a reference to the original slice
func GetNilSliceIfEmpty(slice []string) []string {
	if len(slice) == 0 {
		return nil
	}

	return slice
}
