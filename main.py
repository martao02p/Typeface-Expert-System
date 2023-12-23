import clips
import PySimpleGUI as sg

def createQuestionLayout(question, answers):
    return [
                [sg.Text('Typeface Expert System',justification='center', font=("Helvetica", 40))],
                [sg.Text(key='-question-', pad=(0, 10), text=question, justification='center', font=("Helvetica", 20))],
                [[sg.Button(key=answer, button_text=answer)] for answer in answers]
            ]
                
def createTypefaceLayout(typeface):
    return [
                [sg.Text('Typeface Expert System',justification='center', font=("Helvetica", 40))],
                [sg.Text(key='-question-', pad=(0, 10), text=f'Perfect font for you: {typeface}', justification='center', font=("Helvetica", 20))],
                [sg.Button('New')],
                [sg.Cancel()]
            ]

def createExitLayout():
    return [
                [sg.Text('Typeface Expert System',justification='center', font=("Helvetica", 40))],
                [sg.Text(key='-question-', pad=(0, 10), text=f'Get out of my flowchart!', justification='center', font=("Helvetica", 20))],
                [sg.Button('New')],
                [sg.Cancel()]
            ]

def main():
    sg.theme('DarkBlue12')
    layout = [[]]
    
    window = sg.Window('Typeface Expert System', layout, size=(600, 400), finalize=True)

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
        ifExit = None
        typeface = None

        print(message)

        layout = createQuestionLayout(message['question'], message['answers'])
        window.close()
        window = sg.Window('Typeface Expert System', layout, size=(600, 400), finalize=True)

        event, values = window.read()

        if event in message['answers']:
            message.modify_slots(name=message["name"], answers=[event])
        elif event in (None, 'Exit'):
            break;
        else:
            print("Invalid response, please try again.")

        env.run()
    
        for fact in env.facts():
            if fact.template.name == 'exit':
                ifExit = fact
                print('The end flowchart, exit without chosen typeface.')
            elif fact.template.name == 'typeface':
                typeface = fact
                # exit()  

        if typeface is not None:
            layout = createTypefaceLayout(typeface['name'])
            window.close()
            window = sg.Window('Typeface Expert System', layout, size=(600, 400), finalize=True)
            event, values = window.read()

            if event == 'New':
                env.reset()
                env.run()

                for fact in env.facts():
                    if fact.template.name == 'message':
                        message = fact

                continue;

            if event == 'Cancel':
                break;
        
        if ifExit is not None:
            window.close()
            window = sg.Window('Typeface Expert System', createExitLayout(), size=(600, 400), finalize=True)
            event, values = window.read()

            if event == 'New':
                env.reset()
                env.run()

                for fact in env.facts():
                    if fact.template.name == 'message':
                        message = fact

                continue;

            if event == 'Cancel':
                break;
                
    window.close()
        
if __name__ == "__main__":
    main()
