python main2.py \
  --mode=train_and_eval \
  --train_file_pattern=./projects/USA_RoadSigns/train/*.tfrecord  \
  --val_file_pattern=./projects/USA_RoadSigns/valid/*.tfrecord \
  --model_name=efficientdet-d0 \
  --hparams="input_rand_hflip=False,num_classes=160,label_map=./projects/USA_RoadSigns/label_map.yaml" \
  --model_dir=./projects/USA_RoadSigns/models \
  --label_map_pbtxt=./projects/USA_RoadSigns/label_map.pbtxt \
  --eval_dir=./projects/USA_RoadSigns/eval \
  --ckpt=efficientdet-d0  \
  --train_batch_size=4 \
  --early_stopping=map \
  --patience=10 \
  --eval_batch_size=1 \
  --eval_samples=400  \
  --num_examples_per_epoch=1200 \
  --num_epochs=160   
