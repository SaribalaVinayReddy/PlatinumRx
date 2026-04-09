import sys

def minutes_to_duration(minutes: int) -> str:
    if not isinstance(minutes, int):
        raise TypeError('Input must be an integer number of minutes.')
    if minutes < 0:
        raise ValueError('Minutes cannot be negative.')

    hours = minutes // 60
    remaining = minutes % 60
    hour_label = 'hr' if hours == 1 else 'hrs'
    minute_label = 'minute' if remaining == 1 else 'minutes'
    return f'{hours} {hour_label} {remaining} {minute_label}'


def main():
    if len(sys.argv) > 1:
        for arg in sys.argv[1:]:
            try:
                minutes = int(arg)
                print(f'{minutes} -> {minutes_to_duration(minutes)}')
            except ValueError:
                print(f'Error: "{arg}" is not a valid integer.')
    else:
        print('Usage: python 01_Time_Converter.py <minutes1> <minutes2> ...')
        print('Example: python 01_Time_Converter.py 130 110 45 0')


if __name__ == '__main__':
    main()
