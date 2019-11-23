#  SpellChecker for Xcode

## Usage

Write to your `Run script` like a below code.

```shellscript
git_path=/usr/local/bin/hub
files=$($git_path diff --name-only -- "*.swift" "*.h" "*.m")
if [ ${#files[@]} -eq 0 ]; then
  exit 0
fi

options=""
for file in $files
do
  options="$options $SRCROOT/$file"
done

/usr/local/bin/SpellChecker -yml $SRCROOT/swift-keywords.yaml -- $options

```
