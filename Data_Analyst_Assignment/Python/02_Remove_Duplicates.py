import sys

def remove_duplicates(input_string: str) -> str:
    if not isinstance(input_string, str):
        raise TypeError('Input must be a string.')

    result = ''
    for char in input_string:
        if char not in result:
            result += char
    return result


def main():
    if len(sys.argv) > 1:
        for arg in sys.argv[1:]:
            print(f'Input: {arg} -> Output: {remove_duplicates(arg)}')
    else:
        print('Usage: python 02_Remove_Duplicates.py <string1> <string2> ...')
        print('Example: python 02_Remove_Duplicates.py "mississippi" "hello world" "Bookkeeper" "aabbcc"')


if __name__ == '__main__':
    main()
