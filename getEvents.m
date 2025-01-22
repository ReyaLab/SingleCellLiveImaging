function eventArray = getEvents(cellStruct)

% label other positions as 0
% proximal osteo 1
% proximal vascular 2
% contact osteo 3
% contact vascular 4

other = ~(cellStruct.vascularProximal + cellStruct.osteoProximal + ...
    cellStruct.vascularContact + cellStruct.osteoContact);

proximal = cellStruct.vascularProximal | cellStruct.osteoProximal;

% proximalVascular = cellStruct.vascularDistSmooth(proximal)<...
%     cellStruct.osteoDistSmooth(proximal);
distCompare = cellStruct.vascularDistSmooth<...
    cellStruct.osteoDistSmooth;

contact = cellStruct.vascularContact | cellStruct.osteoContact;

% contactVascular = cellStruct.vascularDistSmooth(contact)<...
%     cellStruct.osteoDistSmooth(contact);

eventArray = zeros(1,length(cellStruct.times));
eventArray(other) = 1;
eventArray(proximal&distCompare) = 3;
eventArray(proximal&~distCompare) = 2;
eventArray(contact&distCompare) = 5;
eventArray(contact&~distCompare) = 4;

