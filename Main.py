import streamlit as st
import subprocess

with st.sidebar:
    "[View the source code](https://github.com/nuttea/cloudrun-exec-streamlit)"

st.title("Cloud Run Shell Exec")

# Create a function to make python run shell commands
def run_shell_command(command):
    output = subprocess.run(command, shell=True, capture_output=True, text=True)
    print(output.stdout)
    print(output.stderr)
    return output

# Create a Streamlit input text box with submit button to run run_shell_command function
command = st.text_input("Enter a shell command:")
if st.button("Run"):
    output = run_shell_command(command)
    st.markdown(output.stdout)
    st.markdown(output.stderr)
