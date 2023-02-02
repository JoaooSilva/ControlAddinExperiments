//JOA005+ 
let completeBlob = null;
let recorder = null;
let chunks = [];
let stream = null;
let blobHref = null;
let video_attachment = null;

function writeToConsole(message){
    if (typeof console != 'undefined'){
        console.log(message);
    }
}


async function startRecord() {
    // writeToConsole('Olá mundo');
    try {
        stream = await navigator.mediaDevices.getDisplayMedia({video: true, audio: false});
        recorder = new MediaRecorder(stream);
        recorder.ondataavailable = (e) => chunks.push(e.data);
        recorder.start();
        recorder.onstop = onstop;
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ChangeButtonsStateStartClick", []);
    } catch (error) {
        debugger;
        // window.alert(error)
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ChangeButtonsStateCancelClick", []);
    }
}
async function stopScreen() {
    recorder.stop()
    stream.getTracks().forEach(function (track) {
        track.stop();
    });
}     
function onstop() {
    completeBlob = new Blob(chunks, {
        type: chunks[0].type
    });
    stream.getVideoTracks()[0].stop();
    let reader = new FileReader();
    reader.readAsDataURL(completeBlob);
    let base64String = reader.result;
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ChangeButtonsStateStopClick", []);
    EmbedVideoToPage();
}
async function downloadVideo(){
    let video = document.createElement('a');
    video.href = URL.createObjectURL(completeBlob);
    video.download = Date.now() + '.mp4';
    document.body.appendChild(video);
    video.click();
    video.remove();
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ChangeButtonsStateDownloadOrAttachClick", []);
}
async function receiveAttachment(){
    let video_attachment = document.createElement('a');
    video_attachment.href = URL.createObjectURL(completeBlob);
    video_attachment.download = Date.now() + '.mp4';
    let reader = new FileReader();
    reader.readAsDataURL(completeBlob);

    // let jsonAttach = '{"Attachment": [' +
    //                 '{ "Attachment File": "' + base64String + '", "File Extension":".mp4"}]}'; 
    // var jsonObj = JSON.parse(jsonAttach);
    createFileFormCurrentRecordedData();
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("AttachmentReady", [video_attachment.href]);
    video_attachment.remove();
}
function createFileFormCurrentRecordedData() {
    debugger;
    const blob = new Blob(chunks , {type: "video/ogg"});
    const file = new File( [ blob ], "yourfilename.ogg", { type: "video/ogg"} );
    /* then upload oder directly download your file / blob depending on your needs */
}

function EmbedVideoToPage() {
    debugger;
    let videoResult = document.getElementById('videoResult');
    if (videoResult) {
        videoResult.remove();
    } 
    var controlAddIn = document.getElementById("controlAddIn");
    var videoDiv = document.createElement('div');

    videoDiv.innerHTML = `
                        <div style="border: 2px solid black">
                            <video controls="true" style="width: 810px; height: 455px; display:block;" id="videoResult" src="`
                            + URL.createObjectURL(completeBlob) + `"></video>
                        </div>
    `;
    controlAddIn.appendChild(videoDiv);
}
//JOA005-
