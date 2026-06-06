/**
 * 基于原生 fetch 封装的请求工具
 * 挂载到 Vue 全局属性 $request 上
 */

const BASE_URL = 'http://localhost:9999'

async function request(url, options = {}) {
  // 分离 params（fetch 不认识）
  const { params, ...fetchOptions } = options

  // 自动从 localStorage 读取 token 并注入请求头
  const token = localStorage.getItem('token')
  const authHeaders = {}
  if (token) {
    authHeaders['token'] = token
  }

  const config = {
    headers: {
      'Content-Type': 'application/json',
      ...authHeaders,
      ...options.headers,
    },
    ...fetchOptions,
  }

  // 处理 GET/DELETE 请求参数拼接到 URL
  let fullUrl = `${BASE_URL}${url}`
  if (params) {
    const query = new URLSearchParams()
    Object.entries(params).forEach(([key, value]) => {
      if (value !== undefined && value !== null && value !== '') {
        query.append(key, value)
      }
    })
    const qs = query.toString()
    if (qs) fullUrl += `?${qs}`
  }

  let response
  try {
    response = await fetch(fullUrl, config)
  } catch (e) {
    // 网络错误：后端未启动 / 端口不对 / 防火墙
    throw new Error(`无法连接后端服务(${BASE_URL})，请确认 Spring Boot 已启动`)
  }

  // 检查 HTTP 状态码
  if (!response.ok) {
    const text = await response.text().catch(() => '')
    throw new Error(`HTTP ${response.status}: ${text || response.statusText}`)
  }

  // 解析 JSON 响应
  let data
  try {
    data = await response.json()
  } catch {
    throw new Error('后端返回格式异常，无法解析 JSON')
  }

  // 业务状态码检查
  if (data.code === '200') {
    return data
  } else {
    // 401 表示 token 失效，清除并跳转登录
    if (data.code === '401') {
      localStorage.removeItem('token')
      localStorage.removeItem('userEmail')
      // 非登录页才跳转，避免死循环
      if (!window.location.href.includes('/login')) {
        window.location.href = '/login'
      }
    }
    throw new Error(data.msg || '请求失败')
  }
}

// 便捷方法
request.get = (url, params) => request(url, { method: 'GET', params })
request.post = (url, data) => request(url, { method: 'POST', body: JSON.stringify(data) })
request.put = (url, data) => request(url, { method: 'PUT', body: JSON.stringify(data) })
request.delete = (url, params) => request(url, { method: 'DELETE', params })

export default request
