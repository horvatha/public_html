#!/usr/bin/env python
# coding: utf-8

"""Docstring of the module test_htmltabla
"""

__author__ = 'Arpad Horvath'

import htmltabla
import unittest

class TestTable(unittest.TestCase):
    def test_table(self):
        elemek = [(1, "alma", 2)]*3
        print elemek
        print htmltabla.htmltabla(elemek)

if __name__ == "__main__":
        unittest.main()

