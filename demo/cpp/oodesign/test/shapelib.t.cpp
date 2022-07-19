#include <gtest/gtest.h>
#include "../src/shape.cpp"

TEST(ShapeTest, setID)
{
	Shape* s_p = new Shape("p05");
	ASSERT_EQ(s_p->asString(), "p05");
}

int main(int argc, char **argv) {
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}