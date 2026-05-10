baseNetwork = resnet50;
featureLayer = 'fc1000';

%% Create Siamese Network Layers
inputLayer1 = imageInputLayer(inputSize, 'Name', 'input1');
inputLayer2 = imageInputLayer(inputSize, 'Name', 'input2');

siameseLayers = [
    fullyConnectedLayer(512, 'Name', 'fc1')
    reluLayer('Name', 'relu1')
    fullyConnectedLayer(256, 'Name', 'fc2')
    reluLayer('Name', 'relu2')
    fullyConnectedLayer(128, 'Name', 'fc3')
    reluLayer('Name', 'relu3')
    fullyConnectedLayer(1, 'Name', 'fc_output')
    regressionLayer('Name', 'output')];

%% Construct the Siamese Network
lgraph = layerGraph();
lgraph = addLayers(lgraph, [inputLayer1; inputLayer2]);
lgraph = addLayers(lgraph, siameseLayers);

%% Train the Network
options = trainingOptions('adam', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 16, ...
    'InitialLearnRate', 0.001, ...
    'Verbose', true, ...
    'Plots', 'training-progress');

net = trainNetwork(preImages, postImages, lgraph, options);

%% Feature Extraction
featurePre = activations(net, preImages, featureLayer, 'OutputAs', 'rows');
featurePost = activations(net, postImages, featureLayer, 'OutputAs', 'rows');
featureDiff = abs(featurePre - featurePost);

%% Apply Fuzzy Logic for Damage Assessment
fis = mamfis('Name', 'DamageAssessment');
fis = addInput(fis, [-1 1], 'Name', 'FeatureDifference');
fis = addMF(fis, 'FeatureDifference', 'trapmf', [-1 -0.8 -0.6 0], 'Name', 'Low');
fis = addMF(fis, 'FeatureDifference', 'trapmf', [-0.6 0 0.6 1], 'Name', 'Medium');
fis = addMF(fis, 'FeatureDifference', 'trapmf', [0.6 0.8 1 1], 'Name', 'High');

fis = addOutput(fis, [0 1], 'Name', 'DamageLevel');
fis = addMF(fis, 'DamageLevel', 'trimf', [0 0 0.5], 'Name', 'Minor');
fis = addMF(fis, 'DamageLevel', 'trimf', [0.3 0.5 0.7], 'Name', 'Moderate');
fis = addMF(fis, 'DamageLevel', 'trimf', [0.5 1 1], 'Name', 'Severe');

fis = addRule(fis, "FeatureDifference==Low => DamageLevel=Minor");
fis = addRule(fis, "FeatureDifference==Medium => DamageLevel=Moderate");
fis = addRule(fis, "FeatureDifference==High => DamageLevel=Severe");

%% Evaluate Damage
damageLevel = evalfis(fis, featureDiff);