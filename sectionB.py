#QUESTION 11
class Student:
    def __init__(self, name, marks):
        self.__name = name
        self.__marks = marks

    def get_name(self):
        return self.__name

    def get_marks(self):
        return self.__marks

    def display(self):
        print("Name:", self.__name)
        print("Marks:", self.__marks)


# Creating object
s1 = Student("Rahul", 85)

# Display details
s1.display()


#question 12
try:
    with open("students.txt", "r") as file:
        data = file.read()

        lines = data.splitlines()
        words = data.split()

        print("Total Lines:", len(lines))
        print("Total Words:", len(words))

except FileNotFoundError:
    print("Error: File not found!")
