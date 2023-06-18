function removeSplashFromWeb() {
  document.getElementById("splash")?.remove();
  document.getElementById("splash-branding")?.remove();
  document.body.style.background = "transparent";
}

function startProgressAnimation() {
  var progressBar = document.querySelector('.progress');
  var duration = 2000; // Total duration for the progress animation in milliseconds
  var interval = 10; // Interval for updating the progress in milliseconds

  var start = null;
  function animate(timestamp) {
    if (!start) start = timestamp;
    var progress = timestamp - start;
    var percentage = Math.min(progress / duration * 100, 100);
    progressBar.style.width = percentage + '%';

    if (progress < duration) {
      requestAnimationFrame(animate);
    }
  }

  requestAnimationFrame(animate);
}
// Function to remove the splash screen elements
function removeSplashFromWeb() {
  var splashContainer = document.querySelector('.splash-container');

  // Check if the splash container element exists before removing it
  if (splashContainer) {
    splashContainer.remove();
  }

  document.body.style.background = "transparent";
}

    // Event listener for when the page finishes loading
    window.addEventListener('load', function(ev) {
    startProgressAnimation();
      // Download main.dart.js and initialize Flutter engine
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        }
      }).then(function(engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function(appRunner) {
        return appRunner.runApp();
      }).then(function() {
    // Remove the splash screen
    removeSplashFromWeb();
  });
    });