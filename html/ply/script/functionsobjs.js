// Set up the scene, camera, and renderer as global variables.
var scene = [], renderers = [], controls = []; cameras = [];
var divId = 1;
var bgcol = 0;

function addAdditionalButtons()
{
  var body = document.getElementsByTagName("body")[0]
  var button = document.createElement("button");
  button.innerHTML = "Background color";
  button.id = "bgcolor"
  button.addEventListener("click", function()
  {
    switch(bgcol)
    {
      case 0:
        var divs = document.getElementsByClassName("objdiv");
        for (i = 0; i < divs.length; i++)
        {
          divs[i].style.borderColor = "white";
          divs[i].style.backgroundColor = "black";
        }
        break;
      case 1:
        var divs = document.getElementsByClassName("objdiv");
        for (i = 0; i < divs.length; i++)
        {
          divs[i].style.borderColor = "black";
          divs[i].style.backgroundColor = "white";
        }
        break;
    }
    bgcol += 1;
    if (bgcol > 1)
      bgcol = 0;
  }, false);
  body.appendChild(button);
}

var onProgress = function ( xhr )
{
  if ( xhr.lengthComputable ) {
    var percentComplete = xhr.loaded / xhr.total * 100;
    console.log( "[" + Math.round(percentComplete, 2) + "%] " + xhr.currentTarget.responseURL );
  }
};

var onError = function ( xhr )
{
  console.log("Error downloading %s", xhr.currentTarget.responseURL)
};

// Create new obj
function newObj(filepath)
{
  grid = document.getElementById("gridobj");

  // Now create and append to iDiv
  var containerCurr = document.createElement("div");
  containerCurr.id = "obj" + divId;
  containerCurr.className = "objdiv";
  divId += 1;
  grid.appendChild(containerCurr);

  // Create a renderer and add it to the DOM.
  var rendererCurr = new THREE.WebGLRenderer({antialias:true, alpha: true });
  rendererCurr.setClearColor( 0xffffff,0 );
  containerCurr.appendChild( rendererCurr.domElement );

  // Create the scene and set the scene size.
  var sceneCurr = new THREE.Scene();
  // Create the camera.
  // camera = new THREE.PerspectiveCamera(45, 1, 0.01, 3); camera.position.set(0,0,-0.5);
  var camera = new THREE.PerspectiveCamera(45, 1, 10, 3000);
  sceneCurr.add(camera);

  // Create an event listener that resizes the renderer with the browser window.
  window.addEventListener("resize", onResizeWin);


  // Create a light, set its position, and add it to the scene.
  // var light = new THREE.AmbientLight( 0xF2F2F2 ); // soft white light
  // sceneCurr.add( light );

  var loader = new THREE.PLYLoader();
  console.log(filepath)
  loader.load( filepath, function ( geometry ) {
    geometry.rotateZ(3.14)
    geometry.rotateX(-3.14/2)
    geometry.rotateY(3.14/2)
    geometry.rotateX(-3.14/4)
    geometry.computeBoundingBox();
    var centerX = 0.5 * ( geometry.boundingBox.max.x + geometry.boundingBox.min.x );
    var centerY = 0.5 * ( geometry.boundingBox.max.y + geometry.boundingBox.min.y );
    var centerZ = 0.5 * ( geometry.boundingBox.max.z + geometry.boundingBox.min.z );
    geometry.translate(-centerX, -centerY, -centerZ)
    console.log(centerX, centerY, centerZ)
    var bBoxX = geometry.boundingBox.max.x - geometry.boundingBox.min.x
    var bBoxY = geometry.boundingBox.max.y - geometry.boundingBox.min.y
    var bBoxZ = geometry.boundingBox.max.z - geometry.boundingBox.min.z
    var translationZ = Math.max(bBoxX, bBoxY) / (2 * Math.tan(camera.fov/180.0*Math.PI/2))
    camera.translateZ(-(translationZ + bBoxZ/2))
    var material = new THREE.PointCloudMaterial({
                size: 1,
                transparent: false,
                opacity: 1.0,
                vertexColors: true,
                sizeAttenuation: false
                // color: 0xffffff
            });
    var cloud = new THREE.PointCloud(geometry, material);
					sceneCurr.add( cloud );
				}, onProgress, onError );

  requestRender();

  // Add OrbitControls so that we can pan around with the mouse.
  var controlCurr = new THREE.OrbitControls(camera, rendererCurr.domElement);

  scene.push(sceneCurr);
  renderers.push(rendererCurr);
  controls.push(controlCurr);
  cameras.push(camera);
  render()
}

function onResizeWin()
{
  var WIDTH = $("#obj1").width(), HEIGHT = $("#obj1").height();
  for (i = 0; i < renderers.length; i++) {
    renderers[i].setSize(WIDTH, HEIGHT);
    cameras[i].aspect = WIDTH / HEIGHT;
    cameras[i].updateProjectionMatrix();
  }
}

//! mouse move event
function onMouseMove( event )
{
  requestRender();
}

//! Mouse wheel event
function onMouseWheel( event )
{
	requestRender();
}

// Renders the scene and updates the render as needed.
function animate()
{
  // var i = 0
  for (i = 0; i < controls.length; i++)
  {
    controls[i].update();
    renderers[i].render(scene[i], cameras[i]);
  }
}

//! Call this function when something has changed
function requestRender()
{
  requestAnimationFrame(animate);
}

function render()
{
  // Initialize renderers and start loop
  onResizeWin();
  window.addEventListener( 'mousemove', onMouseMove, true );
  window.addEventListener( 'mousewheel', onMouseWheel, true );
  window.addEventListener( 'MozMousePixelScroll', onMouseWheel, true ); // firefox
  window.addEventListener( 'DOMMouseScroll', onMouseWheel, true );
  animate();
}
