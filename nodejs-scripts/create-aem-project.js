var Rsync = require('rsync');
var List = require('prompt-list');
const fs = require('fs');
var prompt = require('prompt');
var Prompt = require('prompt-checkbox');

const aemPackagesDir = '/Volumes/Users/jackk/AEM/packages/';
const AEMNASDir = '/Volumes/Users/jackk/AEM/';
const localAEMDirectory = '/Users/jackkenlay/AEM/';
const AEMProjectDirectory = '/Users/jackkenlay/work/';

async function getRequiredAEMVersion(){
    //TODO make this automatic depending on directory
    var list = new List({
        name: 'AEM Setup',
        message: 'Which AEM?',
        // choices may be defined as an array or a function that returns an array
        choices: [
          '6.4',
          '6.3',
          '6.2',
          {name: '6.1', disabled: 'Needs Creating'},
          {name: '6.0', disabled: 'Needs Creating'},
        ]
      });
       
    return list.run()
        .then(function(answer) {
          return Promise.resolve(answer);
        });
}


//need to get a list of all zip files in there

function getAvailableAEM(){

}


async function listAllPackagesByAEM(inputAEM) {
    return new Promise((resolve,reject)=>{
        let currentAemPackages = aemPackagesDir + inputAEM + '/*.zip';
        //inputAem needs to be 6.1 or 6.2 etc
        //get array of all the files in the directory
        // console.log('currentAemPackages: ' + currentAemPackages);
        var glob = require("glob");
    
        // options is optional
        glob(currentAemPackages, function (er, files) {
          // files is an array of filenames.
          // If the `nonull` option is set, and nothing
          // was found, then files is ["**/*.js"]
          // er is an error object or null.
          resolve(files);
        });
    })

}




async function getProjectParams(){
    return new Promise((resolve,reject)=>{
        prompt.start();

        prompt.get(['Project Name','Project Repo Clone Url'], function (err, result) {
            let params = {};
          // Log the results.
        //   console.log('Command-line input received:');
        //   console.log(JSON.stringify(result,null,4));
          params.projectName = result['Project Name'];
          params.repoUrl = result['Project Repo Clone Url'];
          resolve(params);
        });
    });
}


// let aemUrl = AEMNASDir +'6.4/';
//       let testDestination = '~/AEM/6.4/';
//       copyDirectory(aemUrl,testDestination);








async function getListOfPackagesToCopy(aemVersion){
    let availablePackages = await listAllPackagesByAEM(aemVersion);
    var prompt = new Prompt({
    name: 'colors',
    message: 'Which Available Packages do you want to Install? (Use spacebar to select, enter to submit)',
    choices: availablePackages
    });
    
    return prompt.run()
    .then(function(answers) {
        return Promise.resolve(answers);
    })
    .catch(function(err) {
        console.log('Error:');
        console.log(err)
    })
}



//todo change to promise
async function copyDirectory(source,destination){
    console.log('copying ' + source + ' to ' + destination);
    return new Promise((resolve,reject)=>{
        // Build the command
        var rsync = new Rsync();
        rsync.shell('ssh');
        rsync.set('progress');
        rsync.flags('avz');
        rsync.source(source);
        rsync.destination(destination);
        console.log('running the command ' + rsync.command());
        rsync.output(
            function (data) {
                console.log('synching... ' + data);
            }, function (data) {
                console.log('What is this line for? sync: ' + data);
            }
        );
        rsync.execute(function(error, code, cmd) {
            console.log('Finished copying ' + source + ' to ' + destination);
            resolve();
        });
    });
}

async function cloneRepo(repoUrl){

}
    
async function init(){
    console.log('Creating New AEM project\n');


    /*
    let params = await getProjectParams();
    params.AEMVersion = await getRequiredAEMVersion();
    params.packagesToInstall = await getListOfPackagesToCopy(params.AEMVersion);
    
    console.log('Project Data:');
    console.log(JSON.stringify(params,null,4));

    //TODO next
    
    //copy the AEM from the NAS to the local, complete with name
    let AEMFolderToCopy = AEMNASDir + params.AEMVersion + '/'; 
    
    // console.log('Aem folder to copy: ' + AEMFolderToCopy);
    let distinationDIR = localAEMDirectory + params.projectName + '-' + params.AEMVersion;
    // console.log('Destination: ' + distinationDIR);
    await copyDirectory(AEMFolderToCopy, distinationDIR);
    */


    //clone the repo.

    let repoToClone = 'https://stash.ensemble.com/scm/cs/aem.git';
    await cloneRepo(repoToClone);
    







    //later, do they have a content.package that they can select from wherever.
    //later, make a backup after init project, so they always have something to go back to if they fuck up their AEM
}
init();





// create-new-project(){
//     node ~/personal/setup/nodejs-scripts/create-aem-project.js
//   # TODO
//   # Change to node
//   # Selection input
//   # Packages
//   # Starting with Admin admin (probably easier with NodeJS)
//   # Change to Rsync
//   # Call from Bash, make a nodeJS file in my setup
//   # Ask for prompts for repo and stuff
//   # After starting AEM, then it asks for logfile, incase it's created after project creation?
//   # a JSON file with all of the set up so you can alter it later on
//   # Makes a setup-projectName function
  
//     AEMNASdir="/Volumes/Users/jackk/AEM/";
//     # input:
//       # AEM version
//       # Packages
//       # Repo url
//       # MVN clean install dir.
//       # Logfile dir
//       # AEM filename
//       # repo folder name (gets after cloning)
    
//     # Steps
//       # get a project name
//         projectName="creditsafe-aem"
//       # Ensure LondonNAS is connected
//         # If not then mount it
//         mount-london-nas
//       # Asks which AEM you want
//         # TODO have manual input here, from list or just read it
  
//       # Asks which packages you want
//       # Asks for Repo URL
//         repoUrl="https://stash.ensemble.com/scm/cs/aem.git"
//         echo "Repo URL: $repoUrl"
//       # goes to work folder & clones repo
//         cd ~/work
//         git clone "$repoUrl" "$projectName"
//         echo "Repo Cloned"
//       # goes to AEM folder & clones correct AEM version from NAS
//         echo "Copying AEM from NAS, please wait (normally takes 1 minutes on the 5ghz wifi)"
//         cd ~/AEM/
//         SRC_DIR="$AEMNASdir$aemVersion/";
//         mkdir ~/AEM/$projectName-$aemVersion && cp -r $SRC_DIR ~/AEM/$projectName-$aemVersion
//         echo "Copied AEM"
  
//               # TODO USE RSYNC w/progress bar BUT THE PIECE OF SHIT DOESNT WORK
//               # SRC_DIR="$AEMNASdir$aemVersion/";
//               # OPTIONS="-avz";
//               # DST_DIR="~/AEM/";
//               # echo "$SRC_DIR";
//               # echo "$DST_DIR";
//               # /usr/bin/rsync $OPTIONS "$SRC_DIR" "$DST_DIR";
      
//       # Gets available packages from directory in NAS and asks user which ones they want.
//       # Starts AEM with admin admin
      
      
//       # Installs packages
//         # runs an install on all packages the total amount of packages there are, to ensure all of them have been installed? 
//       # creates a bash function for my thing.
//   }
  