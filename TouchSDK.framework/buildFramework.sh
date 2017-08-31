PROJECT_NAME=ChatView
BUILD_DIR=$PWD/Build/Products
BUILD_ROOT=$PWD/Build/Products
CONFIGURATION=Debug

echo "${BUILD_DIR}"
echo "${BUILD_ROOT}"

PROJECT="${PROJECT_NAME}"
BDIR=""
PROD="${PROJECT}"

if [ "$1" != "" ]; then
    PROJECT="$1"
    BDIR="/${PROJECT}"
    IN="${PROJECT}"
    set -- "$IN"
    IFS="."; declare -a Array=($*)
    PROD="${Array[0]}"
fi


echo Building "${PROJECT} -> ${BDIR}"

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

echo "Build Device and Simulator versions"
xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build> /dev/null
if [[ $? -ne 0 ]] ; then
echo "${PROJECT}/iphoneos/${CONFIGURATION} -> Failed"
exit -1
else
echo "${PROJECT}/iphoneos/${CONFIGURATION} -> Done!"
fi

xcodebuild -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${PROJECT}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build> /dev/null
if [[ $? -ne 0 ]] ; then
echo "${PROJECT}/iphonesimulator/${CONFIGURATION} -> Failed"
exit -1
else
echo "${PROJECT}/iphonesimulator/${CONFIGURATION} -> Done!"
fi


echo "Copy the framework structure (from iphoneos build) to the universal folder"
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos${BDIR}/${PROD}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"

echo "Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory"
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator${BDIR}/${PROD}.framework/Modules/${PROD}.swiftmodule/."
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/${PROD}.framework/Modules/${PROD}.swiftmodule"
fi

echo "Create universal binary file using lipo and place the combined executable in the copied framework directory"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${PROD}.framework/${PROD}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator${BDIR}/${PROD}.framework/${PROD}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos${BDIR}/${PROD}.framework/${PROD}"

echo "${PROJECT}/ALL/${CONFIGURATION} -> Done!"

# Step 6. Convenience step to open the project's directory in Finder
