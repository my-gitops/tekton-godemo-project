package main

import "devops-gin-test/initRouter"

func main() {
	router := initRouter.SetupRouter()
	_ = router.Run()
}
