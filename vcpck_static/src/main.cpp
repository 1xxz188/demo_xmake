#include <iostream>
#include <string>
#include <yaml-cpp/yaml.h>


int main(int argc, char** argv)
{
    try
	{
        std::cout << "=== YAML Test Program ===" << std::endl;
        YAML::Node m_config = YAML::LoadFile("test.yaml");
        if (auto yamlServerId = m_config["ServerId"]; yamlServerId && yamlServerId.Type() == YAML::NodeType::Scalar)
        {
            auto iServerId = yamlServerId.as<uint16_t>();
            printf("yaml test ms[%d]\n", iServerId);
        }
        std::cout << "=== YAML Test Program End ===" << std::endl;
    }
    catch (std::exception& e) 
    {
        std::cout << "YAML Unexpected: " << e.what() << std::endl;
        return -1;
    }
    return 0;
}
