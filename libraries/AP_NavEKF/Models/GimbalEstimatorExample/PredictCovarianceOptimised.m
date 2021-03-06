function nextP  = PredictCovarianceOptimised(deltaAngle, ...
    deltaVelocity, ...
    quat, ...
    states,...
    P, ...  % Previous state covariance matrix
    dt) ... % IMU and prediction time step

% Set filter state process noise other than IMU errors, which are already 
% built into the derived covariance predition equations. 
% This process noise determines the rate of estimation of IMU bias errors
dAngBiasSigma = dt*dt*5E-4; % delta angle bias process noise (rad)
processNoise = [0*ones(1,6), dAngBiasSigma*[1 1 1]];

% Specify the estimated errors on the IMU delta angles and delta velocities
% Allow for 0.5 deg/sec of gyro error
daxNoise = (dt*0.5*pi/180)^2;
dayNoise = (dt*0.5*pi/180)^2;
dazNoise = (dt*0.5*pi/180)^2;
% Allow for 0.5 m/s/s of accelerometer error
dvxNoise = (dt*0.5)^2;
dvyNoise = (dt*0.5)^2;
dvzNoise = (dt*0.5)^2;

dvx = deltaVelocity(1);
dvy = deltaVelocity(2);
dvz = deltaVelocity(3);
dax = deltaAngle(1);
day = deltaAngle(2);
daz = deltaAngle(3);

q0 = quat(1);
q1 = quat(2);
q2 = quat(3);
q3 = quat(4);

dax_b = states(7);
day_b = states(8);
daz_b = states(9);

t1365 = dax*0.5;
t1366 = dax_b*0.5;
t1367 = t1365-t1366;
t1368 = day*0.5;
t1369 = day_b*0.5;
t1370 = t1368-t1369;
t1371 = daz*0.5;
t1372 = daz_b*0.5;
t1373 = t1371-t1372;
t1374 = q2*t1367*0.5;
t1375 = q1*t1370*0.5;
t1376 = q0*t1373*0.5;
t1377 = q2*0.5;
t1378 = q3*t1367*0.5;
t1379 = q1*t1373*0.5;
t1380 = q1*0.5;
t1381 = q0*t1367*0.5;
t1382 = q3*t1370*0.5;
t1383 = q0*0.5;
t1384 = q2*t1370*0.5;
t1385 = q3*t1373*0.5;
t1386 = q0*t1370*0.5;
t1387 = q3*0.5;
t1388 = q1*t1367*0.5;
t1389 = q2*t1373*0.5;
t1390 = t1374+t1375+t1376-t1387;
t1391 = t1377+t1378+t1379-t1386;
t1392 = q2*t1391*2.0;
t1393 = t1380+t1381+t1382-t1389;
t1394 = q1*t1393*2.0;
t1395 = t1383+t1384+t1385-t1388;
t1396 = q0*t1395*2.0;
t1403 = q3*t1390*2.0;
t1397 = t1392+t1394+t1396-t1403;
t1398 = q0^2;
t1399 = q1^2;
t1400 = q2^2;
t1401 = q3^2;
t1402 = t1398+t1399+t1400+t1401;
t1404 = t1374+t1375-t1376+t1387;
t1405 = t1377-t1378+t1379+t1386;
t1406 = q1*t1405*2.0;
t1407 = -t1380+t1381+t1382+t1389;
t1408 = q2*t1407*2.0;
t1409 = t1383-t1384+t1385+t1388;
t1410 = q3*t1409*2.0;
t1420 = q0*t1404*2.0;
t1411 = t1406+t1408+t1410-t1420;
t1412 = -t1377+t1378+t1379+t1386;
t1413 = q0*t1412*2.0;
t1414 = t1374-t1375+t1376+t1387;
t1415 = t1383+t1384-t1385+t1388;
t1416 = q2*t1415*2.0;
t1417 = t1380-t1381+t1382+t1389;
t1418 = q3*t1417*2.0;
t1421 = q1*t1414*2.0;
t1419 = t1413+t1416+t1418-t1421;
t1422 = P(1,1)*t1397;
t1423 = P(2,1)*t1411;
t1429 = P(7,1)*t1402;
t1430 = P(3,1)*t1419;
t1424 = t1422+t1423-t1429-t1430;
t1425 = P(1,2)*t1397;
t1426 = P(2,2)*t1411;
t1427 = P(1,3)*t1397;
t1428 = P(2,3)*t1411;
t1434 = P(7,2)*t1402;
t1435 = P(3,2)*t1419;
t1431 = t1425+t1426-t1434-t1435;
t1442 = P(7,3)*t1402;
t1443 = P(3,3)*t1419;
t1432 = t1427+t1428-t1442-t1443;
t1433 = t1398+t1399-t1400-t1401;
t1436 = q0*q2*2.0;
t1437 = q1*q3*2.0;
t1438 = t1436+t1437;
t1439 = q0*q3*2.0;
t1441 = q1*q2*2.0;
t1440 = t1439-t1441;
t1444 = t1398-t1399+t1400-t1401;
t1445 = q0*q1*2.0;
t1449 = q2*q3*2.0;
t1446 = t1445-t1449;
t1447 = t1439+t1441;
t1448 = t1398-t1399-t1400+t1401;
t1450 = t1445+t1449;
t1451 = t1436-t1437;
t1452 = P(1,7)*t1397;
t1453 = P(2,7)*t1411;
t1628 = P(7,7)*t1402;
t1454 = t1452+t1453-t1628-P(3,7)*t1419;
t1455 = P(1,8)*t1397;
t1456 = P(2,8)*t1411;
t1629 = P(7,8)*t1402;
t1457 = t1455+t1456-t1629-P(3,8)*t1419;
t1458 = P(1,9)*t1397;
t1459 = P(2,9)*t1411;
t1630 = P(7,9)*t1402;
t1460 = t1458+t1459-t1630-P(3,9)*t1419;
t1461 = q0*t1390*2.0;
t1462 = q1*t1391*2.0;
t1463 = q3*t1395*2.0;
t1473 = q2*t1393*2.0;
t1464 = t1461+t1462+t1463-t1473;
t1465 = q0*t1409*2.0;
t1466 = q2*t1405*2.0;
t1467 = q3*t1404*2.0;
t1474 = q1*t1407*2.0;
t1468 = t1465+t1466+t1467-t1474;
t1469 = q1*t1415*2.0;
t1470 = q2*t1414*2.0;
t1471 = q3*t1412*2.0;
t1475 = q0*t1417*2.0;
t1472 = t1469+t1470+t1471-t1475;
t1476 = P(8,1)*t1402;
t1477 = P(1,1)*t1464;
t1486 = P(2,1)*t1468;
t1487 = P(3,1)*t1472;
t1478 = t1476+t1477-t1486-t1487;
t1479 = P(8,2)*t1402;
t1480 = P(1,2)*t1464;
t1492 = P(2,2)*t1468;
t1493 = P(3,2)*t1472;
t1481 = t1479+t1480-t1492-t1493;
t1482 = P(8,3)*t1402;
t1483 = P(1,3)*t1464;
t1498 = P(2,3)*t1468;
t1499 = P(3,3)*t1472;
t1484 = t1482+t1483-t1498-t1499;
t1485 = t1402^2;
t1488 = q1*t1390*2.0;
t1489 = q2*t1395*2.0;
t1490 = q3*t1393*2.0;
t1533 = q0*t1391*2.0;
t1491 = t1488+t1489+t1490-t1533;
t1494 = q0*t1407*2.0;
t1495 = q1*t1409*2.0;
t1496 = q2*t1404*2.0;
t1534 = q3*t1405*2.0;
t1497 = t1494+t1495+t1496-t1534;
t1500 = q0*t1415*2.0;
t1501 = q1*t1417*2.0;
t1502 = q3*t1414*2.0;
t1535 = q2*t1412*2.0;
t1503 = t1500+t1501+t1502-t1535;
t1504 = dvy*t1433;
t1505 = dvx*t1440;
t1506 = t1504+t1505;
t1507 = dvx*t1438;
t1508 = dvy*t1438;
t1509 = dvz*t1440;
t1510 = t1508+t1509;
t1511 = dvx*t1444;
t1551 = dvy*t1447;
t1512 = t1511-t1551;
t1513 = dvz*t1444;
t1514 = dvy*t1446;
t1515 = t1513+t1514;
t1516 = dvx*t1446;
t1517 = dvz*t1447;
t1518 = t1516+t1517;
t1519 = dvx*t1448;
t1520 = dvz*t1451;
t1521 = t1519+t1520;
t1522 = dvy*t1448;
t1552 = dvz*t1450;
t1523 = t1522-t1552;
t1524 = dvx*t1450;
t1525 = dvy*t1451;
t1526 = t1524+t1525;
t1527 = P(8,7)*t1402;
t1528 = P(1,7)*t1464;
t1529 = P(8,8)*t1402;
t1530 = P(1,8)*t1464;
t1531 = P(8,9)*t1402;
t1532 = P(1,9)*t1464;
t1536 = P(9,1)*t1402;
t1537 = P(2,1)*t1497;
t1545 = P(1,1)*t1491;
t1546 = P(3,1)*t1503;
t1538 = t1536+t1537-t1545-t1546;
t1539 = P(9,2)*t1402;
t1540 = P(2,2)*t1497;
t1547 = P(1,2)*t1491;
t1548 = P(3,2)*t1503;
t1541 = t1539+t1540-t1547-t1548;
t1542 = P(9,3)*t1402;
t1543 = P(2,3)*t1497;
t1549 = P(1,3)*t1491;
t1550 = P(3,3)*t1503;
t1544 = t1542+t1543-t1549-t1550;
t1553 = P(9,7)*t1402;
t1554 = P(2,7)*t1497;
t1555 = P(9,8)*t1402;
t1556 = P(2,8)*t1497;
t1557 = P(9,9)*t1402;
t1558 = P(2,9)*t1497;
t1560 = dvz*t1433;
t1559 = t1507-t1560;
t1561 = P(1,1)*t1510;
t1567 = P(3,1)*t1506;
t1568 = P(2,1)*t1559;
t1562 = P(4,1)+t1561-t1567-t1568;
t1563 = P(1,2)*t1510;
t1569 = P(3,2)*t1506;
t1570 = P(2,2)*t1559;
t1564 = P(4,2)+t1563-t1569-t1570;
t1565 = P(1,3)*t1510;
t1571 = P(3,3)*t1506;
t1572 = P(2,3)*t1559;
t1566 = P(4,3)+t1565-t1571-t1572;
t1573 = -t1507+t1560;
t1574 = P(2,1)*t1573;
t1575 = P(4,1)+t1561-t1567+t1574;
t1576 = P(2,2)*t1573;
t1577 = P(4,2)+t1563-t1569+t1576;
t1578 = P(2,3)*t1573;
t1579 = P(4,3)+t1565-t1571+t1578;
t1580 = P(1,7)*t1510;
t1581 = P(1,8)*t1510;
t1582 = P(1,9)*t1510;
t1583 = P(2,1)*t1518;
t1584 = P(3,1)*t1512;
t1592 = P(1,1)*t1515;
t1585 = P(5,1)+t1583+t1584-t1592;
t1586 = P(2,2)*t1518;
t1587 = P(3,2)*t1512;
t1593 = P(1,2)*t1515;
t1588 = P(5,2)+t1586+t1587-t1593;
t1589 = P(2,3)*t1518;
t1590 = P(3,3)*t1512;
t1594 = P(1,3)*t1515;
t1591 = P(5,3)+t1589+t1590-t1594;
t1595 = dvxNoise*t1433*t1447;
t1596 = P(2,7)*t1518;
t1597 = P(3,7)*t1512;
t1598 = P(5,7)+t1596+t1597-P(1,7)*t1515;
t1599 = P(2,8)*t1518;
t1600 = P(3,8)*t1512;
t1601 = P(5,8)+t1599+t1600-P(1,8)*t1515;
t1602 = P(2,9)*t1518;
t1603 = P(3,9)*t1512;
t1604 = P(5,9)+t1602+t1603-P(1,9)*t1515;
t1605 = P(3,1)*t1526;
t1606 = P(1,1)*t1523;
t1614 = P(2,1)*t1521;
t1607 = P(6,1)+t1605+t1606-t1614;
t1608 = P(3,2)*t1526;
t1609 = P(1,2)*t1523;
t1615 = P(2,2)*t1521;
t1610 = P(6,2)+t1608+t1609-t1615;
t1611 = P(3,3)*t1526;
t1612 = P(1,3)*t1523;
t1616 = P(2,3)*t1521;
t1613 = P(6,3)+t1611+t1612-t1616;
t1617 = dvzNoise*t1438*t1448;
t1618 = dvyNoise*t1444*t1450;
t1619 = P(3,7)*t1526;
t1620 = P(1,7)*t1523;
t1621 = P(6,7)+t1619+t1620-P(2,7)*t1521;
t1622 = P(3,8)*t1526;
t1623 = P(1,8)*t1523;
t1624 = P(6,8)+t1622+t1623-P(2,8)*t1521;
t1625 = P(3,9)*t1526;
t1626 = P(1,9)*t1523;
t1627 = P(6,9)+t1625+t1626-P(2,9)*t1521;
nextP(1,1) = daxNoise*t1485+t1397*t1424+t1411*t1431-t1419*t1432-t1402*t1454;
nextP(2,1) = -t1397*t1478-t1411*t1481+t1419*t1484+t1402*(t1527+t1528-P(2,7)*t1468-P(3,7)*t1472);
nextP(3,1) = -t1397*t1538-t1411*t1541+t1419*t1544+t1402*(t1553+t1554-P(1,7)*t1491-P(3,7)*t1503);
nextP(4,1) = -t1402*(P(4,7)+t1580-P(3,7)*t1506-P(2,7)*t1559)+t1397*t1562+t1411*t1564-t1419*t1566;
nextP(5,1) = t1397*t1585+t1411*t1588-t1402*t1598-t1419*t1591;
nextP(6,1) = t1397*t1607+t1411*t1610-t1402*t1621-t1419*t1613;
nextP(7,1) = -t1628+P(7,1)*t1397+P(7,2)*t1411-P(7,3)*t1419;
nextP(8,1) = -t1527+P(8,1)*t1397+P(8,2)*t1411-P(8,3)*t1419;
nextP(9,1) = -t1553+P(9,1)*t1397+P(9,2)*t1411-P(9,3)*t1419;
nextP(1,2) = -t1402*t1457-t1424*t1464+t1431*t1468+t1432*t1472;
nextP(2,2) = dayNoise*t1485+t1464*t1478-t1468*t1481-t1472*t1484+t1402*(t1529+t1530-P(2,8)*t1468-P(3,8)*t1472);
nextP(3,2) = t1464*t1538-t1468*t1541-t1472*t1544+t1402*(t1555+t1556-P(1,8)*t1491-P(3,8)*t1503);
nextP(4,2) = -t1402*(P(4,8)+t1581-P(3,8)*t1506-P(2,8)*t1559)-t1464*t1562+t1468*t1564+t1472*t1566;
nextP(5,2) = -t1402*t1601-t1464*t1585+t1468*t1588+t1472*t1591;
nextP(6,2) = -t1402*t1624-t1464*t1607+t1468*t1610+t1472*t1613;
nextP(7,2) = -t1629-P(7,1)*t1464+P(7,2)*t1468+P(7,3)*t1472;
nextP(8,2) = -t1529-P(8,1)*t1464+P(8,2)*t1468+P(8,3)*t1472;
nextP(9,2) = -t1555-P(9,1)*t1464+P(9,2)*t1468+P(9,3)*t1472;
nextP(1,3) = -t1402*t1460-t1431*t1497+t1432*t1503+t1491*(t1422+t1423-t1429-t1430);
nextP(2,3) = -t1478*t1491+t1481*t1497-t1484*t1503+t1402*(t1531+t1532-P(2,9)*t1468-P(3,9)*t1472);
nextP(3,3) = dazNoise*t1485-t1491*t1538+t1497*t1541-t1503*t1544+t1402*(t1557+t1558-P(1,9)*t1491-P(3,9)*t1503);
nextP(4,3) = -t1402*(P(4,9)+t1582-P(3,9)*t1506-P(2,9)*t1559)+t1491*t1562-t1497*t1564+t1503*t1566;
nextP(5,3) = -t1402*t1604+t1491*t1585-t1497*t1588+t1503*t1591;
nextP(6,3) = -t1402*t1627+t1491*t1607-t1497*t1610+t1503*t1613;
nextP(7,3) = -t1630+P(7,1)*t1491-P(7,2)*t1497+P(7,3)*t1503;
nextP(8,3) = -t1531+P(8,1)*t1491-P(8,2)*t1497+P(8,3)*t1503;
nextP(9,3) = -t1557+P(9,1)*t1491-P(9,2)*t1497+P(9,3)*t1503;
nextP(1,4) = P(1,4)*t1397+P(2,4)*t1411-P(3,4)*t1419-P(7,4)*t1402-t1432*t1506+t1510*(t1422+t1423-t1429-t1430)-t1559*(t1425+t1426-t1434-t1435);
nextP(2,4) = -P(1,4)*t1464-P(8,4)*t1402+P(2,4)*t1468+P(3,4)*t1472-t1478*t1510+t1484*t1506+t1481*t1559;
nextP(3,4) = -P(9,4)*t1402+P(1,4)*t1491-P(2,4)*t1497+P(3,4)*t1503-t1510*t1538+t1506*t1544+t1541*t1559;
nextP(4,4) = P(4,4)+P(1,4)*t1510-P(3,4)*t1506+P(2,4)*t1573-t1506*t1566+t1510*t1575+t1573*t1577+dvxNoise*t1433^2+dvyNoise*t1440^2+dvzNoise*t1438^2;
nextP(5,4) = P(5,4)+t1595-P(1,4)*t1515+P(2,4)*t1518+P(3,4)*t1512+t1510*t1585-t1506*t1591+t1573*t1588-dvyNoise*t1440*t1444-dvzNoise*t1438*t1446;
nextP(6,4) = P(6,4)+t1617+P(1,4)*t1523-P(2,4)*t1521+P(3,4)*t1526+t1510*t1607-t1506*t1613+t1573*t1610-dvxNoise*t1433*t1451-dvyNoise*t1440*t1450;
nextP(7,4) = P(7,4)-P(7,3)*t1506+P(7,1)*t1510+P(7,2)*t1573;
nextP(8,4) = P(8,4)-P(8,3)*t1506+P(8,1)*t1510+P(8,2)*t1573;
nextP(9,4) = P(9,4)-P(9,3)*t1506+P(9,1)*t1510+P(9,2)*t1573;
nextP(1,5) = P(1,5)*t1397+P(2,5)*t1411-P(3,5)*t1419-P(7,5)*t1402-t1424*t1515+t1432*t1512+t1518*(t1425+t1426-t1434-t1435);
nextP(2,5) = -P(1,5)*t1464-P(8,5)*t1402+P(2,5)*t1468+P(3,5)*t1472+t1478*t1515-t1484*t1512-t1481*t1518;
nextP(3,5) = -P(9,5)*t1402+P(1,5)*t1491-P(2,5)*t1497+P(3,5)*t1503+t1515*t1538-t1512*t1544-t1518*t1541;
nextP(4,5) = P(4,5)+t1595+P(1,5)*t1510-P(3,5)*t1506+P(2,5)*t1573-t1515*t1575+t1512*t1579+t1518*t1577-dvyNoise*t1440*t1444-dvzNoise*t1438*t1446;
nextP(5,5) = P(5,5)-P(1,5)*t1515+P(2,5)*t1518+P(3,5)*t1512-t1515*t1585+t1512*t1591+t1518*t1588+dvxNoise*t1447^2+dvyNoise*t1444^2+dvzNoise*t1446^2;
nextP(6,5) = P(6,5)+t1618+P(1,5)*t1523-P(2,5)*t1521+P(3,5)*t1526-t1515*t1607+t1512*t1613+t1518*t1610-dvxNoise*t1447*t1451-dvzNoise*t1446*t1448;
nextP(7,5) = P(7,5)+P(7,3)*t1512-P(7,1)*t1515+P(7,2)*t1518;
nextP(8,5) = P(8,5)+P(8,3)*t1512-P(8,1)*t1515+P(8,2)*t1518;
nextP(9,5) = P(9,5)+P(9,3)*t1512-P(9,1)*t1515+P(9,2)*t1518;
nextP(1,6) = P(1,6)*t1397+P(2,6)*t1411-P(3,6)*t1419-P(7,6)*t1402+t1424*t1523-t1431*t1521+t1526*(t1427+t1428-t1442-t1443);
nextP(2,6) = -P(1,6)*t1464-P(8,6)*t1402+P(2,6)*t1468+P(3,6)*t1472-t1478*t1523+t1481*t1521-t1484*t1526;
nextP(3,6) = -P(9,6)*t1402+P(1,6)*t1491-P(2,6)*t1497+P(3,6)*t1503-t1523*t1538+t1521*t1541-t1526*t1544;
nextP(4,6) = P(4,6)+t1617+P(1,6)*t1510-P(3,6)*t1506+P(2,6)*t1573-t1521*t1577+t1523*t1575+t1526*t1579-dvxNoise*t1433*t1451-dvyNoise*t1440*t1450;
nextP(5,6) = P(5,6)+t1618-P(1,6)*t1515+P(2,6)*t1518+P(3,6)*t1512+t1523*t1585-t1521*t1588+t1526*t1591-dvxNoise*t1447*t1451-dvzNoise*t1446*t1448;
nextP(6,6) = P(6,6)+P(1,6)*t1523-P(2,6)*t1521+P(3,6)*t1526+t1523*t1607-t1521*t1610+t1526*t1613+dvxNoise*t1451^2+dvyNoise*t1450^2+dvzNoise*t1448^2;
nextP(7,6) = P(7,6)-P(7,2)*t1521+P(7,1)*t1523+P(7,3)*t1526;
nextP(8,6) = P(8,6)-P(8,2)*t1521+P(8,1)*t1523+P(8,3)*t1526;
nextP(9,6) = P(9,6)-P(9,2)*t1521+P(9,1)*t1523+P(9,3)*t1526;
nextP(1,7) = t1454;
nextP(2,7) = -t1527-t1528+P(2,7)*t1468+P(3,7)*t1472;
nextP(3,7) = -t1553-t1554+P(1,7)*t1491+P(3,7)*t1503;
nextP(4,7) = P(4,7)+t1580-P(3,7)*t1506+P(2,7)*t1573;
nextP(5,7) = t1598;
nextP(6,7) = t1621;
nextP(7,7) = P(7,7);
nextP(8,7) = P(8,7);
nextP(9,7) = P(9,7);
nextP(1,8) = t1457;
nextP(2,8) = -t1529-t1530+P(2,8)*t1468+P(3,8)*t1472;
nextP(3,8) = -t1555-t1556+P(1,8)*t1491+P(3,8)*t1503;
nextP(4,8) = P(4,8)+t1581-P(3,8)*t1506+P(2,8)*t1573;
nextP(5,8) = t1601;
nextP(6,8) = t1624;
nextP(7,8) = P(7,8);
nextP(8,8) = P(8,8);
nextP(9,8) = P(9,8);
nextP(1,9) = t1460;
nextP(2,9) = -t1531-t1532+P(2,9)*t1468+P(3,9)*t1472;
nextP(3,9) = -t1557-t1558+P(1,9)*t1491+P(3,9)*t1503;
nextP(4,9) = P(4,9)+t1582-P(3,9)*t1506+P(2,9)*t1573;
nextP(5,9) = t1604;
nextP(6,9) = t1627;
nextP(7,9) = P(7,9);
nextP(8,9) = P(8,9);
nextP(9,9) = P(9,9);

% Add the general process noise
for i = 1:9
    nextP(i,i) = nextP(i,i) + processNoise(i)^2;
end

% Force symmetry on the covariance matrix to prevent ill-conditioning
% of the matrix which would cause the filter to blow-up
P = 0.5*(P + transpose(P));

% ensure diagonals are positive
for i=1:9
    if P(i,i) < 0
        P(i,i) = 0;
    end   
end

end