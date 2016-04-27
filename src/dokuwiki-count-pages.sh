#!/bin/bash
#
# This script counts the amount of pages in a DokuWiki installation
# Run this in the root of your DokuWiki installation
#
# Author: Xavier Decuyper <www.savjee.be>
# ---------------------------------------------------------------------------

find ./data -name '*.txt' | wc -l