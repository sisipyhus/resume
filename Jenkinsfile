// 流水线的脚本（声明式和脚本式，常用的是声明式）
pipeline {
    // 全部的 CI、CD 流程都需要在这里定义

    // 任何一个代理可用，就能执行（多机器）。但是，目前是单机，所以只会在本地执行。固定写法。
    agent any

    // 定义一些环境信息
    environment {
    ALIYUN_SECRET = credentials("636c9f3f-593a-4aef-8e0d-ba25183c5539")
    REGISTRY = 'registry.cn-hangzhou.aliyuncs.com'
    ALIYUNNAMESPACE = 'cancel_jenkins/blog'
    IMAGE_NAME="resume"                    // 镜像名一般和项目名相同
    IMAGE_ADDR="${ALIYUNNAMESPACE}/${IMAGE_NAME}"    // 镜像的位置
    VERSION_ID="${BUILD_ID}"
    }

    // 定义流水线的加工流程
    stages { // 流水线的阶段
        // 环境检查
        stage('环境检查') {
            steps { // 步骤：要做的所有事情
                echo "环境检查..."
                sh 'docker version'
            }
        }

        // 生成镜像
        stage('生成镜像') {
            steps { // 步骤
                echo "生成镜像..."
                sh '''
                old_image_id=`docker images|grep ${IMAGE_NAME}|grep ${VERSION_ID}|awk '{print $3}'`
                    if [ -n "${ole_image_id}" ]; then
                        docker rmi -f "${ole_image_id}"
                    fi
                '''
                //在生成镜像之前需要判断是否已经存在当前镜像
                sh 'docker build -t ${IMAGE_NAME}:${VERSION_ID} .'
            }
        }
        // 推送镜像
        // stage("推送镜像"){
        //     steps{
        //         sh "docker login -u ${ALIYUN_SECRET_USR} -p ${ALIYUN_SECRET_PSW} ${REGISTRY}"
        //         sh "docker tag blog:0.1 ${REGISTRY}/${ALIYUNNAMESPQCE}:0.1"
        //         sh "docker push ${REGISTRY}/${ALIYUNNAMESPQCE}:0.1"
        //     }
        // }
        // // 启动容器
        stage('启动容器') {
            steps { // 步骤
                echo "启动容器..."
                //删除已经运行的容器
                sh '''
                    container_id=`docker ps|grep ${IMAGE_NAME} |awk '{print $1}'`
                    if [ -n "${container_id}" ]; then
                            docker stop "${container_id}" && docker rm "${container_id}"
                    fi
                '''
                // sh 'docker rmi -f ${REGISTRY}/${ALIYUNNAMESPQCE}:0.1'
                // sh 'docker pull ${REGISTRY}/${ALIYUNNAMESPQCE}:0.1'
                sh 'docker run -d -p 3000:80 --name ${IMAGE_NAME}${VERSION_ID} ${IMAGE_NAME}:${VERSION_ID}'
            }
        }
    }
}