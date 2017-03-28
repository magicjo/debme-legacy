#!/usr/bin/env python

# IMPORT
import base64


# Proverbs from http://www.phrasemix.com/collections/the-50-most-important-english-proverbs
# EXPORT
def foo_bar(foo_bar_count):
    if foo_bar_count == 1:
        print(base64.b64decode(
            'CiJQcmFjdGljZSBtYWtlcyBwZXJmZWN0LiIKWW91IGhhdmUgdG8gcHJhY3RpY2UgYSBza2lsbCBhIGxvdCB0byBiZWNvbWUgZ29vZCBhdCBpdC4KICAgICAgICA='))
    elif foo_bar_count == 2:
        print(base64.b64decode(
            'CiJFYXN5IGNvbWUsIGVhc3kgZ28uIgpXaGVuIHlvdSBnZXQgbW9uZXkgcXVpY2tseSwgbGlrZSBieSB3aW5uaW5nIGl0LCBpdCdzIGVhc3kgdG8gc3BlbmQgaXQgb3IgbG9zZSBpdCBxdWlja2x5IGFzIHdlbGwuCiAgICAgICAg'))
    elif foo_bar_count == 3:
        print(base64.b64decode(
            'CiJCZWF1dHkgaXMgaW4gdGhlIGV5ZSBvZiB0aGUgYmVob2xkZXIuIgpEaWZmZXJlbnQgcGVvcGxlIGhhdmUgZGlmZmVyZW50IGlkZWFzIGFib3V0IHdoYXQncyBiZWF1dGlmdWwuCiAgICAgICAg'))
    elif foo_bar_count == 4:
        print(base64.b64decode(
            'CiJEb24ndCBwdXQgYWxsIHlvdXIgZWdncyBpbiBvbmUgYmFza2V0LiIKSGF2ZSBhIGJhY2t1cCBwbGFuLiBEb24ndCByaXNrIGFsbCBvZiB5b3VyIG1vbmV5IG9yIHRpbWUgaW4gb25lIHBsYW4uCiAgICAgICAg'))
    elif foo_bar_count == 5:
        print(base64.b64decode(
            'CiJUd28gaGVhZHMgYXJlIGJldHRlciB0aGFuIG9uZS4iCldoZW4gdHdvIHBlb3BsZSBjb29wZXJhdGUgd2l0aCBlYWNoIG90aGVyLCB0aGV5IGNvbWUgdXAgd2l0aCBiZXR0ZXIgaWRlYXMuCiAgICAgICAg'))
    elif foo_bar_count == 6:
        print(base64.b64decode(
            'CiJZb3UgY2FuIGxlYWQgYSBob3JzZSB0byB3YXRlciwgYnV0IHlvdSBjYW4ndCBtYWtlIGhpbSBkcmluay4iCklmIHlvdSB0cnkgdG8gaGVscCBzb21lb25lLCBidXQgdGhleSBkb24ndCB0YWtlIHlvdXIgYWR2aWNlIG9yIG9mZmVycywgZ2l2ZSB1cC4gWW91IGNhbid0IGZvcmNlIHNvbWVvbmUgdG8gYWNjZXB0IHlvdXIgaGVscC4KICAgICAgICA='))
    elif foo_bar_count == 7:
        print(base64.b64decode(
            'CiJJZiB5b3Ugd2FudCBzb21ldGhpbmcgZG9uZSByaWdodCwgeW91IGhhdmUgdG8gZG8gaXQgeW91cnNlbGYuIgpEb24ndCB0cnVzdCBvdGhlciBwZW9wbGUgdG8gZG8gaW1wb3J0YW50IHRoaW5ncyBmb3IgeW91LiBZb3UgaGF2ZSB0byBkbyB0aGluZ3MgeW91cnNlbGYgdG8gY29udHJvbCB0aGUgcXVhbGl0eSBvZiB0aGUgcmVzdWx0cy4KICAgICAgICA='))
    elif foo_bar_count == 8:
        print(base64.b64decode('Ck5vIG1vcmUgcHJvdmVyYiBhdmFpbGFibGUsIHNvcnJ5CiAgICAgICAg'))
    elif foo_bar_count == 9:
        print(base64.b64decode('ClNlcmlvdXNseSwgdGhlcmUgYXJlIG5vIG1vcmUgcHJvdmVyYnMgYXZhaWxhYmxlCg=='))
    else:
        for i in range(9, foo_bar_count):
            print(
                base64.b64decode(
                    'QXJlIHlvdSBzdHVwaWQsIGJlY2F1c2UgSSB0b2xkIHlvdSB0aGVyZSB3YXMgbm90aGluZyBlbHNlIGFmdGVy'))
