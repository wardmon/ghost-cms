// Command text is a chromedp example demonstrating how to extract text from a
// specific element.
package main

import (
	"context"
	"log"
	"strings"

	"github.com/chromedp/chromedp"
)

func main() {
	// create context Documentation-overview
	ctx, cancel := chromedp.NewContext(context.Background())
	defer cancel()

	// run task list
	var res string
	err := chromedp.Run(ctx,
		chromedp.Navigate(`https://hsck.net`),
		chromedp.Text(`.body`, &res, chromedp.NodeVisible),
	)
	if err != nil {
		log.Fatal(err)
	}

	log.Println(strings.TrimSpace(res))
}
