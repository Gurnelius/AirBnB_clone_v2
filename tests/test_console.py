#!/usr/bin/python3
import unittest
from unittest.mock import patch
from io import StringIO
from  console import HBNBCommand 

class TestHBNBCommand(unittest.TestCase):
    @patch('sys.stdout', new_callable=StringIO)
    def test_create_object_with_missing_class_name(self, mock_stdout):
        cmd = HBNBCommand()
        cmd.do_create("")
        output = mock_stdout.getvalue().strip()
        self.assertEqual(output, "** class name missing **")

    @patch('sys.stdout', new_callable=StringIO)
    def test_create_object_with_invalid_class_name(self, mock_stdout):
        cmd = HBNBCommand()
        cmd.do_create("InvalidClass name=\"California\"")
        output = mock_stdout.getvalue().strip()
        self.assertEqual(output, "** class doesn't exist **")

    # Add more test cases as needed

if __name__ == '__main__':
    unittest.main()
