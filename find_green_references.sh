#!/bin/bash

# Search for references to android:color/green in all XML files
grep -r "android:color/green" --include="*.xml" .

# Search for references to android:color/green in all Java files
grep -r "android.R.color.green" --include="*.java" .