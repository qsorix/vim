#!/usr/bin/env python3
import subprocess
import os


def get_active_directories():
    active_directories = subprocess.check_output(
        'readlink /proc/*/cwd | sort -u',
        shell=True
    ).decode('utf-8').split()

    most_specific_first = sorted(
        set(active_directories),
        key=lambda a: -len(a)
    )

    yield from most_specific_first


def get_xserver_selection():
    return subprocess.check_output(
        ['xclip', '-o']
    ).decode('utf-8')


def selection_to_location(selection):
    # strip prefixes of paths added by git diff:
    if selection.startswith('a/') or selection.startswith('b/'):
        selection = selection[2:]

    parts = selection.split(':')
    if len(parts) > 1:
        filename = parts[0]
        line = maybe_int(parts[1])
        return (filename, line)
    else:
        return (parts[0], None)


def get_selected_file_location():
    selection = get_xserver_selection()
    return selection_to_location(selection)


def edit_file(file_location):
    print("EDITING", file_location)

    filename = file_location[0]
    if file_location[1] is not None:
        filename += ':' + str(file_location[1])

    ret = subprocess.call([
        'gvim',
        '--remote-send',
        '<esc>:OpenOrShow {0}<cr>:call foreground()<cr>'.format(filename)
    ])
    if ret:
        subprocess.call([
            'gvim',
            filename
        ])


def edit_if_exists(file_location):
    if os.path.isfile(file_location[0]):
        edit_file(file_location)
        return True
    return False


def main():
    file_location = get_selected_file_location()
    print('location', file_location)

    if edit_if_exists(file_location):
        return

    for directory in get_active_directories():
        filename = os.path.join(directory, file_location[0])
        location_in_dir = tuple([filename] + list(file_location[1:]))

        if edit_if_exists(location_in_dir):
            return


def maybe_int(string):
    try:
        return int(string)
    except ValueError:
        return None


def test_selection_to_filename():
    assert selection_to_location('foo.cc') == ('foo.cc', None)
    assert selection_to_location('foo.cc:12') == ('foo.cc', 12)
    assert selection_to_location('foo.cc:22:') == ('foo.cc', 22)
    assert selection_to_location('foo.cc:32:16') == ('foo.cc', 32)

def test_selection_to_filename_on_git_diff():
    assert selection_to_location('a/foo.cc') == ('foo.cc', None)
    assert selection_to_location('b/foo.cc') == ('foo.cc', None)


if __name__ == "__main__":
    main()
