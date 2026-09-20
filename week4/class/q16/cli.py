import argparse
import sys


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--name", required=True)
    a = p.parse_args()

    if not a.name or a.name.isspace():
        sys.exit(2)

    print("Hello, name!")


if __name__ == "__main__":
    main()
