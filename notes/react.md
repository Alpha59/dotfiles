# React

React is a framework developed by Facebook for creating Single Page Applications (SPA), with the intention of creating a more seamless in-browser User experience, by reducing the amount of requests to the server for HTML files. This process is achieved by loading a single HTML page, and then using JavaScript logic to render, re-render, and hide various DOM elements in the page - without requesting new HTML from the server. This process gives users the illusion of navigating through a traditional website, while reducing the load time for each page significantly. Many web frameworks exist to accomplish this goal, and React is by no means unique in the offering of an SPA focused framework.

Manipulation of the rendered HTML requires extensive manipulation of the Document Object Model (DOM) in the browser. The DOM is the mechanism that browsers use to render and show various HTML elements in an hierarchy - creating a Node Tree. Since the operation of the DOM requires (by design) the re-rendering of the manipulated nodes, inefficient DOM manipulation is extremely slow, and creates a "choppy" user experience. To solve this issue, React pioneered the usage of the Virtual DOM,  which creates a light weight node tree, separate from the DOM, and only makes DOM changes as they are required - and in the most efficient way it can find.

The Virtual DOM is comprised of JavaScript elements, managed by developers and React in the JSX format - which is a modified JavaScript format resembling simple HTML. This format is not required, but is the most popular development style for React. Of course, server side requests will still be required in a Single Page Application - to interact with the Database, and other micro-services downstream of the user facing application. These requests are always Asynchronous in React, which allows the page to immediately update in response to the user's action, and update again in response to the server response. Again, this process is not unique to React, but is critical to the understanding of React development.

React is not however limited to SPA Applications in the browser. In 2015 Facebook released React Native - and uses it to build their own customer facing mobile applications. React Native does not use the DOM in the same way, but does use the Virtual DOM. This allows React Native Applications to share a large portion of logic, code, and coding style with traditional React Applications. Facebook is also working on a Virtual Reality React Framework.

React requires JSX components to be converted to standard JS using a cross compilation, which is implemented in Node.js. This makes Node.js a requirement for React development. Many React applications utilize Server-side rendering on initial page load. This process is primarily used to create a faster user experience, and to allow Search Engine Optimization. Server-side rendering is user in almost all publicly available, and searchable SPAs, but is optional. React Server-side rendering requires that an application be served by a Node.js server, since the React Code is Node.js. A popular option, to avoid problems with Node.js servers at scale, is to use a separate web-server (NGINX, Apache) to serve a Node.js application. This method is required to help scale applications. React Applications developed using Node.js benefit immediately from the use of hot-reloading. Other web-servers can be used to implement hot-reloading as well, but not all web-servers can support hot-reloading of React components. This should effect the decision of which web-server technology to use.

## Why use React?

### Angular 1.x

Angular is a reconstruction of the HTML implementation that attempts to remedy the document model in HTML. Angular uses a document model structure known as MCV. MVC, or Model View Controller, separates an application into 3 distinct functionalities. The MVC model is not new to Angular, and does not apply only to front-end applications. Several full stack applications (including .NET) use the MVC model, or a variation of it.

In the MVC structure, the Model is charged with handling all of the data for an application. In angular applications, these services often interact with the server, but do not have to. The model implements a series of data handling functions which update, and query data from a data store. Models for local applications may utilize different forms of local storage or web storage to maintain a state. Extremely simple applications may only use a JavaScript Object or an array as the data model. These applications would not be able to maintain their state on a page refresh. Application that utilize local storage would have a limited amount of state storage, and data would not be available across multiple browsers or devices. This may be ok for certain applications, but most applications rely on a micro-service architecture to store and manage data behind the scenes. Earlier implementations of the MVC model would no doubt have relied on a REST HTTP Application as their data storage service.

The View in the MVC Structure is the visual representation on the page. The view is often coupled with the controller, and will have direct access to controller variables when rendered. In Angular, and most Web applications, the View is comprised of a series of html files which can be joined together, and that utilize a templating language to substitute values, and iterate across various model data arrays.

The Controller is responsible for responding to user inputs and preforming actions on the data model objects. As a user interacts with the page, the controller will catch all user events, and use them to update or fetch data from the model, and then translate them into data to be rendered in the View. The controller and view use a system of two way data binding to attach data elements between HTML and JS. This means that any updates to either the controller data, or view inputs, will immediately trigger the corresponding updates in the other.

This two way binding model (or more specifically, the implementation of it) led to extremely poor performance in larger applications. As the amount of bound data in an application grew, the performance hit a point of failure for many client systems. This combined with the number of poorly developed applications led the Angular 1.x framework to be deprecated in 2018. Long term support (KTLO) ended in 2021.

### Angular 2+

Angular 2 was a complete re-architecture of Angular, and although based on the same MVC concept, it was not an upgraded version - but instead a completely new Framework. Performance was improved by moving away from the concept of global scope, and into the concept of minimally scoped components. This component structure also led to better scalability, and less developer induced bugs.

Angular components are direct markers to DOM elements, which angular tracks in the DOM. Angular still separates HTML and JS into different modules, but relies on html markers and templates to determine what HTML should be rendered to the page. This leads to re-rendering of the page, and slower performance than React, but is still more performant and scalable than Angular 1.x.

### Meridian

Meridian is not a separate framework, but a supported internal operations component library. This is the recommended library for Operations systems inside of Amazon. This is a funded and supported team within the Amazon eco-system, and provides realtime support for development in React. The use of Meridian is not required (although strongly suggested) in the Devices organization, which makes it an important factor in deciding between Angular, and React. Since Meridian is only React compatible.

### Polaris

Much like meridian, Polaris is an internal component library specifically designed for use with the AWS Console. AWS systems built using Polaris have a distinct look (like the AWS Console). Polaris is a required component for AWS teams, but is available for use by other teams at Amazon. The predecessor to Polaris was a framework called “Chocolate”.

### AUI

Amazon UI is a library and a set of discrete tools that are used to build the Amazon shopping experience. It is a highly opinionated library for developer organization. Meant to bridge the gab between Desktop and Mobile applications. Not a React Library, but React components are available. The AUI system is designed to be a complete build system.

### Stencil

Stencil is another React Component library designed specifically for use on HR websites internal to Amazon.

## Components

The basic building blocks in React are the Components. React is comprised of a single Application component, and any number of child components under this. Each component is just a special V-DOM subtree built in JSX that will be rendered out as HTML. The advantage of this architecture is the ability to re-use components throughout the application, or across multiple applications. The ability to use across multiple applications allows developers to import component libraries to provide users seamless experiences, and reduce the amount of code needed to create a production ready application experience. The Component architecture also allows developers to break the application into any visual styling they prefer, and think of each component as an independent set of functionalities.

A simple component is comprised of several parts - but will always `extend` the React `Component` class. Inside the component, the render function is then the only required function - which tells react what to do when it needs to render, re-render, or create this component. There are two types of components, a Functional or Class component. Functional components use a similar syntax to Class components, but do not implement a render statement - and instead simply return the JSX code that they manage from the functional implementation. Class components are the most commonly used and developed components at the application level.


### Creating a component

Class components always start with two simple constructs.

1. Extending the `React.Component` Class.
2. Implementing a render function

The Render function returns the JSX object that will be inserted into the DOM when this component is rendered. The JSX Object must return a single Root element to identify the node. This can be any JSX element, but using a `div` component is a common practice for wrapping multiple components. In order to make the component available across the application, the Class must be exported. This leaves the most basic react component as `export class A extends React.Component { render(){ return (<div/>)}}`. This component doesn't do anything, but it is a component. A component like this may be implemented as a placeholder for DOM elements which do not exist yet. Once a component is created, it can be imported to other components, and rendered as sub-components of their JSX.

The creation of a custom React component, which can be passed around, inherited, and optionally rendered on the page is the basis for the creation of React Applications. In order to use a component, it must first be imported to the calling component. You are able to import React components which exist directly in React, Custom created application components, or Library components. All three of these component types are treated as equals in the React JSX DOM, and are rendered using the same methodology as any other react component.

Just like any other class, one function does not normally implement all of the functionality. In React, JavaScript functions can be implemented as standard Class Level functions using the standard syntax. Some special React Functions are called throughout the lifecycle of the React component, which is handled by the parent `Component` class, but any user defined function will be treated as a standard JavaScript function. At this point, it is important to understand a main function of React Components. They are JavaScript. In fact, a React component can be written with JSX at all - and when cross-compiled into JavaScript, the JSX syntax is removed. This helps understand that JSX Components can be treated exactly like a JavaScript object, which can be returned from functions - passed as a function parameter, or saved into a JavaScript Object.

When working with some special React Components, particularly components which are implemented as a series of sibling DOM elements, React enforces the use of an identifier in the form of `key`. The use of the `key` is required for certain react functionality to operate properly on components like lists or tables, but is available as a parameter to all React components.

### Component Props

When working in XML, each DOM element can have a series of props assigned to it. In order to stay true to XML when creating JSX, the same concept applies. A property can be attached to the JSX component, in the same format as an XML property, and will be passed to the JSX component as part of the components property object upon instantiation. Unlike XML Props, JSX Props can be any JavaScript variable, object, or even a JSX Object (remember, JSX is just JS). Accessing props inside of a React Component is done be simply referencing `this.props` which accesses the Class level `this` and the class level JavaScript Object `props`. Props can be used in a variety of ways, and are the control mechanism for changing the internal properties of a class object. In React, the use of calling class functions outside of the class is not allowed.

All functions inside of a React Component class should be viewed as private functions, which need to be called or accessed by changing a property of the Classes instantiation. In the same way, props should not be modified inside the component, and the `this.props` object should be treated as immutable. This is not enforced, but leads to unpreditable behavior. This pattern of data management is important to the optimization of React's Virtual DOM, and can therefore be unpredictable, slow, or dangerous to violate. Props are therefore always passed down through the hierarchy.

A special case of props is `props.children` which are JSX Components passed into the component via the XML Children format. This special component case allows a higher level component to manage the child components, or inner workings, or a React component, without needing to interact with the React Component directly.

### Component State

For every React component, there is also a `this.state` object. The State object within a react component holds the local state. Just like props, state has various rules associated with it's usage. For one, a state is private to a Single Component. State does not get shared or modified by any other components. Additionally, state should never be modified directly. React provides a function in every component, known as `this.setState`, which is used to modify the state. State modifications outside of this function will lead to unpredictable, or dangerous behavior.

In order to access the state, the React component needs to implement a constructor method - which calls `super(props)` to load the parent class (`Component`) constructor. After this, the `this.state = {}` variable can be created. State is always an object. Other than these special cases, state and props act in very similiar ways.

### Component Events

JavaScript, and therefore React, are extremely Event based. This is in response to the fact that the primary event creator in JavaScript is the End User. End user behavior can not be predicated, and therefore, we need the end user to tell us when they have performed an action. This action may be an click, a hover, a drag, etc - but however the end user chooses to interact with a React component - the developer will need to monitor the events, and add event handlers. In React, the event handler is attached to a DOM component using the same syntax that would be used on a JavaScript component for attaching the event handler. This is to say, when monitoring for a click event, the syntax would be `onClick={(evt) => console.log("clicked", evt)}`. This event handler can be any function, and can be used to perform any actions, or state modifications within the component.

### Component Rendering

Inside a component, the use of Conditional Rendering is used throughout the JSX to decide which elements exist or not on the page. Unlike a traditional HTML application - where the DOM is populate with many (if not all) of the components, and then hidden when not in use, the React Framework focuses on the idea of only including components when needed. An example may be for a boolean prop, 2 different components can be chosen (Red Box, Blue Circle). Only the rendered component should be returned as part of the render function. This leads to a large number of ternary statements throughout many react applications. This is not required, but can be useful for cleaning up the code. Another common React statement is the use of short circuit if statements `isTrue() && <Component/>`, which is another method for quickly determining if a component should be included. The use of either methodology is considered optional, and stylistic.

### Component Lifecycle

In every react component, there are a series of existing class level functions that are called through the lifecycle of a component. In JavaScript classes, there is not special syntax to override a class function, so simply declaring the function using the correct naming will cause the component to call your lifecycle function. Lifecycle functions have no default behavior - but are called at specific times, allowing the developer to modify state or read props. These special functions are known as Lifecycle Hooks.


* `render`: This function is called when a component needs to be rendered by the JSX. This is the last thing to be called before adding a JSX component to the virtual DOM.
* `componentDidMount`: This function is called after a component has been rendered into the DOM. This component is where longer initialization actions (Ajax requests) should live, which will allow the component to be created on the page immediately - and then updated by the appropriate server data afterwards.
    * Understanding the usage of this an be explained by thinking of a `loader` element. Elements relying on server data for render should have a "loading" state, which is initialized in the constructor. The Component Did Mount hook will call to the server to retrieve relevant data, and then render that data when it is returned. When the data is returned Asynchronously, the loading element can be removed from the component
* `shouldComponentUpdate` is used to determine if a re-render is required based on a data change. In the case where this is not specified, a component will re-render in response to any changes to the State. In some cases, this may lead to poor performance, if the state is updating rapidly without any UI changes required. In this case, developers should prevent the update by implementing this hook
* `componentDidUpdate` is called after a component updates, and can be used as a hook to kick off post-update calls. this is useful for background tasks that can be performed asynchronously after the real time updates have been presented to a user.
* `componentWillUnmount` this should not be used to prevent a component from un-mounting. This is run after a component has already been determined to be leaving the DOM. This hook is primarily intended for data clean-up, and the removal of and lingering listeners or storage that will not be needed if this component does not exist.

## Routing

Routing in React happens at the highest level, and is performed through the use of a Routing component. The routing component in React allows the use of more traditional url paths, with the tradeoff that the `<Link/>` component must be used to replace all `<a/>` tags.

## Redux

Redux is an implementation of the Flux Architecture, which is an abstract description of data management in an application. Flux takes advantage of unidirectional data flow, always moving data in the same direct. The core concepts of the Flux design architecture are “Action”, “Dispatcher”, and “Store”. An action is any event or change in the system which can be listened for. These events are primarily considered to be Asynchronous, and are triggered at an unknown time. The Dispatcher acts as a universal handler for all actions - with each action receiving a single dispatcher. The Store, is the data store - which is any datastore or object storage which can maintain the information required for the application.

Within the Flux pattern, a series of events are always true:

* Stores subscribe (listen for) to an action
* Action is sent to dispatcher
* Dispatcher notifies all subscribed stores
* Stores are updated based on their state
* View is updated based on the new state
* Rinse and Repeat

Compared to standard architectures, where a single event will trigger multiple event handlers, Flux allows for a single event to always map to a single event handler. This event handler will then modify the state (based on the event and the current state) to create changes in the view.

In Redux, there is a slight difference, since JavaScript acts as the handled dispatcher. Because of this, the Reducer is introduced to replace any data modification, or state change, which would previously have been described by the Dispatcher. Redux uses only one store, which is relatively inconsequential since it can be broken up in any way, but differs from Flux where any number of stores can be defined. In the redux implementation, every time an Action occurs, all of the reducers are called. They can choose to ignore this action, if they have nothing to modify in the store due to this action. If the action pertains to the reducer, then the reducer will modify the store accordingly.

Redux, however, defines the state as being immutable. For this reason, each reducer must replace the state with a new copy, opposed to update the original state. This is designed to prevent reaching impossible states within the application. This immutable state also makes it easier for the view to prevent unnecessary updates, since Redux is able to prevent the view from updating when the state object being passed in is not modified compared to the state object it is already holding in the store.

### Redux in React

Although redux started out as a library specifically for React, it is in fact Framework independent, and is now used in a number of other UI frameworks. In react, only a few concepts are required:


* Redux properties are mapped into the Objects Props
* `this.props.dispatch` is the function that sends an event to Redux.
* `connect` returns a function that a React component can be passed into

Other than these notes, Redux can be implemented in React the same way it would be in any other implementation.


## Server Side Rendering

React frameworks load the entire SPA application into the browser before beginning the rendering process. For many applications, this can be a large amount of data to be loaded - and will lead to a long “Time to First Paint”. For this reason, server side rendered applications have risen to popularity. This allows the “Time to First Paint” to be reduced to the same as a standard Multi-Page Application. This improves user experience, and SEO.

## Isomorphic Applications

Although the server does not need to be the same codebase as the front-end, the use of Node.js or Isomorphic Application development, allows both Server-side and Client-side code to be shared. Since the application code is shared, the rendering logic can be re-used, as can business and database logic. Use of Isomorphic Application development does limit the choice of application code - since JavaScript is the only universally supported client side language. Some variations of JavaScript and JavaScript cross-compiled languages, like TypeScript or CoffeeScript are able to be used in both client and server code.

## Conclusion

For an additional quick start guide, please visit Sue Lee’s: [Quick guide how to code in React](https://quip-amazon.com/saQfAqx0C7v6)
* * *
*--wiki-sync: "*[*Users/ailor/React*](https://w.amazon.com/bin/view/Users/ailor/React)*"--*


