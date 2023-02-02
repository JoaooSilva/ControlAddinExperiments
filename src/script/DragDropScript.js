//JOA004+ 
//vars
var filesToMove = [];
var sizeOfContainer = null;
var fileCounter = 0;

function SetBoxSize() {
  let box = window.parent.document.querySelector("[class='ms-nav-layout-factbox-details-pane']").clientWidth;
  if (box < 400) {
    sizeOfContainer = 'style="width: 320px;"';
  } else {
    sizeOfContainer = 'style="width: 390px;"';
  }
  sizeOfContainer = 'style="width: 300px;"';
  return sizeOfContainer;
}
function embedDragDropBox(){
  sizeOfContainer = SetBoxSize();
  createIframe();
}

function createIframe(){
  console.log(sizeOfContainer);
  // sizeOfContainer = 'style="width: 200px;"';
  var placeholder = document.getElementById('controlAddIn');  //find controlAddIn
  var divBox = document.createElement('div');
  divBox.id = 'divBox_id';
  divBox.className = 'upload';
  divBox.innerHTML =  '<div class="container">' +
                        '<div class="row">' + 
                          '<div class="col-md-12">' + 
                            '<div style="position: relative; height: 275px;">'+ 
                              '<form action="" method="post" enctype="multipart/form-data"'+ sizeOfContainer +'> '+
                                '<div class="formUp"> '+
                                  '<input type="file" class="fileUpload" name="fileToUpload[]" id="fileToUpload" onchange="fileChanged(event)" accept=".txt, .json, .csv" multiple="multiple">' + 
                                    '<ul class="choosen"></ul>' +
                                    '<p class="guide">Click/Drop here to upload files.</p>' + 
                                  '</input>' +
                                '</div> ' +
                                  '<input type="button" id="file_upload" onclick="uploadFiles()" value="Upload files" name="submitUpload" />' +
                              '</form> '+
                            '</div>' +
                         ' </div>' +
                        '</div>' +
                      '</div>';
  console.log(divBox.innerHTML.toString());
  divBox.height =  '100%';
  // divBox.width = '100%';
  // divBox.width = '320px';
  // $("#form").css("width", "400px");
  placeholder.appendChild(divBox);   //add Iframe to controlAddIn

  // let form = document.querySelector("input[id=fileToUpload]");
}

function fileChanged(event) {

  var target = event.target || event.srcElement;
  // var reader = new FileReader();

  // storeContentFromFiles();

  var applyFiles = function(){
    if (this.files.length <= 0) {
      $('.choosen').html('No file choosen.');
      $('.guide').show();
    } else {
      $('.guide').hide();
      for (var i = 0; i < this.files.length - fileCounter; ++i) {
        $('.choosen').append($('<li>').html(this.files[i].name));
        // var reader = new FileReader();
        // reader.onload = function(event){
        //   console.log("Event:", event);
        //   console.log("Reader result:" ,reader.result);
        //   filesToMove.push(reader.result.toString());
        // };
        // reader.readAsText(event.target.files[i]);
        // filesToMove.push(event.target.files[i]);
        fileCounter += 1;
      }
    }
  }
  $('input[type="file"]').each(function() {
    applyFiles.call(this);
  }).change(function() {
    applyFiles.call(this);
  });
}
function uploadFiles() {
  var files = document.getElementById('fileToUpload').files;
  var finalArrayToSend = "";
  var tempSubstring = "";
  $('.choosen').empty();
  $('.guide').show();


  // for (var i = 0; i < filesToMove.length; ++i){
  //   debugger;
  //   console.log(filesToMove[i].toString());
  //   switch (i){
  //     case 0:
  //       tempSubstring = filesToMove[i].substring(0, filesToMove[0].length - 5);
  //       tempSubstring += ',';
  //       finalArrayToSend += tempSubstring;
  //       break;
  //     case (filesToMove.length - 1):
  //       tempSubstring = filesToMove[i].substring(1);
  //       finalArrayToSend += tempSubstring;
  //     default:
  //       tempSubstring = filesToMove[i].substring(1,filesToMove[0].length - 5);
  //       tempSubstring += ',';
  //       finalArrayToSend += tempSubstring;
  //   }
  //   Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("GetFileContent", [finalArrayToSend]);    
  // }
}
function DeleteBox() {
  let placeholder = window.parent.document.getElementById("divBox");
  if (placeholder) {
    placeholder.remove();
  }
}

//JOA004-