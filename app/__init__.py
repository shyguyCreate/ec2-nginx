from flask import Flask, render_template

app = Flask(__name__)

member1 = input("Enter team member: ")
member2 = input("Enter team member: ")
member3 = input("Enter team member: ")

# Anadir a los miembros manualmente
# member1 =
# member2 =
# member3 =


@app.route("/")
def hello_world():
    return render_template(
        "index.html", member1=member1, member2=member2, member3=member3
    )


# Run app
if __name__ == "__main__":
    app.run()
