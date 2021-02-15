n = 2; %dimensionality

% Cluster 1
N1 = 100;
mu1 = zeros(n,1);
Sigma1 = (0.2^2)*eye(n);
X1 = mvnrnd(mu1,Sigma1,N1);
% Cluster 2
N2 = 100;
mu2 = ones(n,1);
Sigma2 = (0.9^2)*eye(n);
X2 = mvnrnd(mu2,Sigma2,N2);

% Plot the true clusters
fig_true = figure();
hold on;
scatter(X1(:,1),X1(:,2),'r*');
scatter(X2(:,1),X2(:,2), 'bo');
%%
close;
X = [X1;X2];
N = N1+N2;
fig_data = figure;
scatter(X(:,1),X(:,2));
%% Kmeans
k = 2; % Number of clusters
% Initialize k centers
indInitcenters = randperm(N,k);
centers = X(indInitcenters,:);
% Compute distance to centers;
Dist = zeros(N,k); % Each row is a data sample, each column will get the distance to each cluster's center.
converged = 0; 
iter = 0;
while(~converged)
    centersPrev = centers;
    for i = 1:k
        repCenter = repmat(centers(i,:),N,1);
        Dist(:,i) = sum((X-repCenter).^2,2).^(1/2); % sum over each row
    end
    [~,ind] = min(Dist,[],2);
    % Update centers
    for j = 1:k
        centers(j,:) = mean(X(ind==j,:),1);
    end
    converged = isequal(centersPrev,centers);
    iter = iter + 1;
    displayProgress(X,ind,k,iter,centersPrev);
    %pause(3),
end
markers = {'r*','bo','g.','k^'};
figure(1);
clf;
subplot(2,1,1), 
scatter(X1(:,1),X1(:,2),'r*'); axis equal,
hold on;
scatter(X2(:,1),X2(:,2),'bo'); axis equal,
title('True Gaussian Component Labels')

subplot(2,1,2), 
hold on;
for i = 1:k
    scatter(X(ind==i,1),X(ind==i,2),markers{i});  axis equal,
end
title('Kmeans Clustering Labels')


function displayProgress(X,ind,k,iter,centersPrev)
    figure(1);
    clf;
    markers = {'r*','bo','k.','m^'};
    hold on;
    for i = 1:k
    scatter(X(ind==i,1),X(ind==i,2),markers{i}); axis equal,
    plot(centersPrev(i,1),centersPrev(i,2),markers{i}, 'MarkerSize',15,'MarkerEdgeColor','k');
    end
    title(['Iteration ',num2str(iter)],'Fontsize', 15);
    pause;
end
 
