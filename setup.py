from setuptools import find_packages,setup
from typing import List

hypen_e_dot='-e .'

def get_requirements(file_path:str)->List[str]:
    '''
    This function will return the list of requirements
    '''

    requirements=[]
    with open(file_path) as file_obj:
        requirements=file_obj.readlines()
        requirements=[req.replace("\n","") for req in requirements] #Reads the reqirements.txt line by line

        if hypen_e_dot in requirements:
            requirements.remove(hypen_e_dot)

    return requirements

setup(
    name='Baseball',
    version='0.0.1',
    author='Jeremy Rocheleau',
    author_email='Jeremy_rchl@yahoo.com',
    packages=find_packages(),
    install_requires=get_requirements('requirements.txt')
)