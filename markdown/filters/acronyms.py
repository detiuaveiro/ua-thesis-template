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

if __name__ == "__main__":
    with open("metadata.yaml", "r") as f:
        try:
            acros = yaml.safe_load(f)['acronyms']
            acronyms = {e['short']: e['long'] for e in acros}
        except yaml.YAMLError as exc:
            pass
    pf.toJSONFilter(replace_acronyms)
