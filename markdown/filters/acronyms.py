import pandocfilters as pf
import yaml

# Acronyms set 
acronyms = {}

acros = None

acrocnt = {}

def replace_acronyms(key, value, format, meta):
    if key == 'Str':
        # Check if the text is an acronym
        acronym = value
        a = acronym.lower()
        c = ''
        if not a[-1].isalnum():
            c = a[-1].lower()
            a = a[:-1]
        if a.endswith('s'): # separate if 's' because a plural acronym can end with punctuation
            c = a[-1].lower() + c
            a = a[:-1]
        if value.startswith('_'):
            return [pf.RawInline('latex', f'{value[1:]}')]
        if a in acronyms:
            cnt = acrocnt.get(a)
            if cnt is None:
                acrocnt[a] = 1
                return None
            elif cnt < 2:
                acrocnt[a] = 2
                return None
            else:
                return [pf.RawInline('latex', '\\ac{' + a + '}' + c)]

if __name__ == "__main__":
    with open("metadata.yaml", "r") as f:
        try:
            acros = yaml.safe_load(f)['acronyms']
            acronyms = {e['id'] for e in acros}
        except yaml.YAMLError as exc:
            pass
    pf.toJSONFilter(replace_acronyms)
