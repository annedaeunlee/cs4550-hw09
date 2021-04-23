// Some parts of code below were taken from Professor Nat Tuck's scratch repository 

import store from './storage/store';

export async function api_get(path) {
    let text = await fetch("http://events-spa-server.annelee2001.com/api/v1" + path, {});
    let resp = await text.json();
    return resp.data;
}

export async function api_post(path, data) {
    let opts = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data),
    };
    let text = await fetch("http://events-spa-server.annelee2001.com/api/v1" + path, opts);
    return await text.json();
}

export function fetch_users() {
    api_get("/users").then((data) => store.dispatch({
        type: 'users/set',
        data: data,
    }));
}

export function fetch_posts() {
    api_get("/posts").then((data) => store.dispatch({
        type: 'posts/set',
        data: data,
    }));
}

export function load_defaults() {
    fetch_users();
    fetch_posts();
}

export function api_login(name, password) {
    api_post("/session", { name, password }).then((data) => {
        console.log("login resp", data);
        if (data.session) {
            let action = {
                type: 'session/set',
                data: data.session,
            }
            store.dispatch(action);
        } else if (data.error) {
            let action = {
                type: 'error/set',
                data: data.error,
            };
            store.dispatch(action);
        }
    });
}

export function create_post(post) {
    let data = new FormData();
    data.append("post[photo]", post.photo);
    data.append("post[body]", post.body);
    fetch("http://events-spa-server.annelee2001.com/api/v1/posts", {
        method: 'POST',
        // Fetch will handle reading the file object and
        // submitting this as a multipart/form-data request.
        body: data,
    }).then((resp) => {
        console.log(resp);
    });
}

export function create_user(user) {
    return api_post("/users", { user });
}
