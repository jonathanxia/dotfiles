import os
SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def FindCorrespondingSourceFile(filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                return replacement_file
    return filename


def Settings(**kwargs):
    if kwargs['language'] == 'cfamily':
        filename = FindCorrespondingSourceFile(kwargs['filename'])
        if kwargs['filename'].endswith('.cpp'):
            return {
                    'flags': ['-x', 'c++', '-Wall', '-Wextra', '-Werror'],
                    'override_filename': filename
                    }
        else:
            return {
                    'flags': ['-x', 'c', '-Wall', '-Wextra', '-Werror'],
                    'override_filename': filename
                    }
    else:
        return {
                'interpreter_path': '/usr/local/bin/python',
                'sys_path': [
                    '/prod/tools/base/lib/python/',
                    '/prod/tools/eq/src/lib/python/',
                    '/codemill/xiaj/algor/exploded_algor/'
                    ]
                }
