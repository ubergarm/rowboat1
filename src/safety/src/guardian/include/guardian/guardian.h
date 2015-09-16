#ifndef GUARDIAN_H_ 
#define GUARDIAN_H_

#include <string>
#include <map>

#include <ros/ros.h>
#include <ros/package.h>

namespace rowboat1
{
    class Guardian
    {
    public:
        Guardian(ros::NodeHandle &nh);
        ~Guardian();
    
    private:
        void subscribeToHeartbeats();
        void subscribeToStatuses();
	void heartbeatsCB();

        ros::NodeHandle nh_;
        ros::Subscriber sub_;
		ros::Rate loopRate_;

		int heartbeatBufferMax_;
		std::vector<ros::Subscriber> heartbeatSubs_;
		std::vector<std::string> guardedNodes_;
		std::map<std::string,std::map<int,std::string> > heartbeatAlerts_;
    }
} // end namespace rowboat1

#endif // GUARDIAN_H_
