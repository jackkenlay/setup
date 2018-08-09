# https://helpx.adobe.com/experience-manager/kb/common-AEM-Curl-commands.html

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Installing packages of current DIR:"

echo "Found packages:"

for z in *.zip; do
    # do something
    echo "  $z";
done

# TODO,
#  press Y if you want to proceed
#  check for installed packages at the end
#  check it matches the current ones. Make them green.
# curl -u admin:admin -F file=@"$z" -F name="$name" -F force="true" -F install="true" http://localhost:4502/crx/packmgr/service.jsp
# curl -u admin:admin -v -k -I -w "%{http_code}" -F "file=@$z" -F "name=$name" -F "force=true" -F "install=true" http://localhost:4502/crx/packmgr/service.jsp


for z in *.zip; do
    echo "Installing:  $z";
    name=${z%.*};
    echo "Name: ${GREEN}$name${NC}"
    sleep 5;
    
    curl -u admin:admin -F file=@"$z" -F "name=$name" -F "force=true" -F "install=true" http://localhost:4502/crx/packmgr/service.jsp
    
    echo "Finished installing:   ${GREEN}$name${NC}";
    printf "\n------------------------------------------------${GREEN}NEXT PACKAGE${NC}---------------------------------------------\n\n"
done

echo "Finished install all packages";
