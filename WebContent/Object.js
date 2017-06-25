/**
 * 
 */
var objectmap = [[ 
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 1, 0, 1, 0, 0, 1, 1, 0, 0 ],
				[ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 ],
				[ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0 ],
				[ 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 ],
				[ 0, 0, 1, 0, 0, 0, 1, 1, 0, 0 ],
				[ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 ],
				[ 0, 0, 0, 1, 0, 1, 0, 1, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ],[

				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 2, 0 ],
				[ 0, 2, 2, 0, 2, 0, 0, 2, 0, 0 ],
				[ 0, 0, 2, 0, 0, 2, 0, 0, 0, 0 ],
				[ 0, 2, 2, 0, 0, 2, 0, 2, 2, 0 ],
				[ 0, 0, 0, 2, 2, 2, 0, 2, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 2, 2, 0, 0 ],
				[ 0, 0, 2, 0, 0, 0, 0, 0, 2, 0 ],
				[ 0, 0, 2, 2, 2, 2, 2, 0, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ],[

				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 3, 0, 0, 0, 0, 3, 3, 0, 0 ],
				[ 0, 3, 0, 3, 0, 0, 0, 0, 3, 0 ],
				[ 0, 0, 3, 0, 0, 3, 0, 3, 0, 0 ],
				[ 0, 3, 0, 3, 0, 3, 0, 0, 0, 0 ],
				[ 0, 0, 0, 0, 3, 3, 0, 3, 3, 0 ],
				[ 0, 3, 0, 3, 0, 0, 0, 0, 3, 0 ],
				[ 0, 3, 3, 0, 0, 0, 3, 3, 0, 0 ],
				[ 0, 3, 0, 3, 0, 3, 3, 3, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ],[

				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 4, 0, 0, 0, 4, 0, 4, 0, 0 ],
				[ 0, 0, 0, 0, 4, 4, 0, 0, 0, 0 ],
				[ 0, 4, 0, 0, 0, 0, 0, 4, 0, 0 ],
				[ 0, 0, 0, 4, 0, 0, 4, 0, 4, 0 ],
				[ 0, 4, 0, 0, 4, 0, 0, 0, 4, 0 ],
				[ 0, 4, 0, 0, 4, 0, 4, 0, 4, 0 ],
				[ 0, 4, 4, 4, 4, 0, 0, 0, 0, 0 ],
				[ 0, 4, 0, 0, 0, 0, 4, 4, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ],[

				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 0, 0, 5, 5, 0, 0, 5, 0 ],
				[ 0, 0, 5, 5, 0, 0, 0, 5, 5, 0 ],
				[ 0, 0, 0, 0, 0, 5, 5, 5, 0, 0 ],
				[ 0, 5, 5, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 5, 5, 5, 5, 5, 5, 0, 0 ],
				[ 0, 0, 5, 0, 5, 0, 0, 5, 0, 0 ],
				[ 0, 5, 0, 0, 5, 0, 0, 0, 5, 0 ],
				[ 0, 5, 0, 0, 0, 5, 0, 5, 5, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ],[

				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 0, 0, 6, 6, 6, 0, 0, 0 ],
				[ 0, 0, 6, 0, 0, 0, 6, 6, 6, 0 ],
				[ 0, 6, 6, 0, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 6, 0, 0, 0, 0, 0, 6, 0 ],
				[ 0, 0, 6, 0, 6, 0, 0, 6, 6, 0 ],
				[ 0, 0, 0, 6, 0, 0, 0, 0, 0, 0 ],
				[ 0, 0, 0, 6, 0, 6, 0, 0, 6, 0 ],
				[ 0, 0, 6, 0, 0, 6, 0, 0, 0, 0 ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ] ]


function makeobject(scene,box,finishhole) {
	console.log(finishhole);
	var endPlane = new BABYLON.Mesh.CreatePlane("plane_0", 10, scene);
	endPlane.material = new BABYLON.StandardMaterial("Mat", scene);
	endPlane.material.diffuseTexture = new BABYLON.Texture("image/texture/blackhole.png", scene);
	switch(finishhole.face){
		case 0: //下
			endPlane.position = new BABYLON.Vector3(
					(finishhole.x - 5) * 10 + 5, -50 + 1, (finishhole.y - 5) * 10 + 5
				);
			endPlane.rotation = new BABYLON.Vector3(
					Math.PI/2,0,0
				);
		break;
		case 1: //右
			endPlane.position = new BABYLON.Vector3(
					50 - 1, (finishhole.y - 5) * 10 + 5,(finishhole.x - 5) * 10 + 5
				);
			endPlane.rotation = new BABYLON.Vector3(
					0,Math.PI/2,0
				);
		break;
		case 2: //左
			endPlane.position = new BABYLON.Vector3(
					-50 + 1, (finishhole.y - 5) * 10 + 5,(finishhole.x - 5) * 10 + 5
				);
			endPlane.rotation = new BABYLON.Vector3(
					0,-Math.PI/2,0
				);
		break;
		case 3: //後
			endPlane.position = new BABYLON.Vector3(
					(finishhole.x - 5) * 10 + 5, (finishhole.y - 5) * 10 + 5,50-1
				);
			endPlane.rotation = new BABYLON.Vector3(
					0,0,0
				);
		break;
		case 4: //前
			endPlane.position = new BABYLON.Vector3(
					(finishhole.x - 5) * 10 + 5, (finishhole.y - 5) * 10 + 5,-50+1
				);
			endPlane.rotation = new BABYLON.Vector3(
					Math.PI,0,0
				);
		break;
		case 5: //上
			endPlane.position = new BABYLON.Vector3(
					(finishhole.x - 5) * 10 + 5, 50 - 1, (finishhole.y - 5) * 10 + 5
				);
			endPlane.rotation = new BABYLON.Vector3(
					-Math.PI/2,0,0
				);
		break;
		default:
		break;
	}
	var makeBox = function(x, y, face) {
		var t_box = BABYLON.Mesh.CreateBox("crate_" + x + "_" + y, 10, scene);
		t_box.material = new BABYLON.StandardMaterial("Mat", scene);
		t_box.checkCollisions = true;
		switch(face) {
		case 0:	//下
			t_box.position = new BABYLON.Vector3(
					(x - 5) * 10 + 5, -50 + 5, (y - 5) * 10 + 5
				);
			break;
		case 1:	//右
			t_box.position = new BABYLON.Vector3(
					50 - 5, (x - 5) * 10 + 5, (y - 5) * 10 + 5
				);
			break;
		case 2:	//左
			t_box.position = new BABYLON.Vector3(
					-50 + 4, (x - 5) * 10 + 5, (y - 5) * 10 + 5
				);
			break;
		case 3:	//後
			t_box.position = new BABYLON.Vector3(
					(x - 5) * 10 + 5, (y - 5) * 10 + 5, 50 - 4
				);
			break;
		case 4:	//前
			t_box.position = new BABYLON.Vector3(
					(x - 5) * 10 + 5, (y - 5) * 10 + 5, -50 + 4
				);
			break;
		case 5:	//上
			t_box.position = new BABYLON.Vector3(
					(x - 5) * 10 + 5, 50 - 5, (y - 5) * 10 + 5
				);
			break;
		default:
			break;
		}
		//t_box.backFaceCulling = true;
		return t_box;
	}

	for(var face = 0; face < 6; face++){
		for (x = 0; x < 10; x++) {
			for (y = 0; y < 10; y++) {
				switch (objectmap[face][x][y]) {
				case 0:
					break;
				case 1:
					box[face][x][y] = makeBox(x, y, face);
					box[face][x][y].material.diffuseTexture = new BABYLON.Texture("image/texture/grass_0.jpg", scene);
					box[face][x][y].material.bumpTexture = new BABYLON.Texture("image/texture/grass_0_normalmap.JPG", scene);
					box[face][x][y].material.diffuseTexture.hasAlpha = true;
					break;
				case 2:
					box[face][x][y] = makeBox(x, y, face);
					box[face][x][y].material.diffuseTexture = new BABYLON.Texture("image/texture/rockwall_0.JPG", scene);
					box[face][x][y].material.bumpTexture = new BABYLON.Texture("image/texture/rockwall_0_normalmap.JPG", scene);
					box[face][x][y].material.diffuseTexture.hasAlpha = true;
					break;
				case 3:
					box[face][x][y] = makeBox(x, y, face);
					box[face][x][y].material.diffuseTexture = new BABYLON.Texture("image/texture/wood_0.JPG", scene);
					box[face][x][y].material.bumpTexture = new BABYLON.Texture("image/texture/wood_0_normalmap.JPG", scene);
					box[face][x][y].material.diffuseTexture.hasAlpha = true;
					break;
				case 4:
					box[face][x][y] = makeBox(x, y, face);
					box[face][x][y].material.diffuseTexture = new BABYLON.Texture("image/texture/ironplate_0.JPG", scene);
					box[face][x][y].material.bumpTexture = new BABYLON.Texture("image/texture/ironplate_0_normalmap.JPG", scene);
					box[face][x][y].material.diffuseTexture.hasAlpha = true;
					break;
				case 5:
					box[face][x][y] = makeBox(x, y, face);
					box[face][x][y].material.diffuseTexture = new BABYLON.Texture("image/texture/rock_0.JPG", scene);
					box[face][x][y].material.bumpTexture = new BABYLON.Texture("image/texture/rock_0_normalmap.JPG", scene);
					box[face][x][y].material.diffuseTexture.hasAlpha = true;
					break;
				case 6:
					box[face][x][y] = makeBox(x, y, face);
					box[face][x][y].material.diffuseTexture = new BABYLON.Texture("image/texture/water_0.jpg", scene);
					box[face][x][y].material.bumpTexture = new BABYLON.Texture("image/texture/water_0_normalmap.jpg", scene);
					box[face][x][y].material.diffuseTexture.hasAlpha = true;
					break;
				default:
					break;
				}
			}
		}
	}

}
