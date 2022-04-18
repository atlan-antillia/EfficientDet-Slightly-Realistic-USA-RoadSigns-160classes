<h2>
EfficientDet-Slightly-Realistic-USA-RoadSigns-160classes (Updated: 2022/04/20)
</h2>

This is a slightly realistic project to train and detect RoadSigns in US based on 
<a href="https://github.com/google/automl/tree/master/efficientdet">Google Brain AutoML efficientdet</a>.
<br>
Please also refer to our experimental project <a href="https://github.com/atlan-antillia/EfficientDet-Realistic-USA-RoadSigns">EfficientDet-Realistic-USA-RoadSigns</a>.
<br>

<h3>
1. Installing tensorflow on Windows10
</h3>
We use Python 3.8.10 to run tensoflow 2.4.2 on Windows10.<br>
At first, please install <a href="https://visualstudio.microsoft.com/ja/vs/community/">Microsoft Visual Studio Community</a>, which can be used to compile source code of 
<a href="https://github.com/cocodataset/cocoapi">cocoapi</a> for PythonAPI.<br>
Subsequently, please create a working folder "c:\google" folder for your repository, and install the python packages.<br>

<pre>
>mkdir c:\google
>cd    c:\google
>pip install -r requirements.txt
>git clone https://github.com/cocodataset/cocoapi
>cd cocoapi/PythonAPI
</pre>
You have to modify extra_compiler_args in setup.py in the following way:<br>
   extra_compile_args=[],
<pre>
>python setup.py build_ext install
</pre>

<br>
<br>
<h3>
2. Installing EfficientDet-Realistic-USA-RoadSigns
</h3>
Please clone EfficientDet-USA-RoadSigns in the working folder <b>c:\google</b>.<br>
<pre>
>git clone https://github.com/atlan-antillia/EfficientDet-Slightly-Realistic-USA-RoadSigns.git<br>
</pre>
You can see the following folder <b>projects</b> in  EfficientDet-USA-RoadSigns folder of the working folder.<br>

<pre>
EfficientDet-Slightly-Realistic-USA-RoadSigns-160classes
└─projects
    └─USA_RoadSigns
        ├─saved_model
        │  └─variables
        ├─usa_roadsigns_test_dataset_160classes
        ├─usa_roadsigns_test_dataset_160classes_outputs
        ├─train
        └─valid
</pre>
<br>
<b>Note:</b><br>
 You can download USA_RoadSigns tfrecord dataset from  
 <a href="https://github.com/sarah-antillia/TFRecord_Realistic_USA_RoadSigns-160classes">TFRecord_Realistic_USA_RoadSigns-160classes</a>
<br>


<h3>3. Inspect tfrecord</h3>
  You can use <a href="https://github.com/sarah-antillia/TFRecordInspector">TFRecordInspector</a> to inspect train and valid tfrecods. 
Run the following command to inspect train.tfreord.<br>
<pre>
>python TFRecordInspector.py ./projects/USA_RoadSigns/train/train.tfrecord ./projects/USA_RoadSigns/label_map.pbtxt ./inspector/train
</pre>
<br><br>
This will generate annotated images with bboxes and labels from the tfrecord, and cout the number of annotated objects in it.<br>
<br>
<b>TFRecordInspecotr: annotated images in train.tfrecord</b><br>
<img src="./asset/TFRecordInspector_train_annotated_images.png">
<br>
<br>
<b>TFRecordInspecotr: objects_count train.tfrecord</b><br>
<img src="./asset/TFRecordInspector_train_objects_count.png">
<br>
This bar graph shows that the number of the objects contained in train.tfrecord.
<br>
<br>
<br>
<h3>4. Downloading the pretrained-model efficientdet-d0</h3>
Please download an EfficientDet model chekcpoint file <b>efficientdet-d0.tar.gz</b>, and expand it in <b>EfficientDet-USA-RoadSigns</b> folder.<br>
<br>
https://storage.googleapis.com/cloud-tpu-checkpoints/efficientdet/coco2/efficientdet-d0.tar.gz
<br>
See: https://github.com/google/automl/tree/master/efficientdet<br>


<h3>5. Training USA RoadSigns Model by using pretrained-model</h3>
We use the usa_roadsigns_train.bat file.
We created a main2.py from main.py to be able to write COCO metrics to a csv files.<br>

<pre>
python main2.py ^
  --mode=train_and_eval ^
  --train_file_pattern=./projects/USA_RoadSigns/train/*.tfrecord  ^
  --val_file_pattern=./projects/USA_RoadSigns/valid/*.tfrecord ^
  --model_name=efficientdet-d0 ^
  --hparams="input_rand_hflip=False,num_classes=160,label_map=./projects/USA_RoadSigns/label_map.yaml" ^
  --model_dir=./projects/USA_RoadSigns/models ^
  --label_map_pbtxt=./projects/USA_RoadSigns/label_map.pbtxt ^
  --eval_dir=./projects/USA_RoadSigns/eval ^
  --ckpt=efficientdet-d0  ^
  --train_batch_size=4 ^
  --early_stopping=map ^
  --patience=10 ^
  --eval_batch_size=1 ^
  --eval_samples=400  ^
  --num_examples_per_epoch=1200 ^
  --num_epochs=160   
</pre>

<table style="border: 1px solid #000;">
<tr>
<td>
--mode</td><td>train_and_eval</td>
</tr>
<tr>
<td>
--train_file_pattern</td><td>./projects/USA_RoadSigns/train/train.tfrecord</td>
</tr>
<tr>
<td>
--val_file_pattern</td><td>./projects/USA_RoadSigns/valid/valid.tfrecord</td>
</tr>
<tr>
<td>
--model_name</td><td>efficientdet-d0</td>
</tr>
<tr><td>
--hparams</td><td>"input_rand_hflip=False,num_classes=160,label_map=./projects/USA_RoadSigns/label_map.yaml"
</td></tr>
<tr>
<td>
--model_dir</td><td>./projects/USA_RoadSigns/models</td>
</tr>
<tr><td>
--label_map_pbtxt</td><td>./projects/USA_RoadSigns/label_map.pbtxt
</td></tr>

<tr><td>
--eval_dir</td><td>./projects/USA_RoadSigns/eval
</td></tr>

<tr>
<td>
--ckpt</td><td>efficientdet-d0</td>
</tr>
<tr>
<td>
--train_batch_size</td><td>4</td>
</tr>
<tr>
<td>
--early_stopping</td><td>map</td>
</tr>
<tr>
<td>
--patience</td><td>10</td>
</tr>

<tr>
<td>
--eval_batch_size</td><td>1</td>
</tr>
<tr>
<td>
--eval_samples</td><td>400</td>
</tr>
<tr>
<td>
--num_examples_per_epoch</td><td>1200</td>
</tr>
<tr>
<td>
--num_epochs</td><td>160</td>
</tr>
</table>
<br>
<br>
<b>label_map.yaml</b>
<pre>
1: '270_degree_loop'
2: 'Added_lane'
3: 'Added_lane_from_entering_roadway'
4: 'All_way'
5: 'Be_prepared_to_stop'
6: 'Bicycles'
7: 'Bicycles_and_pedestrians'
8: 'Bicycles_left_pedestrians_right'
9: 'Bicycle_wrong_way'
10: 'Bike_lane'
11: 'Bike_lane_slippery_when_wet'
12: 'Bump'
13: 'Bus_lane'
14: 'Center_lane'
15: 'Chevron_alignment'
16: 'Circular_intersection_warning'
17: 'Cross_roads'
18: 'Curve'
19: 'Dead_end'
20: 'Deer_crossing'
21: 'Detour'
22: 'Detour_right'
23: 'Dip'
24: 'Double_side_roads'
25: 'Do_not_drive_on_tracks'
26: 'Do_not_enter'
27: 'Do_not_pass_stopped_trains'
28: 'Emergency_signal'
29: 'End_detour'
30: 'Except_right_turn'
31: 'Fallen_rocks'
32: 'Flagger_present'
33: 'Fog_area'
34: 'Golf_cart_crossing'
35: 'Go_on_slow'
36: 'Gusty_winds_area'
37: 'Hairpin_curve'
38: 'Hazardous_material_prohibited'
39: 'Hazardous_material_route'
40: 'Hidden_driveway'
41: 'Hill_bicycle'
42: 'Horizontal_alignment_intersection'
43: 'Horse_drawn_vehicle_ahead'
44: 'Keep_left'
45: 'Keep_left_2'
46: 'Keep_right'
47: 'Keep_right_2'
48: 'Lane_ends'
49: 'Left_lane'
50: 'Left_turn_only'
51: 'Left_turn_or_straight'
52: 'Left_turn_yield_on_green'
53: 'Loading_zone'
54: 'Low_clearance'
55: 'Low_ground_clearance_railroad_crossing'
56: 'Merge'
57: 'Merging_traffic'
58: 'Metric_low_clearance'
59: 'Minimum_speed_limit_40'
60: 'Minimum_speed_limit_60km'
61: 'Narrow_bridge.jpg'
62: 'Narrow_bridge'
63: 'National_network_prohibited'
64: 'National_network_route'
65: 'Night_speed_limit_45'
66: 'Night_speed_limit_70km'
67: 'No_bicycles'
68: 'No_entre'
69: 'No_hitch_hiking'
70: 'No_horseback_riding'
71: 'No_large_trucks'
72: 'No_left_or_u_turn'
73: 'No_left_turn'
74: 'No_left_turn_across_tracks'
75: 'No_outlet'
76: 'No_parking'
77: 'No_parking_bus_stop'
78: 'No_parking_from_830am_to_530pm'
79: 'No_parking_from_830am_to_530pm_2'
80: 'No_parking_in_fire_lane'
81: 'No_parking_Loading_zone'
82: 'No_parking_on_pavement'
83: 'No_pedestrians'
84: 'No_pedestrian_crossing'
85: 'No_right_turn'
86: 'No_rollerblading'
87: 'No_standing_any_time'
88: 'No_stopping_on_pavement'
89: 'No_straight_through'
90: 'No_train_horn_warning'
91: 'No_turns'
92: 'No_unauthorized_vehicles'
93: 'No_u_turn'
94: 'Offset_roads'
95: 'One_direction'
96: 'One_way'
97: 'Parking_with_time_restrictions'
98: 'Pass_on_either_side'
99: 'Pass_road'
100: 'Path_narrows.jpg'
101: 'Path_narrows'
102: 'Pedestrian_crossing'
103: 'Railroad_crossing'
104: 'Railroad_crossing_ahead'
105: 'Railroad_intersection_warning'
106: 'Ramp_narrows'
107: 'Reserved_parking_wheelchair'
108: 'Reverse_curve'
109: 'Reverse_turn'
110: 'Right_lane'
111: 'Right_turn_only'
112: 'Right_turn_or_straight'
113: 'Road_closed'
114: 'Road_closed_ahead'
115: 'Road_narrows'
116: 'Road_slippery_when_wet'
117: 'Rough_road'
118: 'Runaway_vehicles_only'
119: 'School'
120: 'School_advance'
121: 'School_bus_stop_ahead'
122: 'School_bus_turn_ahead'
123: 'School_speed_limit_ahead'
124: 'Sharp_turn'
125: 'Side_road_at_an_acute_angle'
126: 'Side_road_at_a_perpendicular_angle'
127: 'Single_lane_shift_left'
128: 'Skewed_railroad_crossing'
129: 'Snowmobile'
130: 'Speed_limit_50'
131: 'Speed_limit_80km'
132: 'Stay_in_lane'
133: 'Steep grade'
134: 'Steep_grade_percentage'
135: 'Stop'
136: 'Stop_here_for_pedestrians'
137: 'Stop_here_for_peds'
138: 'Straight_ahead_only'
139: 'Tractor_farm_vehicle_crossing'
140: 'Tractor_farm_vehicle_crossing_2'
141: 'Truck crossing_2'
142: 'Truck_crossing'
143: 'Truck_rollover_warning'
144: 'Truck_route_sign'
145: 'Truck_speed_Limit_40'
146: 'Turning_vehicles_yield_to_pedestrians'
147: 'Turn_only_lanes'
148: 'Two_direction'
149: 'Two_way_traffic'
150: 'T_roads'
151: 'Wait_on_stop'
152: 'Weight_limit_10t'
153: 'Winding_road'
154: 'Workers_on_road'
155: 'Work_zone_for_speed_limit'
156: 'Wrong_way'
157: 'Yield'
158: 'Yield_here_to_pedestrians'
159: 'Yield_here_to_peds'
160: 'Y_roads'
</pre>
<br>
<br>
<br>
<b>COCO meticss f and map</b><br>
<img src="./asset/coco_metrics.png" width="1024" height="auto">
<br>
<br>
<b>Train losses at epoch</b><br>
<img src="./asset/train_losses.png" width="1024" height="auto">
<br>
<br>
<!--
<b>COCO ap per class at epoch</b><br>
<img src="./asset/coco_ap_per_class_epoch.png" width="1024" height="auto">
<br>
<br>
<br>
-->
<h3>
6. Create a saved_model from the checkpoint
</h3>
 We use the following usa_roadsigns_create_saved_model.bat file.
<pre>
python model_inspect.py ^
  --runmode=saved_model ^
  --model_name=efficientdet-d0 ^
  --ckpt_path=./projects/USA_RoadSigns/models  ^
  --hparams="image_size=512x512,num_classes=160" ^
  --saved_model_dir=./projects/USA_RoadSigns/saved_model
 
</pre>

<table style="border: 1px solid #000;">
<tr>
<td>--runmode</td><td>saved_model</td>
</tr>

<tr>
<td>--model_name </td><td>efficientdet-d0 </td>
</tr>

<tr>
<td>--ckpt_path</td><td>./projects/USA_RoadSigns/models</td>
</tr>

<tr>
<td>--hparams</td><td>"image_size=512x512,num_classes=160"</td>
</tr>

<tr>
<td>--saved_model_dir</td><td>./projects/USA_RoadSigns/saved_model</td>
</tr>
</table>

<br>
<br>
<h3>
7. Detect USA_road_signs by using a saved_model
</h3>
 We use the following usa_roadsigns_detect.bat file.
<pre>
python model_inspect.py ^
  --runmode=saved_model_infer ^
  --model_name=efficientdet-d0 ^
  --saved_model_dir=./projects/USA_RoadSigns/saved_model ^
  --min_score_thresh=0.3 ^
  --hparams="num_classes=160,label_map=./projects/USA_RoadSigns/label_map.yaml" ^
  --input_image=./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes/*.jpg ^
  --output_image_dir=./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs
</pre>

<table style="border: 1px solid #000;">
<tr>
<td>--runmode</td><td>saved_model_infer </td>
</tr>

<tr>
<td>--model_name</td><td>efficientdet-d0 </td>
</tr>

<tr>
<td>--saved_model_dir</td><td>./projects/USA_RoadSigns/saved_model </td>
</tr>

<tr>
<td>--min_score_thresh</td><td>0.3 </td>
</tr>

<tr>
<td>--hparams</td><td>"num_classes=160,label_map=./projects/USA_RoadSigns/label_map.yaml"</td>
</tr>

<tr>
<td>--input_image</td><td>./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes/*.jpg</td>
</tr>

<tr>
<td>--output_image_dir</td><td>./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs</td>
</tr>
</table>
<br>
<h3>
8. Some detection results of USA RoadSigns
</h3>

<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1001.jpg" width="1280" height="auto"><br>
<a href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1001.jpg_objects.csv">roadsigns1001.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1002.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1002.jpg_objects.csv">roadsigns1002.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1003.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1003.jpg_objects.csv">roadsigns1003.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1004.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1004.jpg_objects.csv">roadsigns1004.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1005.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1005.jpg_objects.csv">roadsigns1005.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1006.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1006.jpg_objects.csv">roadsigns1006.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1007.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1007.jpg_objects.csv">roadsigns1007.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1008.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1008.jpg_objects.csv">roadsigns1008.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1009.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1009.jpg_objects.csv">roadsigns1009.jpg_objects.csv</a><br>
<br>
<img src="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1010.jpg" width="1280" height="auto"><br>
<a  href="./projects/USA_RoadSigns/usa_roadsigns_test_dataset_160classes_outputs/roadsigns_1010.jpg_objects.csv">roadsigns1010.jpg_objects.csv</a><br>
<br>
