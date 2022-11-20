#include <iostream>
#include <thread>
#include <vector>
#include <mutex>
#include <string>
#include <memory>

using namespace std;

static mutex smux;

struct Resource
{
	Resource()
	{
		cout << "C" << endl;
	}

	~Resource()
	{
		cout << "D" << endl;
	}
};

void task(int id)
{
	//lock_guard<mutex> g(smux);
	cout << "S" << id << endl;

	//Resource r; 													// owned by thread
	//static Resource r; 											// shared
	//unique_ptr<Resource> r_p = make_unique<Resource>(); 			// owned by thread
	//static unique_ptr<Resource> r_p = make_unique<Resource>(); 	// shared
	//Resource* r = new Resource; 									// owned by thread, need delete
	//static Resource* r = new Resource; 							// shared need delete

	cout << "E" << id << endl;
}



void threadJoinMain()
{
	vector<thread> tv;
	for (int i = 0; i < 3; i++) {
		thread t(task, i);
		tv.push_back(move(t));
	}
	for (auto& t: tv) {
		t.join();
	}
}

void threadDetachMain()
{
	vector<thread> tv;
	for (int i = 0; i < 3; i++) {
		thread t(task, i);
		t.detach();
	}
}

int main(int argc, char *argv[])
{
	cout << "Mstart" << endl;
	threadJoinMain();
	//threadDetachMain();
	cout << "Mend" << endl;
}