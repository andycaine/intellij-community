#! /bin/bash
#
# This script updates your IntelliJ IDEA CE installation from the latest compiled classes. This way you can easily
# upgrade your working IDEA to the latest changes.
#
# Before you run the script, ensure you have the following:
# 1. Your project for IntelliJ IDEA CE is fully built (do 'Rebuild Project' if you're not sure)
# 2. WORK_IDEA_HOME points to the directory of IntelliJ IDEA build you want to upgrade
# 3. DEV_IDEA_HOME points to the directory of the project you built at step 1
# 4. You quit IntelliJ IDEA

if [ ! -f "$WORK_IDEA_HOME/bin/inspect.sh" ]; then
  echo "WORK_IDEA_HOME must be defined and point to build you're updating."
  exit
fi

if [ ! -f "$DEV_IDEA_HOME/build/update.sh" ]; then
  echo "DEV_IDEA_HOME must be defined and point to source base you're updating from."
  exit
fi

echo "Updating $WORK_IDEA_HOME from compiled classes in $DEV_IDEA_HOME"

ANT_HOME="$DEV_IDEA_HOME/lib/ant"
java -Xms64m -Xmx512m -Dant.home="$ANT_HOME" -classpath "$ANT_HOME/lib/ant-launcher.jar" org.apache.tools.ant.launch.Launcher \
 -f build/update.xml $TARGET

rm -rf $WORK_IDEA_HOME/lib
rm -rf $WORK_IDEA_HOME/plugins

cp -R $DEV_IDEA_HOME/out/deploy/* $WORK_IDEA_HOME
