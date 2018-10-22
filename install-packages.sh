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
# extract dependies from /META-INF/vault/properties.xml
# unzip -p 03-cq-6.3.0-featurepack-19008-1.0.6.zip META-INF/vault/properties.xml >file.txt


# Need to parse the string of depencies:


# <?xml version="1.0" encoding="utf-8" standalone="no"?>
# <!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
# <properties>
# <comment>FileVault Package Properties</comment>
# <entry key="createdBy">Adobe Systems Incorporated</entry>
# <entry key="name">cq-6.3.0-featurepack-19008</entry>
# <entry key="uploaded">2017-10-09T10:32:24.407-04:00</entry>
# <entry key="requiresRestart">false</entry>
# <entry key="created">2017-10-09T13:10</entry>
# <entry key="groupId">com.adobe.cq.feature</entry>
# <entry key="uploadedBy">gknob@adobe.com</entry>
# <entry key="version">1.0.6</entry>
# <entry key="dependencies">day/cq60/product:cq-dam-cfm-content:0.9.344</entry>
# <entry key="requiresRoot">true</entry>
# <entry key="description">FP for AEM 6.3: Structured Content Fragments</entry>
# <entry key="group">adobe/cq630/featurepack</entry>
# <entry key="artifactId">cq-6.3.0-featurepack-19008</entry>
# <entry key="path">/etc/packages/adobe/cq630/featurepack/cq-6.3.0-featurepack-19008.zip</entry>
# </properties>

# to get the line:
# grep -i "dependencies" file.txt

# gets everything but the <>
#  grep -i '<entry key="dependencies">[^<]*<' file.txt | grep -o '>[^<]*<' 

# Gets the depencies
 grep -i '<entry key="dependencies">[^<]*<' file.txt | grep -o '>[^<]*<' | sed 's:^.\(.*\).$:\1:'


# press Y if you want to proceed
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
