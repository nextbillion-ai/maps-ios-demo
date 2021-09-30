#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "APIConstants.h"
#import "NBRoute.h"
#import "NBRouteResponse.h"
#import "DistanceMatrixResponse.h"
#import "SnapToRoadResponse.h"
#import "NGLFoundation.h"

NGL_EXPORT

@interface NBAPIClient : NSObject

- (void) enqueueGetDirections;
- (void) getDirections:(const CLLocationCoordinate2D *) coords handler: (void(^)(NBDirectionResponse *)) handler;
- (void) getMatrix:(NSArray *) origins destinations: (NSArray *) destinations handler: (void(^)(DistanceMatrixResponse *)) handler;
- (void) getMatching:(NSArray *) path handler:(void(^)(SnapToRoadResponse *)) handler;

- (NSString*) getLocationString:(CLLocationCoordinate2D) location;

@property (nonatomic, copy) void (^completionHandler)(NBDirectionResponse *resp);
@property (nonatomic, copy) void (^matrixCompletionHandler)(DistanceMatrixResponse *resp);
@property (nonatomic, copy) void (^matchingCompletionHandler)(SnapToRoadResponse *resp);
@end
