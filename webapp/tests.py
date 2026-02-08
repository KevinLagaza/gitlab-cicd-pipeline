from app import app
import unittest


class AppTestCase(unittest.TestCase):

    def test_root_text(self):
        tester = app.test_client(self)
        response = tester.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Hello world!', response.data)


if __name__ == '__main__':

    unittest.main()
