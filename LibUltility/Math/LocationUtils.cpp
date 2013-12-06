//
//  LocationUtils.cpp
//  123Phim
//
//  Created by Le Ngoc Duy on 8/2/13.
//  Copyright (c) 2013 Phuong. Nguyen Minh. All rights reserved.
//

#include "LocationUtils.h"
#include <math.h>
/**
 * Lấy độ chênh lệch vĩ độ tương ứng với 50 mét
 */
double LocationUtils::getApproximateLatitudeForMetres(double latitude,
                                                     double longitude, float metres) {
    
    double delta = 0.0005;
    double distance = computeDistance(latitude, longitude,
                                      latitude + delta, longitude);
    double ratio = metres / distance;
    double result = delta * ratio;
    return result;
}

/**
 * Lấy độ chênh lệch kinh độ tương ứng với 50 mét
 */
double LocationUtils::getApproximateLongitudeForMetres(double latitude,
                                                      double longitude, float metres) {
    
    double delta = 0.0005;
    double distance = computeDistance(latitude, longitude, latitude,
                                      longitude + delta);
    double ratio = metres / distance;
    double result = delta * ratio;
    return result;
}

/**
 * Tính khoảng cách giữa 2 điểm dựa theo kinh độ và vĩ độ của 2 điểm đó
 */
double LocationUtils::computeDistance(double lat1, double lon1, double lat2,
                                     double lon2) {
    // Based on http://www.ngs.noaa.gov/PUBS_LIB/inverse.pdf
    // using the "Inverse Formula" (section 4)
    
    int MAXITERS = 20;
    // Convert lat/long to radians
    lat1 *= M_PI / 180.0;
    lat2 *= M_PI / 180.0;
    lon1 *= M_PI / 180.0;
    lon2 *= M_PI / 180.0;
    
    double a = 6378137.0; // WGS84 major axis
    double b = 6356752.3142; // WGS84 semi-major axis
    double f = (a - b) / a;
    double aSqMinusBSqOverBSq = (a * a - b * b) / (b * b);
    
    double L = lon2 - lon1;
    double A = 0.0;
    double U1 = atan((1.0 - f) * tan(lat1));
    double U2 = atan((1.0 - f) * tan(lat2));
    
    double cosU1 =  cos(U1);
    double cosU2 = cos(U2);
    double sinU1 = sin(U1);
    double sinU2 = sin(U2);
    double cosU1cosU2 = cosU1 * cosU2;
    double sinU1sinU2 = sinU1 * sinU2;
    
    double sigma = 0.0;
    double deltaSigma = 0.0;
    double cosSqAlpha = 0.0;
    double cos2SM = 0.0;
    double cosSigma = 0.0;
    double sinSigma = 0.0;
    double cosLambda = 0.0;
    double sinLambda = 0.0;
    
    double lambda = L; // initial guess
    for (int iter = 0; iter < MAXITERS; iter++) {
        double lambdaOrig = lambda;
        cosLambda = cos(lambda);
        sinLambda = sin(lambda);
        double t1 = cosU2 * sinLambda;
        double t2 = cosU1 * sinU2 - sinU1 * cosU2 * cosLambda;
        double sinSqSigma = t1 * t1 + t2 * t2; // (14)
        sinSigma = sqrt(sinSqSigma);
        cosSigma = sinU1sinU2 + cosU1cosU2 * cosLambda; // (15)
        sigma = atan2(sinSigma, cosSigma); // (16)
        double sinAlpha = (sinSigma == 0) ? 0.0 : cosU1cosU2 * sinLambda
        / sinSigma; // (17)
        cosSqAlpha = 1.0 - sinAlpha * sinAlpha;
        cos2SM = (cosSqAlpha == 0) ? 0.0 : cosSigma - 2.0 * sinU1sinU2
        / cosSqAlpha; // (18)
        
        double uSquared = cosSqAlpha * aSqMinusBSqOverBSq; // defn
        A = 1
        + (uSquared / 16384.0)
        * // (3)
        (4096.0 + uSquared
         * (-768 + uSquared * (320.0 - 175.0 * uSquared)));
        double B = (uSquared / 1024.0) * // (4)
        (256.0 + uSquared
         * (-128.0 + uSquared * (74.0 - 47.0 * uSquared)));
        double C = (f / 16.0) * cosSqAlpha
        * (4.0 + f * (4.0 - 3.0 * cosSqAlpha)); // (10)
        double cos2SMSq = cos2SM * cos2SM;
        deltaSigma = B
        * sinSigma
        * // (6)
        (cos2SM + (B / 4.0)
         * (cosSigma * (-1.0 + 2.0 * cos2SMSq) - (B / 6.0)
            * cos2SM
            * (-3.0 + 4.0 * sinSigma * sinSigma)
            * (-3.0 + 4.0 * cos2SMSq)));
        
        lambda = L
        + (1.0 - C)
        * f
        * sinAlpha
        * (sigma + C
           * sinSigma
           * (cos2SM + C * cosSigma
              * (-1.0 + 2.0 * cos2SM * cos2SM))); // (11)
        
        double delta = (lambda - lambdaOrig) / lambda;
        if (abs(delta) < 1.0e-12) {
            break;
        }
    }
    
    double distance = (b * A * (sigma - deltaSigma));
    return distance;
}