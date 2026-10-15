import pandocfilters as pf

def replace_citations(key, value, format, meta):
    if key == 'Cite':
        return [
            pf.RawInline('latex', '\\cite{' + v['citationId'] + '}')
            for v in value[0]
        ]

if __name__ == "__main__":
    pf.toJSONFilter(replace_citations)
