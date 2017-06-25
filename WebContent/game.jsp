<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Bombman</title>
<!-- Babylon.js -->
<script src="https://preview.babylonjs.com/babylon.js"></script>
<script src="Object.js"></script>
<style>
html, body {
	overflow: hidden;
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

#renderCanvas {
	width: 100%;
	height: 100%;
	touch-action: none;
}
</style>
</head>
<body>
	<div id="canvasZone">
		<canvas id="renderCanvas"></canvas>
	</div>
	<script>
        var canvas = document.getElementById("renderCanvas");
        var engine = new BABYLON.Engine(canvas, true);
		var groundSize = 100;
		var manParamter = { face: 0, x: 5, y: -50 + 5, z: 5 };	// face and position
		var gameState = true;
		var destroyBox = 0;
		var Time = 0;
		
        // You have to create a function called createScene. This function must return a BABYLON.Scene object
        // You can reference the following variables: scene, canvas
        // You must at least define a camera
        // More info here: https://doc.babylonjs.com/generals/The_Playground_Tutorial
        
        var createScene = function() {
        	// This creates a basic Babylon Scene object (non-mesh)
            var scene = new BABYLON.Scene(engine);
			//scene.workerCollisions = true;
			{//Camera
				// This creates and positions a free camera (non-mesh)
				var camera = new BABYLON.FreeCamera("camera", new BABYLON.Vector3(0, 40, -40), scene);
				
				// This targets the camera to scene origin
				camera.setTarget(new BABYLON.Vector3(0, -50, 0));

				// This attaches the camera to the canvas
				camera.attachControl(canvas, true);
				//camera.checkCollisions=true;
			}
			
			{//Light
			
				var light0 = new BABYLON.PointLight("light0", new BABYLON.Vector3(camera.position.x, camera.position.y, camera.position.z), scene);
				light0.exponent = 2;
				light0.intensity = 1;
				light0.diffuse = new BABYLON.Color3(1, 1, 1);
				light0.specular = new BABYLON.Color3(0.2, 0.2, 0.2);
				light0.ambient = new BABYLON.Color3(1, 1, 1);
				light0.setEnabled(1);
			}
			
			{//Texture
				var grassTexture = new BABYLON.StandardMaterial("grass", scene);
				grassTexture.diffuseTexture = new BABYLON.Texture("image/texture/grass_0.jpg", scene);
				grassTexture.diffuseTexture.uScale = 5.0;    
				grassTexture.diffuseTexture.vScale = 5.0;
				grassTexture.bumpTexture = new BABYLON.Texture("image/texture/grass_0_normalmap.JPG", scene);
				grassTexture.bumpTexture.uScale = 5.0;    
				grassTexture.bumpTexture.vScale = 5.0;
				
				var rockwallTexture = new BABYLON.StandardMaterial("rockwall", scene);
				rockwallTexture.diffuseTexture = new BABYLON.Texture("image/texture/rockwall_0.JPG", scene);
				rockwallTexture.diffuseTexture.uScale = 5.0;    
				rockwallTexture.diffuseTexture.vScale = 5.0;
				rockwallTexture.bumpTexture = new BABYLON.Texture("image/texture/rockwall_0_normalmap.JPG", scene);
				rockwallTexture.bumpTexture.uScale = 5.0;    
				rockwallTexture.bumpTexture.vScale = 5.0;
				
				var woodTexture = new BABYLON.StandardMaterial("wood", scene);
				woodTexture.diffuseTexture = new BABYLON.Texture("image/texture/wood_0.JPG", scene);
				woodTexture.diffuseTexture.uScale = 5.0;    
				woodTexture.diffuseTexture.vScale = 5.0;
				woodTexture.bumpTexture = new BABYLON.Texture("image/texture/wood_0_normalmap.JPG", scene);
				woodTexture.bumpTexture.uScale = 5.0;    
				woodTexture.bumpTexture.vScale = 5.0;
				
				var ironplateTexture = new BABYLON.StandardMaterial("ironplate", scene);
				ironplateTexture.diffuseTexture = new BABYLON.Texture("image/texture/ironplate_0.JPG", scene);
				ironplateTexture.diffuseTexture.uScale = 10.0;    
				ironplateTexture.diffuseTexture.vScale = 10.0;
				ironplateTexture.bumpTexture = new BABYLON.Texture("image/texture/ironplate_0_normalmap.JPG", scene);
				ironplateTexture.bumpTexture.uScale = 10.0;    
				ironplateTexture.bumpTexture.vScale = 10.0;
	
				var rockTexture = new BABYLON.StandardMaterial("rock", scene);
				rockTexture.diffuseTexture = new BABYLON.Texture("image/texture/rock_0.JPG", scene);
				rockTexture.diffuseTexture.uScale = 5.0;    
				rockTexture.diffuseTexture.vScale = 5.0;
				rockTexture.bumpTexture = new BABYLON.Texture("image/texture/rock_0_normalmap.JPG", scene);
				rockTexture.bumpTexture.uScale = 5.0;    
				rockTexture.bumpTexture.vScale = 5.0;
				
				var waterTexture = new BABYLON.StandardMaterial("water", scene);
				waterTexture.diffuseTexture = new BABYLON.Texture("image/texture/water_0.jpg", scene);
				waterTexture.diffuseTexture.uScale = 5.0;    
				waterTexture.diffuseTexture.vScale = 5.0;
				waterTexture.bumpTexture = new BABYLON.Texture("image/texture/water_0_normalmap.jpg", scene);
				waterTexture.bumpTexture.uScale = 5.0;    
				waterTexture.bumpTexture.vScale = 5.0;

				var bombTexture = new BABYLON.StandardMaterial("bomb", scene);
				bombTexture.diffuseTexture = new BABYLON.Texture("image/texture/bomb.jpg", scene);
				bombTexture.diffuseTexture.uScale = 2.0;    
				bombTexture.diffuseTexture.vScale = 2.0;

				var flameTexture = new BABYLON.StandardMaterial("flame", scene);
				flameTexture.diffuseTexture = new BABYLON.Texture("image/texture/flame.jpg", scene);
				flameTexture.diffuseTexture.hasAlpha = true;

			}

			{//music
			    var bombmusic = new BABYLON.Sound("gunshot", "music/bomb.mp3", scene);
			    var clockmusic = new BABYLON.Sound("gunshot", "music/clock.mp3", scene);
			    var walkmusic = new BABYLON.Sound("gunshot", "music/walk.mp3", scene);
				var gameovermusic = new BABYLON.Sound("gunshot", "music/gameover.mp3", scene);
			}

			{//Space
				
				//bottom space
				var ground_0 = BABYLON.Mesh.CreateGround("ground_0", groundSize, groundSize, 250, scene);
				ground_0.position = new BABYLON.Vector3(0, -groundSize/2, 0);
				ground_0.material = grassTexture;
				ground_0.checkCollisions=true;
				//top space
				var ground_1 = BABYLON.Mesh.CreateGround("ground_1", groundSize, groundSize, 250, scene);
				ground_1.position = new BABYLON.Vector3(0, groundSize/2, 0);
				ground_1.rotation = new BABYLON.Vector3(Math.PI, 0, 0);
				
				ground_1.material = waterTexture;
				
				//right space
				var ground_2 = BABYLON.Mesh.CreateGround("ground_2", groundSize, groundSize, 250, scene);
				ground_2.position = new BABYLON.Vector3(groundSize/2, 0, 0);
				ground_2.rotation = new BABYLON.Vector3(Math.PI/2, 0, Math.PI/2);
				
				ground_2.material = rockwallTexture;
				
				//left space
				var ground_3 = BABYLON.Mesh.CreateGround("ground_3", groundSize, groundSize, 250, scene);
				ground_3.position = new BABYLON.Vector3(-groundSize/2, 0, 0);
				ground_3.rotation = new BABYLON.Vector3(0, 0, -Math.PI/2);
				
				ground_3.material = woodTexture;
				
				//front space
				var ground_4 = BABYLON.Mesh.CreateGround("ground_4", groundSize, groundSize, 250, scene);
				ground_4.position = new BABYLON.Vector3(0, 0, groundSize/2);
				ground_4.rotation = new BABYLON.Vector3(-Math.PI/2, 0, 0);
				
				ground_4.material = ironplateTexture;
				
				//back space
				var ground_5 = BABYLON.Mesh.CreateGround("ground_5", groundSize, groundSize, 250, scene);
				ground_5.position = new BABYLON.Vector3(0, 0, -groundSize/2);
				ground_5.rotation = new BABYLON.Vector3(Math.PI/2, 0, 0);
				
				ground_5.material = rockTexture;

				
				ground_1.checkCollisions=true;
				ground_2.checkCollisions=true;
				ground_3.checkCollisions=true;
				ground_4.checkCollisions=true;
				ground_5.checkCollisions=true;

			}
			
			var Box = [];

			{//Object
				
				for (var i = 0; i<6; i++){
					Box[i] = new Array();
					for(var j = 0; j<12; j++)
					Box[i][j]= new Array();
				}
				
				makeobject(scene,Box);
				
			}
			
			{//Man
				 // Our built-in 'Man' shape. Params: name, subdivs, size, scene
			    var man = BABYLON.Mesh.CreateBox("Man1", 10, scene);

				
				//Define a material
				var f = new BABYLON.StandardMaterial("material0",scene);
				f.diffuseTexture =  new BABYLON.Texture("image/man/front.png", scene);
				f.diffuseTexture.hasAlpha = true;
				var ba = new BABYLON.StandardMaterial("material1",scene);
				ba.diffuseTexture = new BABYLON.Texture("image/man/back.png", scene);
				ba.diffuseTexture.hasAlpha = true;
				var l = new BABYLON.StandardMaterial("material2",scene);
				l.diffuseTexture = new BABYLON.Texture("image/man/left.png", scene);
				l.diffuseTexture.hasAlpha = true;
				var r = new BABYLON.StandardMaterial("material3",scene);
				r.diffuseTexture = new BABYLON.Texture("image/man/right.png", scene);
				r.diffuseTexture.hasAlpha = true;
				var t = new BABYLON.StandardMaterial("material4",scene);
				t.diffuseTexture = new BABYLON.Texture("image/man/top.png",scene);
				t.diffuseTexture.hasAlpha = true;
				var bo = new BABYLON.StandardMaterial("material5",scene);
				bo.diffuseTexture = new BABYLON.Texture("image/man/nothing.png",scene);
				bo.diffuseTexture.hasAlpha = true;
				//put into one
				var multi=new BABYLON.MultiMaterial("nuggetman",scene);
				multi.subMaterials.push(f);
				multi.subMaterials.push(ba);
				multi.subMaterials.push(l);
				multi.subMaterials.push(r);
				multi.subMaterials.push(t);
				multi.subMaterials.push(bo);

				man.subMeshes=[];
				var verticesCount = man.getTotalVertices();
				man.subMeshes.push(new BABYLON.SubMesh(0, 0, verticesCount, 0, 6, man));
				man.subMeshes.push(new BABYLON.SubMesh(1, 1, verticesCount, 6, 6, man));
				man.subMeshes.push(new BABYLON.SubMesh(2, 2, verticesCount, 12, 6, man));
				man.subMeshes.push(new BABYLON.SubMesh(3, 3, verticesCount, 18, 6, man));
				man.subMeshes.push(new BABYLON.SubMesh(4, 4, verticesCount, 24, 6, man));
				man.subMeshes.push(new BABYLON.SubMesh(5, 5, verticesCount, 30, 6, man));

				man.material = multi;
			    // Move the Man upward 1/2 its height
			    man.position = new BABYLON.Vector3(manParamter.x, manParamter.y, manParamter.z);
				man.scaling = new BABYLON.Vector3(0.5,1,0.5);
				man.checkCollisions=true;
				man.ellipsoid = new BABYLON.Vector3(4.8, 4.8, 4.8);
				man.ellipsoidOffset = new BABYLON.Vector3(0, 5, 0);
				
			
			}
			
			var speed = 10;
			{//Keyboard
			    var z = 0, x = 0, y = 0, bumnum = 0;
			    scene.actionManager = new BABYLON.ActionManager(scene);
			    scene.actionManager.registerAction(new BABYLON.ExecuteCodeAction(BABYLON.ActionManager.OnKeyDownTrigger, function (evt) {
			        if(evt.sourceEvent.key == "w" || evt.sourceEvent.key == "s" || evt.sourceEvent.key == "a" || evt.sourceEvent.key == "d"){
			            walkmusic.play();
			            switch (manParamter.face) {
			                case 0://下
			                    if (evt.sourceEvent.key == "w") {
			                        z = speed;
			                        x = 0; y = 0;
			                    }
			                    else if (evt.sourceEvent.key == "s") {
			                        z = -speed;
			                        x = 0; y = 0;
			                    }
			                    if (evt.sourceEvent.key == "d") {
			                        x = speed;
			                        y = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "a") {
			                        x = -speed;
			                        y = 0; z = 0;
			                    }
			                    break;
			                case 1:	// 右
			                    if (evt.sourceEvent.key == "w") {
			                        y = speed;
			                        x = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "s") {
			                        y = -speed;
			                        x = 0; z = 0;
			                    }
			                    if (evt.sourceEvent.key == "d") {
			                        z = -speed;
			                        x = 0; y = 0;
			                    }
			                    else if (evt.sourceEvent.key == "a") {
			                        z = speed;
			                        x = 0; y = 0;
			                    }
			                    break;
			                case 2:	// 左
			                    if (evt.sourceEvent.key == "w") {
			                        y = speed;
			                        x = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "s") {
			                        y = -speed;
			                        x = 0; z = 0;
			                    }
			                    if (evt.sourceEvent.key == "d") {
			                        z = speed;
			                        x = 0; y = 0;
			                    }
			                    else if (evt.sourceEvent.key == "a") {
			                        z = -speed;
			                        x = 0; y = 0;
			                    }
			                    break;
			                case 3://後
			                    if (evt.sourceEvent.key == "w") {
			                        y = speed;
			                        x = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "s") {
			                        y = -speed;
			                        x = 0; z = 0;
			                    }
			                    if (evt.sourceEvent.key == "d") {
			                        x = speed;
			                        y = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "a") {
			                        x = -speed;
			                        y = 0; z = 0;
			                    }
			                    break;
			                case 4://前
			                    if (evt.sourceEvent.key == "w") {
			                        y = speed;
			                        x = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "s") {
			                        y = -speed;
			                        x = 0; z = 0;
			                    }
			                    if (evt.sourceEvent.key == "d") {
			                        x = -speed;
			                        y = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "a") {
			                        x = +speed;
			                        y = 0; z = 0;
			                    }
			                    break;
			                case 5://上
			                    if (evt.sourceEvent.key == "w") {
			                        z = speed;
			                        x = 0; y = 0;
			                    }
			                    else if (evt.sourceEvent.key == "s") {
			                        z = -speed;
			                        x = 0; y = 0;
			                    }
			                    else if (evt.sourceEvent.key == "d") {
			                        x = -speed;
			                        y = 0; z = 0;
			                    }
			                    else if (evt.sourceEvent.key == "a") {
			                        x = speed;
			                        y = 0; z = 0;
			                    }
			                    break;
			            }
			        }
			        if (evt.sourceEvent.key == " ") {
			            switch (manParamter.face) {
			                case 0://下
								if(man.position.x<-40){ //轉至左face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(-50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 2;
								}else if(man.position.x>40){ //轉至右face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(-40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 1;
								}else if(man.position.z<-40){ //轉至前face
									 man.rotation = new BABYLON.Vector3(-Math.PI/2, Math.PI, 0);
									camera.position = new BABYLON.Vector3(0, 40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 0, -50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 4;
								}else if(man.position.z>40){ //轉至後face
									man.rotation = new BABYLON.Vector3(-(Math.PI/2), 0, 0);
									camera.position = new BABYLON.Vector3(0, 0, -40);
									camera.setTarget(new BABYLON.Vector3(0, 0, 50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 3;
								}
			                    break;
			                case 1://右
								if(man.position.y>40){ //轉至上face
									man.rotation = new BABYLON.Vector3( 0, 0, Math.PI);
									camera.position = new BABYLON.Vector3(0, -40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 5;
								}else if(man.position.y<-40){ //轉至下face
									man.rotation = new BABYLON.Vector3( 0, 0, 0);
									camera.position = new BABYLON.Vector3(0, 40, -40);
									camera.setTarget(new BABYLON.Vector3(0, -50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 0;
								}else if(man.position.z<-40){ //轉至前face
									 man.rotation = new BABYLON.Vector3(-Math.PI/2, Math.PI, 0);
									camera.position = new BABYLON.Vector3(0, 40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 0, -50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 4;
								}else if(man.position.z>40){ //轉至後face
									man.rotation = new BABYLON.Vector3(-(Math.PI/2), 0, 0);
									camera.position = new BABYLON.Vector3(0, 0, -40);
									camera.setTarget(new BABYLON.Vector3(0, 0, 50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 3;
								}
			                    break;
			                case 2://左
								if(man.position.y>40){ //轉至上face
									man.rotation = new BABYLON.Vector3( 0, 0, Math.PI);
									camera.position = new BABYLON.Vector3(0, -40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 5;
								}else if(man.position.y<-40){ //轉至下face
									man.rotation = new BABYLON.Vector3( 0, 0, 0);
									camera.position = new BABYLON.Vector3(0, 40, -40);
									camera.setTarget(new BABYLON.Vector3(0, -50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 0;
								}else if(man.position.z<-40){ //轉至前face
									 man.rotation = new BABYLON.Vector3(-Math.PI/2, Math.PI, 0);
									camera.position = new BABYLON.Vector3(0, 40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 0, -50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 4;
								}else if(man.position.z>40){ //轉至後face
									man.rotation = new BABYLON.Vector3(-(Math.PI/2), 0, 0);
									camera.position = new BABYLON.Vector3(0, 0, -40);
									camera.setTarget(new BABYLON.Vector3(0, 0, 50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 3;
								}
			                    break;
			                case 3://後
								if(man.position.x<-40){ //轉至左face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(-50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 2;
								}else if(man.position.x>40){ //轉至右face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(-40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 1;
								}else if(man.position.y>40){ //轉至上face
									man.rotation = new BABYLON.Vector3( 0, 0, Math.PI);
									camera.position = new BABYLON.Vector3(0, -40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 5;
								}else if(man.position.y<-40){ //轉至下face
									man.rotation = new BABYLON.Vector3( 0, 0, 0);
									camera.position = new BABYLON.Vector3(0, 40, -40);
									camera.setTarget(new BABYLON.Vector3(0, -50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 0;
								}
			                    break;
			                case 4://前
								if(man.position.x<-40){ //轉至左face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(-50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 2;
								}else if(man.position.x>40){ //轉至右face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(-40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 1;
								}else if(man.position.y>40){ //轉至上face
									man.rotation = new BABYLON.Vector3( 0, 0, Math.PI);
									camera.position = new BABYLON.Vector3(0, -40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 5;
								}else if(man.position.y<-40){ //轉至下face
									man.rotation = new BABYLON.Vector3( 0, 0, 0);
									camera.position = new BABYLON.Vector3(0, 40, -40);
									camera.setTarget(new BABYLON.Vector3(0, -50, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 0;
								}
			                    break;
			                case 5://上
								if(man.position.x<-40){ //轉至左face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(-50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 2;
								}else if(man.position.x>40){ //轉至右face
									man.rotation = new BABYLON.Vector3(-Math.PI / 2, Math.PI, Math.PI / 2);
									camera.position = new BABYLON.Vector3(-40, 0, 0);
									camera.setTarget(new BABYLON.Vector3(50, 0, 0));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 1;
								}else if(man.position.z<-40){ //轉至前face
									 man.rotation = new BABYLON.Vector3(-Math.PI/2, Math.PI, 0);
									camera.position = new BABYLON.Vector3(0, 40, 40);
									camera.setTarget(new BABYLON.Vector3(0, 0, -50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 4;
								}else if(man.position.z>40){ //轉至後face
									man.rotation = new BABYLON.Vector3(-(Math.PI/2), 0, 0);
									camera.position = new BABYLON.Vector3(0, 0, -40);
									camera.setTarget(new BABYLON.Vector3(0, 0, 50));
									light0.position = new BABYLON.Vector3(camera.position.x,camera.position.y,camera.position.z);
									manParamter.face = 3;
								}
			                    break;
			            }

			        }
					if (evt.sourceEvent.key == "z") {
						   if(bumnum<2){
						    var bump = BABYLON.Mesh.CreateSphere("sphere"+bumnum, 16, 5, scene);
						    
						    clockmusic.play();
							bump.position = new BABYLON.Vector3(man.position.x,man.position.y,man.position.z);
							bump.material = bombTexture;
							bumnum++;
							setTimeout(function () {
								var flame_0 = BABYLON.Mesh.CreateSphere("sphere", 16, 5, scene);
								flame_0.position = new BABYLON.Vector3(bump.position.x+10,bump.position.y,bump.position.z);
								flame_0.material = flameTexture;
								var flame_1 = BABYLON.Mesh.CreateSphere("sphere", 16, 5, scene);
								flame_1.position = new BABYLON.Vector3(bump.position.x-10,bump.position.y,bump.position.z);
								flame_1.material = flameTexture;
								var flame_2 = BABYLON.Mesh.CreateSphere("sphere", 16, 5, scene);
								flame_2.position = new BABYLON.Vector3(bump.position.x,bump.position.y+10,bump.position.z);
								flame_2.material = flameTexture;
								var flame_3 = BABYLON.Mesh.CreateSphere("sphere", 16, 5, scene);
								flame_3.position = new BABYLON.Vector3(bump.position.x,bump.position.y-10,bump.position.z);
								flame_3.material = flameTexture;
								var flame_4 = BABYLON.Mesh.CreateSphere("sphere", 16, 5, scene);
								flame_4.position = new BABYLON.Vector3(bump.position.x,bump.position.y,bump.position.z+10);
								flame_4.material = flameTexture;
								var flame_5 = BABYLON.Mesh.CreateSphere("sphere", 16, 5, scene);
								flame_5.position = new BABYLON.Vector3(bump.position.x,bump.position.y,bump.position.z-10);
								flame_5.material = flameTexture;

								switch(manParamter.face){
								    case 0: // 下
									    if ((Math.abs(manParamter.x - bump.position.x) + Math.abs(manParamter.z - bump.position.z)) <= 10){
											setTimeout(function(){
												gameovermusic.play();
											},1000)
											setTimeout(function(){
												location.href="/Bombman/endclass?time="+Time+"&number="+destroyBox;
											},4000);
										}
									    gameState = false;
									    var decode_x = (bump.position.x - 5)/10+5;
										var decode_z = (bump.position.z - 5) / 10 + 5;
										//console.log(decode_x,decode_z);
										decode_x = decode_x - Math.floor(decode_x) < Math.ceil(decode_x) - decode_x ? Math.floor(decode_x) :　Math.ceil(decode_x); 
										decode_z = decode_z - Math.floor(decode_z) < Math.ceil(decode_z) - decode_z ? Math.floor(decode_z) :　Math.ceil(decode_z);
										
											
										
										
										//console.log(decode_x,decode_z);
										if((decode_x+1<10)&&Box[manParamter.face][decode_x+1][decode_z]){
										    Box[manParamter.face][decode_x + 1][decode_z].dispose();
										    Box[manParamter.face][decode_x + 1][decode_z] = null;
										    destroyBox++;
										}
										if((decode_x-1>0)&&Box[manParamter.face][decode_x-1][decode_z]){
											Box[manParamter.face][decode_x-1][decode_z].dispose();
											Box[manParamter.face][decode_x - 1][decode_z] = null;
											destroyBox++;
                                        }
										if((decode_z+1<10)&&Box[manParamter.face][decode_x][decode_z+1]){
											Box[manParamter.face][decode_x][decode_z+1].dispose();
											Box[manParamter.face][decode_x][decode_z+1] = null;
											destroyBox++;
                                        }
										if((decode_z-1>0)&&Box[manParamter.face][decode_x][decode_z-1]){
											Box[manParamter.face][decode_x][decode_z-1].dispose();
											Box[manParamter.face][decode_x][decode_z-1] = null;
											destroyBox++;
                                        }
									    break;
								    case 1: // 右
								        if ((Math.abs(manParamter.y - bump.position.y) + Math.abs(manParamter.z - bump.position.z)) <= 10){
								        	setTimeout(function(){
												gameovermusic.play();
											},1000)
											setTimeout(function(){
												location.href="/Bombman/endclass?time="+Time+"&number="+destroyBox;
											},4000);
										}
									    var decode_x = (bump.position.y - 5) / 10 + 5;
									    var decode_z = (bump.position.z - 5) / 10 + 5;
    								    decode_x = decode_x - Math.floor(decode_x) < Math.ceil(decode_x) - decode_x ? Math.floor(decode_x) : Math.ceil(decode_x);
									    decode_z = decode_z - Math.floor(decode_z) < Math.ceil(decode_z) - decode_z ? Math.floor(decode_z) : Math.ceil(decode_z);
									    if ((decode_x + 1 < 10) && Box[manParamter.face][decode_x + 1][decode_z]) {
									        Box[manParamter.face][decode_x + 1][decode_z].dispose();
									        Box[manParamter.face][decode_x + 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_x - 1 > 0) && Box[manParamter.face][decode_x - 1][decode_z]) {
									        Box[manParamter.face][decode_x - 1][decode_z].dispose();
									        Box[manParamter.face][decode_x - 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_z + 1 < 10) && Box[manParamter.face][decode_x][decode_z + 1]) {
									        Box[manParamter.face][decode_x][decode_z + 1].dispose();
									        Box[manParamter.face][decode_x][decode_z + 1] = null;
									        destroyBox++;
									    }
									    if ((decode_z - 1 > 0) && Box[manParamter.face][decode_x][decode_z - 1]) {
									        Box[manParamter.face][decode_x][decode_z - 1].dispose();
									        Box[manParamter.face][decode_x][decode_z - 1] = null;
									        destroyBox++;
									    }
									    break;
									case 2: // 左
									    if ((Math.abs(manParamter.y - bump.position.y) + Math.abs(manParamter.z - bump.position.z)) <= 10){
									    	setTimeout(function(){
												gameovermusic.play();
											},1000)
											setTimeout(function(){
												location.href="/Bombman/endclass?time="+Time+"&number="+destroyBox;
											},4000);
										}
									    var decode_x = (bump.position.y - 5) / 10 + 5;
									    var decode_z = (bump.position.z - 5) / 10 + 5;
									    decode_x = decode_x - Math.floor(decode_x) < Math.ceil(decode_x) - decode_x ? Math.floor(decode_x) : Math.ceil(decode_x);
									    decode_z = decode_z - Math.floor(decode_z) < Math.ceil(decode_z) - decode_z ? Math.floor(decode_z) : Math.ceil(decode_z);
									    if ((decode_x + 1 < 10) && Box[manParamter.face][decode_x + 1][decode_z]) {
									        Box[manParamter.face][decode_x + 1][decode_z].dispose();
									        Box[manParamter.face][decode_x + 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_x - 1 > 0) && Box[manParamter.face][decode_x - 1][decode_z]) {
									        Box[manParamter.face][decode_x - 1][decode_z].dispose();
									        Box[manParamter.face][decode_x - 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_z + 1 < 10) && Box[manParamter.face][decode_x][decode_z + 1]) {
									        Box[manParamter.face][decode_x][decode_z + 1].dispose();
									        Box[manParamter.face][decode_x][decode_z + 1] = null;
									        destroyBox++;
									    }
									    if ((decode_z - 1 > 0) && Box[manParamter.face][decode_x][decode_z - 1]) {
									        Box[manParamter.face][decode_x][decode_z - 1].dispose();
									        Box[manParamter.face][decode_x][decode_z - 1] = null;
									        destroyBox++;
									    }
									    break;
									case 3: // 後
									    if ((Math.abs(manParamter.x - bump.position.x) + Math.abs(manParamter.z - bump.position.z)) <= 10){
									    	setTimeout(function(){
												gameovermusic.play();
											},1000)
											setTimeout(function(){
												location.href="/Bombman/endclass?time="+Time+"&number="+destroyBox;
											},4000);
										}
									    var decode_x = (bump.position.x - 5) / 10 + 5;
									    var decode_z = (bump.position.y - 5) / 10 + 5;
									    decode_x = decode_x - Math.floor(decode_x) < Math.ceil(decode_x) - decode_x ? Math.floor(decode_x) : Math.ceil(decode_x);
									    decode_z = decode_z - Math.floor(decode_z) < Math.ceil(decode_z) - decode_z ? Math.floor(decode_z) : Math.ceil(decode_z);
									    if ((decode_x + 1 < 10) && Box[manParamter.face][decode_x + 1][decode_z]) {
									        Box[manParamter.face][decode_x + 1][decode_z].dispose();
									        Box[manParamter.face][decode_x + 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_x - 1 > 0) && Box[manParamter.face][decode_x - 1][decode_z]) {
									        Box[manParamter.face][decode_x - 1][decode_z].dispose();
									        Box[manParamter.face][decode_x - 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_z + 1 < 10) && Box[manParamter.face][decode_x][decode_z + 1]) {
									        Box[manParamter.face][decode_x][decode_z + 1].dispose();
									        Box[manParamter.face][decode_x][decode_z + 1] = null;
									        destroyBox++;
									    }
									    if ((decode_z - 1 > 0) && Box[manParamter.face][decode_x][decode_z - 1]) {
									        Box[manParamter.face][decode_x][decode_z - 1].dispose();
									        Box[manParamter.face][decode_x][decode_z - 1] = null;
									        destroyBox++;
									    }
									    break;
									case 4: // 前
									    if ((Math.abs(manParamter.x - bump.position.x) + Math.abs(manParamter.y - bump.position.y)) <= 10){
									    	setTimeout(function(){
												gameovermusic.play();
											},1000)
											setTimeout(function(){
												location.href="/Bombman/endclass?time="+Time+"&number="+destroyBox;
											},4000);
										}
									    var decode_x = (bump.position.x - 5) / 10 + 5;
									    var decode_z = (bump.position.y - 5) / 10 + 5;
									    decode_x = decode_x - Math.floor(decode_x) < Math.ceil(decode_x) - decode_x ? Math.floor(decode_x) : Math.ceil(decode_x);
									    decode_z = decode_z - Math.floor(decode_z) < Math.ceil(decode_z) - decode_z ? Math.floor(decode_z) : Math.ceil(decode_z);
									    if ((decode_x + 1 < 10) && Box[manParamter.face][decode_x + 1][decode_z]) {
									        Box[manParamter.face][decode_x + 1][decode_z].dispose();
									        Box[manParamter.face][decode_x + 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_x - 1 > 0) && Box[manParamter.face][decode_x - 1][decode_z]) {
									        Box[manParamter.face][decode_x - 1][decode_z].dispose();
									        Box[manParamter.face][decode_x - 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_z + 1 < 10) && Box[manParamter.face][decode_x][decode_z + 1]) {
									        Box[manParamter.face][decode_x][decode_z + 1].dispose();
									        Box[manParamter.face][decode_x][decode_z + 1] = null;
									        destroyBox++;
									    }
									    if ((decode_z - 1 > 0) && Box[manParamter.face][decode_x][decode_z - 1]) {
									        Box[manParamter.face][decode_x][decode_z - 1].dispose();
									        Box[manParamter.face][decode_x][decode_z - 1] = null;
									        destroyBox++;
									    }
									    break;
									case 5: // 上
									    if ((Math.abs(manParamter.x - bump.position.x) + Math.abs(manParamter.z - bump.position.z)) <= 10){
									    	setTimeout(function(){
												gameovermusic.play();
											},1000)
											setTimeout(function(){
												location.href="/Bombman/endclass?time="+Time+"&number="+destroyBox;
											},4000);
										}
									    var decode_x = (bump.position.x - 5) / 10 + 5;
									    var decode_z = (bump.position.z - 5) / 10 + 5;
									    decode_x = decode_x - Math.floor(decode_x) < Math.ceil(decode_x) - decode_x ? Math.floor(decode_x) : Math.ceil(decode_x);
									    decode_z = decode_z - Math.floor(decode_z) < Math.ceil(decode_z) - decode_z ? Math.floor(decode_z) : Math.ceil(decode_z);
									    if ((decode_x + 1 < 10) && Box[manParamter.face][decode_x + 1][decode_z]) {
									        Box[manParamter.face][decode_x + 1][decode_z].dispose();
									        Box[manParamter.face][decode_x + 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_x - 1 > 0) && Box[manParamter.face][decode_x - 1][decode_z]) {
									        Box[manParamter.face][decode_x - 1][decode_z].dispose();
									        Box[manParamter.face][decode_x - 1][decode_z] = null;
									        destroyBox++;
									    }
									    if ((decode_z + 1 < 10) && Box[manParamter.face][decode_x][decode_z + 1]) {
									        Box[manParamter.face][decode_x][decode_z + 1].dispose();
									        Box[manParamter.face][decode_x][decode_z + 1] = null;
									        destroyBox++;
									    }
									    if ((decode_z - 1 > 0) && Box[manParamter.face][decode_x][decode_z - 1]) {
									        Box[manParamter.face][decode_x][decode_z - 1].dispose();
									        Box[manParamter.face][decode_x][decode_z - 1] = null;
									        destroyBox++;
									    }
									    break;
								}
								bombmusic.play();
								bump.dispose();
								bumnum--;
								setTimeout(function(){
									flame_0.scaling = new BABYLON.Vector3(0.5,0.5,0.5);
									flame_1.scaling = new BABYLON.Vector3(0.5,0.5,0.5);
									flame_2.scaling = new BABYLON.Vector3(0.5,0.5,0.5);
									flame_3.scaling = new BABYLON.Vector3(0.5,0.5,0.5);
									flame_4.scaling = new BABYLON.Vector3(0.5,0.5,0.5);
									flame_5.scaling = new BABYLON.Vector3(0.5,0.5,0.5);
								},250);
								setTimeout(function(){
									flame_0.dispose();
									flame_1.dispose();
									flame_2.dispose();
									flame_3.dispose();
									flame_4.dispose();
									flame_5.dispose();
								},500)
							}, 3500); 
							setTimeout(function(){
								bump.scaling = new BABYLON.Vector3(1.5,1.5,1.5);
							}, 1000); 
							setTimeout(function(){
								bump.checkCollisions=true;
								ellipsoid = new BABYLON.Vector3(5, 5, 5);
								bump.scaling = new BABYLON.Vector3(1,1,1);
							}, 1500);
							
							setTimeout(function(){
								bump.scaling = new BABYLON.Vector3(1.5,1.5,1.5);
							}, 2000); 
							setTimeout(function(){
								bump.scaling = new BABYLON.Vector3(1,1,1);
							}, 2500);
							setTimeout(function(){
								bump.scaling = new BABYLON.Vector3(2,2,2);
							}, 3000);
						   }
					   }
					   man.moveWithCollisions(new BABYLON.Vector3(0,0,z));
					   man.moveWithCollisions(new BABYLON.Vector3(x,0,0));
					   man.moveWithCollisions(new BABYLON.Vector3(0,y,0));
					   
					   manParamter.x = man.position.x;
					   manParamter.y = man.position.y;
					   manParamter.z = man.position.z;
					   
					}));

				scene.actionManager.registerAction(new BABYLON.ExecuteCodeAction(BABYLON.ActionManager.OnKeyUpTrigger, function (evt) {
					   if (evt.sourceEvent.key == "w") {
						   z=0;  
					   }
					   else if (evt.sourceEvent.key == "s") {
						  z=0;  
					   }
					   else if (evt.sourceEvent.key == "d") {
						   x=0;  
					   }
					   else if (evt.sourceEvent.key == "a") {
						   x=0;  
					   }
					   else if (evt.sourceEvent.key == "z") {
						   y =-0;
					   }
					   else if (evt.sourceEvent.key == "x") {
					       gameState = true;
					       console.log(gameState);
					   }
					}));
		   	}
			

			
			

            return scene;
        };





        
        var scene = createScene();
		//var gameoverscene = creatoverScene();
		
        engine.runRenderLoop(function () {
			scene.render();
			Time++;
        });

        // Resize
        window.addEventListener("resize", function () {
            engine.resize();
        });
    </script>
</body>
</html>

