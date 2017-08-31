sh ./clean.sh
/usr/local/bin/pod update

if [ $? != 0 ]; then
echo "Pods failed"
exit 1
fi

sh ./buildFramework.sh
CURR_DIR=$PWD
BUILD_DIR=$PWD/Build/Products
CONFIGURATION=Debug

cd "${BUILD_DIR}/Debug-universal/"
echo $PWD
zip -r "${BUILD_DIR}/../../Build/$1.zip" ./
