package main

import "fmt"

func main() {
	fmt.Println()
}

func sum(num, num2 int) (int, error) {
	return num + num2, nil
}
