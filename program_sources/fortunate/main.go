package main

import (
	"fmt"
    "bufio"
	"os"
    "math/rand"
	"strings"
)

const (
    exitCantFindDefaultPath int = iota + 1
    exitCantOpenFile
)

func parseFile(file *os.File) []strings.Builder {
    returned, i := make([]strings.Builder, 1, 32), 0

    // Initialize first builder
    returned[i] = strings.Builder{}

    // I sure hope this works lmao
    for scanner := bufio.NewScanner(file); scanner.Scan(); {
        line := scanner.Text()
        if line == "%" {
            returned = append(returned, strings.Builder{})
            i++

            continue
        }

        returned[i].WriteString(line)
        returned[i].WriteRune('\n')
    }

    return returned
}

func main() {
	var fortunesPath string

	if len(os.Args) < 2 {
		tmpFortunesPath, err := os.UserConfigDir()
		if err != nil {
			fmt.Fprintf (
                os.Stderr,
                "\033[1;91mfatal:\033[m cannot find config directory: %s\n",
                err.Error(),
            )

			os.Exit(exitCantFindDefaultPath)
		}

		fortunesPath = tmpFortunesPath + "/fortunate/fortunes"

        // Quickly check for if the default directory and file even exist. We do it early here so
        // we can have better errors for this case
        // TODO: add said checking...
	} else {
		fortunesPath = os.Args[1]
	}

    // Attempt opening the file.
    // If that fails, error out.
    var fortunes *os.File
    {
        var err error
        fortunes, err = os.Open(fortunesPath)
        if err != nil {
			fmt.Fprintf (
                os.Stderr,
                "\033[1;91mfatal:\033[m cannot open \"%s\": %s\n",
                fortunesPath,
                err.Error(),
            )

			os.Exit(exitCantOpenFile)
        }
    }

    // Read the file line-by line, and return an array containing string builders for each segment
    // of the file
    parsedFortunes := parseFile(fortunes)
    fmt.Print(parsedFortunes[rand.Intn(len(parsedFortunes))].String())

    fortunes.Close()
}

