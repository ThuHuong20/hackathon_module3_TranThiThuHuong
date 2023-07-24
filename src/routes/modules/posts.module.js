import express from 'express';
const router = express.Router();
import fs from "fs"
import path from "path";


router.get('/:postId', (req, res) => {
    if (req.params.postId) {
        fs.readFile(path.join(__dirname, 'posts.json'), 'utf-8', (err, data) => {
            if (err) {
                return res.status(500).json(
                    {
                        message: 'Get data failed !'
                    }
                )
            }
            let postsData = JSON.parse(data);
            for (let i in postsData) {
                const post = postsData.find(post => post.id == req.params.postId)
                fs.writeFile(path.join(__dirname, 'posts.json'), JSON.stringify(postsData), (err) => {
                    if (err) {
                        return res.status(500).json(
                            {
                                message: 'Save data failed !'
                            }
                        )
                    }
                    return res.status(200).json(
                        {
                            data: post
                        }
                    )
                })
            }

        })

    } else {
        res.status(500).json(
            {
                message: 'Failed!!!',
            }
        )
    }

})


router.get('/', (req, res) => {
    fs.readFile(path.join(__dirname, "posts.json"), 'utf-8', (err, data) => {
        if (err) {
            return res.status(500).json(
                {
                    message: "failed",
                }
            )
        }
        if (req.query.id) {
            let posts = JSON.parse(data).find(posts => posts.id == req.query.id);
            if (posts) {
                return res.status(200).json(
                    {
                        data: posts
                    }
                )
            } else {
                return res.status(500).json(
                    {
                        message: `Không tìm được thaays post ${req.query.id}`

                    }
                )
            }
        }

        return res.status(200).json(
            {
                message: "Lay post thanh cong",
                data: JSON.parse(data)
            }
        )
    })
})


router.post('/', (req, res) => {

    fs.readFile(path.join(__dirname, "posts.json"), 'utf-8', (err, data) => {
        if (err) {
            return res.status(500).json(
                {
                    message: "Đọc dữ liệu thất bại!"
                }
            )
        }

        let oldData = JSON.parse(data);

        let newPost = {

            id: Date.now(),
            ...req.body
        }

        oldData.unshift(newPost)

        fs.writeFile(path.join(__dirname, "posts.json"), JSON.stringify(oldData), (err) => {
            if (err) {
                return res.status(500).json(
                    {
                        message: "Ghi file thất bại!"
                    }
                )
            }
            res.status(200).json({
                message: "Add post success!",
            })
        })
    })

})

router.patch("/:id", (req, res) => {
    fs.readFile(path.join(__dirname, "posts.json"), 'utf-8', (err, data) => {

        const dataObj = JSON.parse(data)
        let postPatch;
        if (req.params.id) {
            let flag = false
            const newDataObj = dataObj.map((post) => {
                if (post.id == req.params.id) {
                    flag = true;
                    postPatch = {
                        ...post,
                        ...req.body
                    }
                    return {
                        ...post,
                        ...req.body
                    }
                }
                return post
            })

            fs.writeFile(path.join(__dirname, "posts.json"), JSON.stringify(newDataObj), (err) => {
                if (err) {
                    return res.status(500).json(
                        {
                            message: "Ghi file thất bại!"
                        }
                    )
                }
                return
            })
            if (!flag) {
                return res.status(500).json({
                    message: req.params.id + " - khong ton tai "
                })
            }


            return res.status(200).json(
                {
                    message: "patch thanh cong" + req.params.id,
                    data: postPatch
                })
        }

    })
})

router.delete('/:postsId', (req, res) => {
    if (req.params.postsId) {
        fs.readFile(path.join(__dirname, "posts.json"), 'utf-8', (err, data) => {
            if (err) {
                return res.status(500).json({
                    message: "Lấy post thất bại!"
                })
            }
            let posts = JSON.parse(data);
            posts = posts.filter(post => post.id != req.params.postsId);

            fs.writeFile(path.join(__dirname, "posts.json"), JSON.stringify(posts), (err) => {
                if (err) {
                    return res.status(500).json({
                        message: "Lưu file thất bại!"
                    })
                }
                return res.status(200).json({
                    message: "Xóa post thành công!"
                })
            })
        })
    } else {
        return res.status(500).json(
            {
                message: "Vui lòng truyền usersId!"
            }
        )
    }
})
module.exports = router