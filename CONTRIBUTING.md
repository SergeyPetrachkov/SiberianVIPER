## Some easy steps
1. Create a fork.
2. Checkout develop.
3. Use gitflow to create a feature branch.
4. Implement your thing.
5. Clean code if needed.
6. Submit pull request.

## How to write commits messages?
Not only a commit message must contain a short description of changes done in this commit but a short description of why any work had been done.
Every developer can see the difference between two commits but it's very important to know why it has been done.

Bad commit message example:
```
changed DummyViewController
```

Good commit message example:
```
updated DummyViewController with dummy things to match another dummy thing
```
or even better:
```
refs #999 - fixed bug where app would crash when entering DummyViewController

the reason of crash was incorrect handling of setup values"
```
Another idea is to add references to tickets one's working on. Popular management systems like unfuddle or redmine can monitor repositories and link commits to tickets, so a customer or a project manager/ teamleader or a person who performs code review can just open a ticket and see all the work done for that ticket.
