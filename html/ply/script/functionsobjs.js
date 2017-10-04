// Set up the scene, camera, and renderer as global variables.
var scene = [], renderers = [], controls = [];
var stats;
var divId = 1, pageId = 1;
var bgcol = 0;

function onResizeWin()
{
  var WIDTH = $("#obj1").width(), HEIGHT = $("#obj1").height();
  for (i = 0; i < renderers.length; i++) {
    renderers[i].setSize(WIDTH, HEIGHT);
  }
  camera.aspect = WIDTH / HEIGHT;
  camera.updateProjectionMatrix();
}

function addAdditionalButtons()
{
  var body = document.getElementsByTagName("body")[0]
  var button = document. createElement("button");
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

function addPages(numPages)
{
  if (typeof(numPages) === 'undefined') numPages = 1;
  pages = document.getElementById( "pages" );
  for (i = 0; i < numPages; i++)
  {
    var a = document.createElement('a');
    // a.href = "javascript:getobj" + pageId + "()";
    a.href = "page" + pageId + ".html";

    var button = document. createElement("button");
    button.innerHTML = "Page " + pageId;
    button.className = "button"
    button.id = "button" + pageId

    // 2. Append somewhere.
    a.appendChild(button);

    pages.appendChild(a);
    pageId += 1
  }
}

// Create new obj
function newObj(resultsPath, objName)
{

  grid = document.getElementById( "gridobj" );

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
  sceneCurr.add(camera);

  // Create an event listener that resizes the renderer with the browser window.
  window.addEventListener("resize", onResizeWin);


  // Create a light, set its position, and add it to the scene.
  var light = new THREE.AmbientLight( 0xF2F2F2 ); // soft white light
  sceneCurr.add( light );

  var texture = new THREE.Texture();
  var manager = new THREE.LoadingManager();

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

  var loader = new THREE.ImageLoader( manager );
  loader.load( resultsPath + "/" + objName + "/mesh/mesh.png", function ( image )
  {
    texture.image = image;
    texture.needsUpdate = true;
  } );

  // model
  var loader = new THREE.OBJLoader( manager );
  loader.load( resultsPath + "/" + objName + "/mesh/mesh.obj", function ( object )
  {

    object.traverse( function ( child )
    {
      if ( child instanceof THREE.Mesh )
      {
        // Center object
        child.geometry.computeBoundingBox();
        var centerX = 0.5 * ( child.geometry.boundingBox.max.x + child.geometry.boundingBox.min.x );
        var centerY = 0.5 * ( child.geometry.boundingBox.max.y + child.geometry.boundingBox.min.y );
        var centerZ = 0.5 * ( child.geometry.boundingBox.max.z + child.geometry.boundingBox.min.z );
        object.translateX( -centerX );
        object.translateY( -centerY );
        object.translateZ( -centerZ );

        // Apply texture
        child.material.map = texture;
      }

    } );

    sceneCurr.add( object );

  }, onProgress, onError );

  requestRender();

  // Add OrbitControls so that we can pan around with the mouse.
  controlCurr = new THREE.OrbitControls(camera, rendererCurr.domElement);

  return [sceneCurr, rendererCurr, controlCurr];
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
  for (i = 0; i < controls.length; i++)
  {
    controls[i].update();
    // Render the scene.
    renderers[i].render(scene[i], camera);
  }

  // Stats
  stats.update();
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
