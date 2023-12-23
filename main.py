import clips
import PySimpleGUI as sg



def main():
    sg.theme('DarkBlue')
    layout = [[sg.Text('Typeface Expert System',justification='center', font=("Helvetica", 40))], [sg.Button("Let's choose font")]]
    
    window = sg.Window('Typeface Expert System', layout, size=(800, 800))

 

    # -----------------------
    env = clips.Environment()
    env.load('typeface.clp')
    env.reset()
    env.run()

    for fact in env.facts():
        if fact.template.name == 'message':
          message = fact
            
    if not message:
        print("No 'message' facts found. Please check your CLIPS rules.")
        return

    while 1:
        event, values = window.read()
        if event == "Let's choose font":
            exit() # działa



        print('Question:', message['question'])
        answers = message['answers']
        print("Options:", ", ".join(answers))

        user_input = input("Your answer: ").strip()

        print({message["name"]}, {user_input})

        if user_input in answers:
            message.modify_slots(name=message["name"], answers=[user_input])
        else:
            print("Invalid response, please try again.")

        env.run()
    
        for fact in env.facts():
            if fact.template.name == 'message':
                message = fact
            elif fact.template.name == 'exit':
                ifExit = fact
                print('The end flowchart, exit without chosen typeface.')
            elif fact.template.name == 'typeface':
                typeface = fact
                exit()           

        
if __name__ == "__main__":
    main()
