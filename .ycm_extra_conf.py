def Settings( **kwargs ):
    if kwargs['filename'].endswith('.cpp'):
        return {
            'flags': ['-x', 'c++', '-Wall', '-Wextra', '-Werror']
        }
    else:
        return {
            'flags': ['-x', 'c', '-Wall', '-Wextra', '-Werror']
        }
