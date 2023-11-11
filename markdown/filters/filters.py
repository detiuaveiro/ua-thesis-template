import pandocfilters as pf
import yaml

# Acronyms dictionary
acronyms = {}

acros = None

acrocnt = {}

def replace_acronyms(key, value, format, meta):
    if key == 'Str':
        # Check if the text is an acronym
        acronym = value
        if (a := acronym.upper()) in acronyms:
            cnt = acrocnt.get(a)
            if cnt is None:
                acrocnt[a] = 1
                return None
            elif cnt < 2:
                acrocnt[a] = 2
                return None
            else:
                return [pf.RawInline('latex', '\\ac{' + acronym.lower() + '}')]

def heading(key, value, format, meta):
    if key == 'Header':
        # Check if it's a level-1 header
        if value[0] == 1:
            # Replace the header with a LaTeX section command
            return pf.RawBlock('latex', '\\section{' + value[2][0]['c'] + '}')

def all_filters(key, value, format, meta):
    # Call the functions for acronym replacement and section heading conversion
    filtered_value = replace_acronyms(key, value, format, meta) or heading(key, value, format, meta)
    return filtered_value

if __name__ == "__main__":

    with open("metadata.yaml", "r") as f:
        try:
            acros = yaml.safe_load(f)['acronyms']
            acronyms = {e['short']: e['long'] for e in acros}
        except yaml.YAMLError as exc:
            pass
    pf.toJSONFilter(all_filters)
