#!/usr/bin/env python
import sys
from pattern.en import suggest
from pattern.en import mood
message = sys.argv[1].split(' ')[1:]
spelling = [suggest(str(s).lower()) for s in message]
if ( not all([spell[0][1] == 1.0 for spell in spelling]) ):
    print(spelling)

message_mood = mood(" ".join(message))
if message_mood == 'imperative':
    sys.exit(0)
else:
    print("Message mood is not imperative, message mood is: " + message_mood)
    sys.exit(1)